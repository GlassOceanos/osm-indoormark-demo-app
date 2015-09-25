import QtQuick 2.0

Rectangle{
    id:root
    property alias text: label.text
    property alias icon: icon.source
    property string highlightColor: "#454547"
    property string backgroundColor: "#535355"
    property string fontColor: "white"          // Font color
    property int fontSize: 24                   // Font size
    signal clicked

    height:64
    width: parent.width
    color: backgroundColor

    Row{
        anchors.fill: parent
        spacing:20
        anchors.leftMargin: 10
        Image{
            id:icon
            width:48
            height:width
            anchors.verticalCenter: parent.verticalCenter

        }
        Text {
            id: label
            opacity: 1
            color: fontColor
            //font.bold: true
            font.pixelSize: fontSize
            height: parent.height
            text: qsTr("Show map")
            verticalAlignment: Text.AlignVCenter
        }
    }


    Rectangle{
        id:line
        height:1
        width:parent.width
        anchors.bottom: parent.bottom
        color:highlightColor
    }

    MouseArea{
        anchors.fill: parent
        onClicked: root.clicked()
        onPressed: root.color=highlightColor
        onReleased: root.color=backgroundColor
    }
}
