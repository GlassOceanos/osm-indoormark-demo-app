import QtQuick 2.0
import "../components"

Item{
    id: root
    anchors.fill: parent

    Rectangle{
        id:background
        anchors.fill:parent

        color:"black"
        opacity: 0.7
    }

    Row{
        height:90
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins:20
        spacing:20

        Rectangle{
            height: 60
            width:parent.width*0.8
            anchors.verticalCenter: parent.verticalCenter
            radius: 4

            Image{
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/icons32/search"
            }

            TextInput{
                text: qsTr("Criterios de búsqueda... ")
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 24
                Keys.onReturnPressed:{Qt.inputMethod.hide(); }
            }
        }

        Icon{
            width: 60
            height: width
            anchors.verticalCenter: parent.verticalCenter
            icon:"qrc:/icons32/mic"
            onClicked: {root.visible=false; voiceAssistant.visible=true}
        }

    }
}
