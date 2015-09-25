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

    Column{
        id: readyColumn
        height:200
        width: parent.width
        anchors.centerIn: parent
        spacing:25
        Image{
            width: 80
            height: 150
            anchors.horizontalCenter: parent.horizontalCenter
            source:"qrc:/mic"
        }

        Text{
            text: qsTr("Push \"Rec Button\" and start talking... ")
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }
    }

    Column{
        id: processingColumn
        height:300
        width: parent.width
        anchors.centerIn: parent
        spacing:50
        visible:false

        Text{
            text: qsTr("Processing... ")
            color: "white"
            height:30
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }

        Icon{
            iconSize: 80
            anchors.horizontalCenter: parent.horizontalCenter
            icon:"qrc:/processing"
            onClicked: {
                qrBottomBar.state="options"
                root.state="options"
            }
        }
    }

    OptionsList{
        id: optionsList
        anchors.fill: parent
        onClose: {
            root.state="ready"
            qrBottomBar.state="ready"
        }

        items{
            OptionsItem {
                text: qsTr("Reservar plaza en el parking")
            }

            OptionsItem {
                text: qsTr("Visitar librería")
            }

            OptionsItem {
                text: qsTr("Museo nacional")
            }

            OptionsItem {
                text: qsTr("Museo neoclásico")
            }

            OptionsItem {
                text: qsTr("Información sobre el parking")
            }

            OptionsItem {
                text: qsTr("Ir al rectorado")
            }
        }
    }

    VoiceAssistantBottomBar{
        id: qrBottomBar
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    state: "ready"
    states: [
        State {
            name: "ready"
            PropertyChanges { target: readyColumn; visible: true }
            PropertyChanges { target: processingColumn; visible: false }
            PropertyChanges { target: optionsList; visible: false }
        },
        State {
            name: "processing"
            PropertyChanges { target: readyColumn; visible: false }
            PropertyChanges { target: processingColumn; visible: true }
            PropertyChanges { target: optionsList; visible: false }
        },
        State {
            name: "options"
            PropertyChanges { target: readyColumn; visible: false }
            PropertyChanges { target: processingColumn; visible: false }
            PropertyChanges { target: optionsList; visible: true }
        }
    ]

}
