import QtQuick 2.0

BorderImage {
    property alias icon: buttonIcon.source
    property alias text: buttonText.text
    property int iconSize: 32
    property int fontSize: 24

    signal clicked

    border { left:8; top: 8; right: 8; bottom: 8 }
    horizontalTileMode: BorderImage.Stretch
    verticalTileMode: BorderImage.Stretch
    source: "qrc:/poibox_big"

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
        color: "white"
        font.bold: true
        visible: text.length>0
    }


    MouseArea{
        id: clickArea
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}

