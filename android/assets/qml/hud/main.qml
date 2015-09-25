import QtQuick 2.0
import QtMultimedia 5.0

import QtQuick 2.0
//import QtMobility.sensors 1.2
import QtLocation 5.0
import "components"
import "pages"

Item {
    id: mainPage
    width: Qt.platform.os=="linux"? 800 : screen.width
    height:Qt.platform.os=="linux"? 480 : screen.height

    property string latitudeStr: "RESOLVING"
    property string longitudeStr: "RESOLVING"
    //property Coordinate currentCoord


    Hud{
        id: hud
        range: 25000
        visible:false
        //pois: [
        //    Poi{id: alziraPOI; name:"Alzira"; latitude: 39.15; longitude: -0.435}
        //    ,Poi{id: aquaPOI; name: "Aqua es un nombre corto"; latitude: 39.456591; longitude: -0.346258}
        //    ,Poi{id: alcorconPOI; name: "Alcorcon"; latitude: 40.350557;longitude:-3.823206}
        // ]
    }

    MapPanel{
        id: mapPanel
        anchors.fill: parent
        visible: true
    }

    History{
        id:historyPage
        visible: false
    }

    Favourites{
        id:favouritesPage
        visible: false
    }

    QrReader{
        id: qrReader
        visible: false
    }

    VoiceAssistant{
        id: voiceAssistant
        visible: false
    }

    Search{
        id: searchPage
        visible: false
    }

    MainMenu{
        id: mainMenu
    }

    //! We stop retrieving position information when component is to be destroyed
    Component.onDestruction: {
        hud.stop();
    }



}
