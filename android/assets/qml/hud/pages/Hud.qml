import QtQuick 2.0
import QtLocation 5.0
import QtMultimedia 5.0
import Hud 1.0
import "../components"

Hud{
    id: hudcontainer

    default property alias pois: poisContainer.children
    anchors.fill: parent

    function refresh(){
        var azi= azimuth()
        var bearing
        for (var i=0; i< pois.length; i++){
            if (pois[i].visible) {
                bearing = pois[i].getBearing(latitude,longitude)
                //coordinateToScreen(pois[i],azi,bearing)
                var screenP=coordinateToScreen(bearing)
                pois[i].x=screenP.x-pois[i].width/2
                pois[i].y=screenP.y+(pois[i].height*pois[i].yLevel+10)
                //pois[i].collisionDetection()
                var point=radar.drawPoint(pois[i].distance,azi,bearing)
                radar.points[i].x= point.x
                radar.points[i].y= point.y
            }
            radar.points[i].visible=pois[i].visible
        }
        debugInfo.debug1=latitude.toPrecision(7) + " " +longitude.toPrecision(7)
        debugInfo.debug2= accuracy.toPrecision(2)
        debugInfo.debug3="Calibration: "+ calibration.toPrecision(2) ;
        debugInfo.debug4="Azimut: "+ azi

        if (calibration==1)
            compassAlert.visible=false
        else
            compassAlert.visible=true

        if (accuracy>30)
            gpsAlert.visible=true
        else
            gpsAlert.visible=false
    }

    Image{
        id: fakeCamera
        anchors.fill:parent
        source:"qrc:/outdoor"
    }

    VideoOutput{
        id: vifdeo
        source:primaryCamera
        anchors.fill: parent
        focus : visible

        Camera {
            id: primaryCamera
            captureMode: Camera.CaptureViewfinder

            videoRecorder {
                resolution: "640x480"
                frameRate: 15
            }
            //focus: visible
            //x: 0Qt.platform.os
            //y: 0
            //width: screen.width
            //height: screen.height

            //captureResolution: Qt.size(screen.width,screen.height)
            /*Component.onCompleted: {
                console.log("Comprobando disponibilidad de la camara")
               // if (primaryCamera.availability!=Camera.Available)
                    //mapPanel.visible=true;
            }*/
        }

    }

    PinchArea{
        id: pinchZone
        anchors.fill: parent
        onPinchFinished: {
            if (pinch.scale >1){
                if (hudcontainer.range<40000)
                    hudcontainer.range=hudcontainer.range+5000
            }else{
                if (hudcontainer.range>10000)
                    hudcontainer.range=hudcontainer.range-5000
            }
            radar.range=hudcontainer.range
        }

    }

    Item{
        id: ui
        anchors.fill:parent

        Radar{
            id: radar
            radius: 60
            range: hudcontainer.range
        }

        Item{
            id: poisContainer
            anchors.fill: parent

            Connections{
                target:hudcontainer
                onAddPOIToHUD: {
                    var exists=false
                    for (var i = 0; i < poisContainer.children.length; ++i){
                        if (poisContainer.children[i].objectName==p.sourceId)
                            exists=true
                    }
                    if (!exists)
                        Qt.createQmlObject("Poi{id: poi"+p.sourceId+"; objectName: \""+p.sourceId+"\"; name:\""+p.name+"\"; latitude: "+p.latitude+"; longitude: "+p.longitude+" ; description: \""+p.description+"\" }",poisContainer)
                }
            }
        }

        Row{
            anchors.top: ui.top
            anchors.right: ui.right
            height: 40
            width: 260
            spacing:20
            Image{
                id: gpsAlert
                source: "qrc:/satellite"
                anchors.verticalCenter: parent.verticalCenter
                PropertyAnimation on opacity  {
                    easing.type: Easing.OutSine
                    loops: Animation.Infinite
                    from: 0
                    to: 1.0
                    duration: 1500
                }
            }
            Image{
                id: compassAlert
                source: "qrc:/compass"
                anchors.verticalCenter: parent.verticalCenter
                PropertyAnimation on opacity  {
                    easing.type: Easing.OutSine
                    loops: Animation.Infinite
                    from: 0
                    to: 1.0
                    duration: 1500
                }
            }

            Text{
                id: txtSpeed
                color: "white"
                font.pixelSize: 24
                font.bold: true
                text: Math.floor(speed*3.6) + " Km/h" // Km/h
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignRigh
            }

            Text{
                id: txtRange
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                font.pixelSize: 18
                font.bold: true
                text: range/1000 + " Km"
                horizontalAlignment: Text.AlignRigh
            }
        }


        ARInfoPanel{
            id: infoPanel
            visible:false
            anchors { bottom: mapBottomBar.top;left: parent.left; right: parent.right }
            height: mapBottomBar.height
        }

        ARBottomBar{
            id: mapBottomBar
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom


        }
    }

    //! Check if application is active, stop position updates if not
    /*
    Connections {
        target: Qt.application
        onActiveChanged: {
            if (Qt.application.active)
                start();
            else
                stop();
        }
    }*/

    //! Refresh the screen when compas changes its values
    onCompassReadingChanged: {
        refresh()
    }

    Component.onCompleted: {
        if (primaryCamera.availability!=Camera.Available)
            primaryCamera.start()
    }

}
