import QtQuick 2.0

Item {
    property alias icon: buttonIcon.source
    property int iconSize: 24

    signal clicked

    height: 32
    width: 32

    Image{
        id: buttonIcon
        height: iconSize
        width: iconSize
        anchors.centerIn: parent
    }

    MouseArea{
        id: clickArea
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}

