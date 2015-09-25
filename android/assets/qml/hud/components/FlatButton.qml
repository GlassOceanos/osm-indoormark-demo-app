import QtQuick 2.0

Rectangle {
    property alias icon: buttonIcon.source
    property alias text: buttonText.text
    property int iconSize: 24
    property int fontSize: 18

    signal clicked
    opacity: 1

    radius:4
    height: 64
    width: 64

    Image{
        id: buttonIcon
        height: iconSize
        width: iconSize
        anchors.centerIn: parent
    }

    Text{
        id: buttonText
        anchors.centerIn: parent
        opacity: 1
        font { pixelSize: fontSize}
        color: "darkgrey"
        font.bold: true
        visible: text.length>0
    }


    MouseArea{
        id: clickArea
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
