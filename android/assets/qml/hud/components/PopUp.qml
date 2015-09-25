import QtQuick 2.0

Rectangle {
    id: popup
    property alias debug1: dbgLabel1.text
    property alias debug2: dbgLabel2.text
    property alias debug3: dbgLabel3.text
    property alias debug4: dbgLabel4.text
    property int fontSize: 24

    signal closed()


    radius:10
    color:"transparent"
    border.color: "white"
    border.width: radius

    height: 200
    width: 500
    anchors.centerIn: parent

    Rectangle{
        anchors.centerIn: parent
        radius:parent.radius
        height:parent.height-radius
        width:parent.width-radius
        color:"grey"
        opacity:0.3
    }

    Column {
        id: debugPosition
        anchors.fill:parent
        spacing: 16
        anchors.margins: closeButton.height
        Row {
            spacing: 20
            Text {
                id: dbgLabel1
                opacity: 1
                font { pixelSize: fontSize}
                color: "white"
                font.bold: true
            }

            Text {
                id: dbgLabel2
                font { pixelSize: fontSize }
                color: "white"
                font.bold: true
            }
        }

        Row {
            spacing: 20
            Text {
                id: dbgLabel3
                opacity: 1
                font { pixelSize: fontSize}
                color: "white"
                font.bold: true
            }

            Text {
                id: dbgLabel4
                font { pixelSize: fontSize }
                color: "white"
                font.bold: true
            }
        }

    }


    Image{
        id:closeButton
        height:32
        width: 32
        source: "qrc:/close"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.topMargin: 10
        MouseArea{
            anchors.fill: parent
            onClicked: {closed();popup.visible=false; }
        }

    }
}
