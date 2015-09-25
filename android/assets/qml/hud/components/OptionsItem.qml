import QtQuick 2.0

Item{
    id:root
    property alias text: label.text
    property alias icon: icon.source
    property alias selector: selector.icon
    property string highlightColor: "#606060"
    property string backgroundColor: "black"
    property string fontColor: "white"          // Font color
    property int fontSize: 24                   // Font size
    signal clicked

    height:60
    width: parent.width
    Rectangle{
        id: background
        anchors.fill:parent
        color: backgroundColor
        opacity: 0.5
    }

    Row{
        anchors.fill: parent
        spacing:20
        anchors.leftMargin: 10
        Image{
            id:icon
            width:root.icon? 48 : 0
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
            width:parent.width-icon.width-selector.width
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
        id: mArea
        anchors.fill: parent
        onClicked: {root.clicked();}
    }


    Icon{
        id:selector
        width:root.selector? 60 : 0
        height:width
        iconSize: 40
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }

    state: "normal"
    states: [
        State {
            name: "normal"
            when: !mArea.pressed
            PropertyChanges { target: background; opacity: 0 }
        },
        State {
            name: "highlighted"
            when: mArea.pressed
            PropertyChanges { target: background; opacity:0.5 }
        }
    ]
}
