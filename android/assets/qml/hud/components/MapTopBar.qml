import QtQuick 2.0

Item{
    id: tools
    property int boxMargin:10
    property int buttonHeight:64

    height:70
    Rectangle{
        anchors.fill:parent
        color:"white"
        opacity:0.7
    }

    Icon{
        id: config
        anchors.left: parent.left
        height: buttonHeight
        width: height
        //anchors.margins:boxMargin
        icon: "qrc:/icons32/app-menu-button"
        iconSize: 40
        anchors.verticalCenter: parent.verticalCenter
        onClicked: mainMenu.open()
    }


    Row{
        id: menuTools
        anchors.right: parent.right
        anchors.left: config.right
        height: parent.height
        anchors.margins:boxMargin
        layoutDirection: Qt.RightToLeft
        spacing: 10

        Icon{
            id: searchButton
            height: buttonHeight
            width: height
            icon: "qrc:/icons32/search"
            iconSize: 40
            anchors.verticalCenter: parent.verticalCenter
            onClicked:  { searchPage.visible=true;}
        }

        Icon{
            id: cameraButton
            height: buttonHeight
            width: height
            icon: "qrc:/icons32/camera"
            iconSize: 40
            anchors.verticalCenter: parent.verticalCenter
            onClicked: { mapPanel.visible=false; qrReader.visible=true}
        }

        Icon{
            id: mapButton
            height: buttonHeight
            width: height
            icon: "qrc:/icons32/map"
            iconSize: 40
            anchors.verticalCenter: parent.verticalCenter
            onClicked:  { mapPanel.visible=true; hud.visible=false}
        }

        Icon{
            id: heartButton
            height: buttonHeight
            width: height
            icon: "qrc:/icons32/heart"
            iconSize: 40
            anchors.verticalCenter: parent.verticalCenter
            onClicked: { favouritesPage.visible=true}
        }

        Icon{
            id: clockButton
            height: buttonHeight
            width: height
            icon: "qrc:/icons32/clock"
            iconSize: 40
            anchors.verticalCenter: parent.verticalCenter
            onClicked: { historyPage.visible=true}
        }
    }

}
