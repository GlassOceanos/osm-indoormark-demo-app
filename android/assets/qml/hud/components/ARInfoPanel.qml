import QtQuick 2.0

Rectangle {
    id: root
    property alias text: label.text
    signal closed()

    color: "#00b874"
    opacity:0.8

    Timer{
        id: timer
        interval:5000
        onTriggered: root.visible=false
    }

    Row {
        anchors.fill:parent
        spacing: 20
        anchors.leftMargin: 20

        Image{
            id:icon
            source: "qrc:/map-icons/symbols/24/train"
            anchors.verticalCenter: parent.verticalCenter

        }
        Flickable{
            flickableDirection: Flickable.VerticalFlick
            width: parent.width-icon.width
            height: parent.height
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            Text {
                id: label
                opacity: 1
                font { pixelSize: 14;}
                color: "white"
                wrapMode: Text.WordWrap
                width: parent.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    onVisibleChanged:{
        if (visible==true)
            timer.start()
    }

    /*
    Image{
        source: "qrc:/close"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.topMargin: 10
        MouseArea{
            anchors.fill: parent
            onClicked: {closed();root.visible=false; }
        }
    }
    */
}
