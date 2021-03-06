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

Rectangle{
    id:root
    property alias text: label.text
    property alias icon: icon.source
    property string highlightColor: "#454547"
    property string backgroundColor: "#535355"
    property string fontColor: "white"          // Font color
    property int fontSize: 20                   // Font size
    signal clicked

    height:64
    width: parent.width
    color: backgroundColor

    Row{
        anchors.fill: parent
        spacing:20
        anchors.leftMargin: 10
        Image{
            id:icon
            width:48
            height:width
            anchors.verticalCenter: parent.verticalCenter

        }
        Text {
            id: label
            opacity: 1
            color: fontColor
            //font.bold: true
            font.pointSize: fontSize
            height: parent.height
            text: qsTr("Show map")
            verticalAlignment: Text.AlignVCenter
        }
    }


    Rectangle{
        id:line
        height:1
        width:parent.width
        anchors.bottom: parent.bottom
        color:highlightColor
    }

    MouseArea{
        anchors.fill: parent
        onClicked: root.clicked()
        onPressed: root.color=highlightColor
        onReleased: root.color=backgroundColor
    }
}
