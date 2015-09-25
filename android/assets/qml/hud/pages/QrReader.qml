import QtQuick 2.0
import "../components"

Item {
    id: root
    anchors.fill: parent

    Image{
        id: fakeCamera
        anchors.fill:parent
        source:"qrc:/outdoor"
    }

    //Trick to do a transparent "hole" in the screen
    Rectangle{
        id:maskCircle
        anchors.centerIn: parent
        width:2*Math.sqrt(Math.pow(root.width/2,2)+Math.pow(root.height/2,2))
        height:width
        radius: height
        color:"transparent"
        border.color:"black"
        border.width: (width-300)/2
        opacity: 0.7

    }

    Text{
        text: qsTr("Center QR code")
        width: parent.width
        color: "white"
        anchors.top: parent.top
        anchors.topMargin: 20
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 24
    }

    Image{
        anchors.centerIn: maskCircle
        source: "qrc:/icons24/red-dot"
        height: 40
        width: 40
    }

    QRBottomBar{
        id: qrBottomBar
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

}
