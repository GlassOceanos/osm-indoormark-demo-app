/****************************************************************************
**
** Copyright (C) 2015 Zed Worldwide, S.A.
** http://www.zed.com/es/quienes-somos/investigacion-desarrollo
**
** This file is part of the examples of the Ubica2 Project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Zed Worldwide, S.A. nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
#include "osmquery.h"
#include <QDebug>

OSMQuery::OSMQuery(QObject *parent) :
    QObject(parent)
{
    this->filename="result.xml";
}

OSMQuery::OSMQuery(QUrl url, QString file, QObject *parent):
    QObject(parent)
{
    this->url=url;
    this->filename=file;
}

void OSMQuery::query()
{
    QNetworkAccessManager *manager= new QNetworkAccessManager();

    QString file_path=filename;
    if (downloadpath.length()>0)
        file_path=downloadpath+filename;
    file.setFileName(file_path);
    file.open(QIODevice::WriteOnly);
    QNetworkRequest *request= new QNetworkRequest(QUrl(url));
    request->setRawHeader("User-Agent", "OSM Test 0.1");
    reply = manager->get(*request);
    connect(reply, SIGNAL(finished()), SLOT(downloadFinished()));
    connect(reply, SIGNAL(readyRead()), SLOT(downloadReadyRead()));
    connect(reply,SIGNAL(downloadProgress(qint64,qint64)),SLOT(downloadProgress(qint64,qint64)));
    connect(reply,SIGNAL(error(QNetworkReply::NetworkError)),SLOT(displayError(QNetworkReply::NetworkError)));
    qDebug()<< "Downloading file "<< url.toString().toLatin1();
}

void OSMQuery::downloadProgress(qint64 bytesReceived, qint64 bytesTotal)
{
    emit (downloadProgress(100*bytesReceived/bytesTotal));

}

void OSMQuery::downloadFinished()
{
    file.close();
    QVariant possible_redirect=reply->attribute(QNetworkRequest::RedirectionTargetAttribute);
    if (!possible_redirect.toUrl().toString().isEmpty() && possible_redirect.toUrl()!=url){
        url=possible_redirect.toUrl().toString();
        query();
    }
    else
    {
        emit (fileDownloaded());
        parseXML();
    }
}

void OSMQuery::downloadReadyRead()
{
    file.write(reply->readAll());
}

void OSMQuery::displayError(QNetworkReply::NetworkError err){
    qDebug()<<"Error downloading file" << err;
}

void OSMQuery::parseXML() {
    /* We'll parse the xml */
    bool found = false;
    QFile* file = new QFile("result.xml");

    /* If we can't open it, let's show an error message. */
    if (!file->open(QIODevice::ReadOnly | QIODevice::Text)) {
        qErrnoWarning("Couldn't open xml resource");
        return;
    }
    /* QXmlStreamReader takes any QIODevice. */
    QXmlStreamReader xml(file);
    /* We'll parse the XML until we reach end of it.*/
    while(!xml.atEnd() && !xml.hasError()) {
        /* Read next element.*/
        QXmlStreamReader::TokenType token = xml.readNext();
        /* If token is just StartDocument, we'll go to next.*/
        if(token == QXmlStreamReader::StartDocument) {
            continue;
        }
        /* If token is StartElement, we'll see if we can read it.*/
        if(token == QXmlStreamReader::StartElement) {
            /* If it's named persons, we'll go to the next.*/
            if(xml.name() == "node") {
                found=true;
                emit  positionFound(xml.attributes().value("lat").toString() ,xml.attributes().value("lon").toString() );
            }
        }
    }
    /* Error handling. */
    if(xml.hasError()) {
        qErrnoWarning("ERROR!!!!: " + xml.errorString().toLatin1());
    }
    /* Removes any device() or data from the reader
     * and resets its internal state to the initial state. */
    file->close();
    xml.clear();

    if (!found)
        emit(unknownPosition());
}
