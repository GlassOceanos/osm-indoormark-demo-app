import QtQuick 2.0

Rectangle{
    id: topArea
    property alias text: label.text
    property bool showCloseIcon
    property string bottomLineColor: "#454547"
    property string backgroundColor: "white"
    property string fontColor: "black"          // Font color
    property int fontSize: 24                   // Font size
    signal close

    height: 130
    width: parent.width
    color: backgroundColor

    Column{
        anchors.fill: parent
        spacing:10
        anchors.margins: 20
        Image{
            id:icon
            width:64
            height:width
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/sophie"

        }
        Text {
            id: label
            opacity: 1
            color: fontColor
            font.pixelSize: fontSize
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Image{
        id:logo
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.topMargin: 10
        source: "qrc:/logo"

    }


    Icon{
        id:closeIcon
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 10
        anchors.topMargin: 10
        visible:showCloseIcon
        height:60
        width: 60
        iconSize: 40
        icon:"qrc:/icons24/grey-cross"
        onClicked: root.close()
    }

    Rectangle{
        id:line
        height:1
        width:parent.width
        anchors.bottom: parent.bottom
        color:bottomLineColor
    }
}
