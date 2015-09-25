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
/*!
 * @class OSMQuery
 *
 */

#ifndef OSMQUERY_H
#define OSMQUERY_H

#include <QObject>
#include <QFile>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QGeoCoordinate>
#include <QXmlStreamReader>
#include <QMap>

//using namespace QtMobility;
class OSMQuery : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl url READ get_url WRITE set_url NOTIFY urlChanged) /*!<  */

public:
    explicit OSMQuery(QObject *parent = 0);    

    explicit OSMQuery(QUrl url, QString file, QObject *parent = 0);
    
    /** @brief simple access function to set the attribute url by function
      * @param value value to set for the attribute url
      */
    void set_url( QUrl value ) { url = value; }

    /** @brief simple access function to get the attribute url by function */
    QUrl get_url( void ) const { return url; }

    /** @brief simple access function to set the attribute filename by function
      * @param value value to set for the attribute filename
      */
    void set_filename( QString value ) { filename = value; }

    /** @brief simple access function to get the attribute filename by function */
    QString get_filename( void ) const { return filename; }

    /** @brief simple access function to set the attribute filename by function
      * @param value value to set for the attribute filename
      */
    void set_downloadpath( QString value ) { downloadpath = value; }

    /** @brief simple access function to get the attribute filename by function */
    QString get_downloadpath( void ) const { return downloadpath; }

    /**
     * @brief Runs the query calling to the Open Street Map Server
     */
    Q_INVOKABLE void query();

signals:
    /**
     * @brief The result of the query is stored in a file. The signal is emitted when the file is closed
     */
    void fileDownloaded();
    
    /**
     * @brief Updates the download progress
      * @param progress value from 0 to 100
     */
    void downloadProgress(int);
    /**
     * @brief Emitted when the URL is changed
     */
    void urlChanged();
    /**
     * @brief Emits the latitude and longitude whe the query success
     * @param lat Latitude of the coordinate
     * @param lon longitude of the coordinate
     */
    void positionFound(QString lat, QString lon);
    /**
     * @brief Emitted when the QR tag is not found in Open Street Map
     */
    void unknownPosition();

 private:
    QFile file;
    QNetworkReply *reply;
    QUrl url;
    QString filename;

    QString downloadpath;


private slots:
    /**
     * @brief Reads the reply object
     */
    void downloadReadyRead();
    void downloadProgress(qint64,qint64);
    void displayError(QNetworkReply::NetworkError);
    /**
     * @brief Checks if a redirection is needed and finishes the download closig the file
     */
    void downloadFinished();
    /**
     * @brief Parses the result of the query to OSM. Tries to find a node and its coordinates
     */
    void parseXML();

};

#endif // OSMQUERY_H
