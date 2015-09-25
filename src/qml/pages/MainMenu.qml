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
    signal closed()
    property string background: "black"   // Menu background color
    property string highlight: "lightgrey"    // Highlighted item color

    function close(){
        x=-width
        closed()
    }

    function open(){
        x=0
    }

    width: parent.width -closeArea.width
    height: parent.height
    visible: false
    x: -width

    Rectangle{
        color: background
        height: root.height
        width: root.width
        opacity: 0.75
    }

    MainMenuInfoArea{
        id: infoArea
        onClose: root.close()
    }

    Column {
        anchors.top: infoArea.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        OptionsItem {
            id: qrLabel
            text: qsTr("Scan a QR code")
            //icon: "qrc:/icons80/close-session"
            onClicked: {close(); qrReader.state="Scanning"}
        }

        OptionsItem {
            id: mapLabel
            text: qsTr("Map")
            //icon: "qrc:/icons80/close-session"
            onClicked: {close(); qrReader.state="Stopped";}

        }

        OptionsItem {
            id: aboutLabel
            //icon: "qrc:/icons80/close-session"
            text: qsTr("About")
            onClicked: {close(); aboutPage.open()}
        }
    }

    Item{
            id: closeArea
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.left: parent.right
            width:80
            MouseArea{
                anchors.fill: parent
                onClicked: {close()}
            }
       }


    Behavior on x {
        NumberAnimation { duration: 100 }
    }

    onXChanged: {
        if (x==-width)
            visible=false
        else visible=true
    }
}
