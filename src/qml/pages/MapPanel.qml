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
import QtPositioning 5.5
import QtLocation 5.5
import "../components"

Item{
    id: root
    property alias latitude: nmap.center.latitude
    property alias longitude: nmap.center.longitude

    function showMessage(msg){
        popUpMessage.text=msg
        popUpMessage.visible=true
    }

    function hideMessage(){
        popUpMessage.visible=false
    }

    function addMarker(){
        nmap.clearMapItems()
        nmap.addMapItem(marker)
        marker.coordinate=nmap.center
        marker.visible=true
    }

    function clearMap(){
        popUpMessage.visible=false
        nmap.clearMapItems()
    }

    MapQuickItem{
        id: marker
        sourceItem: Image{source:"qrc:/icons64/pin"}
        visible:false

        anchorPoint.x:width/2
        anchorPoint.y:height

    }

    Plugin {
        id: osmPlugin
        name : "osm"

        PluginParameter { name: "osm.useragent"; value: "Ïndoormark test application" }
        //PluginParameter { name: "osm.mapping.host"; value: "xxxxxx" }
    }

    Map {
        id: nmap
        property variant container

        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        zoomLevel: 20  //OSM allows 18

        // Enable pinch gestures to zoom in and out
        gesture.flickDeceleration: 3000
        gesture.enabled: true

        plugin :osmPlugin
        center {latitude: 40.53847254;longitude: -3.89346777 } // U-TAD

    }

    MapTopBar{
        id: mapTopBar
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
    }

    MapBottomBar{
        id: mapBottomBar
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width:parent.width

    }

    PopUp{
        id:popUpMessage
        objectName: "popUpMessage"
        visible: false
    }
}
