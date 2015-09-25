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

import QtQuick 2.0
import "../components"

Item {
    id:root
    property string background: "black"   // Menu background color
    property string highlight: "lightgrey"    // Highlighted item color
    signal closed()

    function close(){
        visible=false
        closed()
    }

    function open(){
        visible=true
    }

    width: parent.width
    height: parent.height
    visible: false

    Rectangle{
        color: background
        height: root.height
        width: root.width
        opacity: 0.75
    }

    Flickable{
        anchors.fill: parent
        contentWidth: parent.width; contentHeight: content.height+100
        Column {
            id:content
            anchors.top: parent.top
            //anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            spacing: 20

            Label {
                text: qsTr("This application is a demonstration of how to use the <a href=\"http://wiki.openstreetmap.org/wiki/Tag:indoormark%3Dbeacon\">indoormark tag</a> defined at Open Street Map <p>
<p>To use the app, press the camera button and point to a QR code tagged in OSM as explained in the mentioned page. If QR is found, the map will show you the position where the QR beacon is located.
<p>The application has been developed under the scope of the <a href=\"http://smartprojects.zed.com/?project=p1\">Ubica2</a> project by the <a href=\"http://smartprojects.zed.com/\">Smart Projects Group</a> at Zed")
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Image {
                source: "qrc:/ubica2-white"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            FlatButton {
                text:"Close";
                onClicked: close()
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

    }
}
