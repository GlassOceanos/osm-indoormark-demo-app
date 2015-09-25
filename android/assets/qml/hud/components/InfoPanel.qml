import QtQuick 2.0

BorderImage {
    id: infoPanel
    property alias debug1: dbgLabel1.text
    property alias debug2: dbgLabel2.text
    property alias debug3: dbgLabel3.text
    property alias debug4: dbgLabel4.text

    signal closed()


    border { left:8; top: 8; right: 8; bottom: 8 }
    horizontalTileMode: BorderImage.Stretch
    verticalTileMode: BorderImage.Stretch
    source: "qrc:/poibox_big"


    height: 90
    anchors { bottom: parent.bottom;left: parent.left; right: parent.right }

    Column {
        id: debugPosition
        anchors.fill:parent
        spacing: 16
        anchors.margins: 10
        Row {
            spacing: 20
            Text {
                id: dbgLabel1
                opacity: 1
                font { family: "Nokia Pure Text"; pixelSize: 24;}
                color: "white"
                font.bold: true
            }

            Text {
                id: dbgLabel2
                font { family: "Nokia Pure Text";pixelSize: 24 }
                color: "white"
                font.bold: true
            }
        }

        Row {
            spacing: 20
            Text {
                id: dbgLabel3
                opacity: 1
                font { family: "Nokia Pure Text"; pixelSize: 24;}
                color: "white"
                font.bold: true
            }

            Text {
                id: dbgLabel4
                font { family: "Nokia Pure Text";pixelSize: 24 }
                color: "white"
                font.bold: true
            }
        }

    }


    Image{
        source: "qrc:/close"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.topMargin: 10
        MouseArea{
            anchors.fill: parent
            onClicked: {closed();infoPanel.visible=false; }
        }
    }
}
