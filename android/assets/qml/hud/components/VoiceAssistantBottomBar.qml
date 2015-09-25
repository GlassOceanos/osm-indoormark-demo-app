import QtQuick 2.0

Item{
    id: root
    property int boxMargin:12
    property int buttonHeight:60
    property int buttonWidth:buttonHeight*1.6

    signal changeMapProvider

    height: 120

    FlatButton{
        id:closeIcon
        height: buttonHeight
        width: buttonWidth
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 20
        icon: "qrc:/icons24/grey-cross"
        iconSize: height/2
        onClicked: {
            voiceAssistant.state="ready"
            root.state="ready"
            voiceAssistant.visible=false
        }

    }

    FlatButton{
        id: captureButton
        height: buttonHeight
        width: buttonWidth
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        icon: "qrc:/icons24/red-dot"
        iconSize: height/2
        onClicked: {
            voiceAssistant.state="processing"
            root.state="processing"
        }
    }

    FlatButton{
        id: stopButton
        visible: false
        height: buttonHeight
        width: buttonWidth
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        icon: "qrc:/icons24/stop"
        iconSize: height/2

        onClicked: {
            voiceAssistant.state="ready"
            root.state="ready"
        }
    }

    states: [
           State {
               name: "ready"
               PropertyChanges { target: captureButton; visible: true }
               PropertyChanges { target: stopButton; visible: false }
               PropertyChanges { target: closeIcon; visible: true }
           },
        State {
            name: "processing"
            when: selected
            PropertyChanges { target: captureButton; visible: false }
            PropertyChanges { target: stopButton; visible: true }
            PropertyChanges { target: closeIcon; visible: true }
        },
        State {
            name: "options"
            when: selected
            PropertyChanges { target: captureButton; visible: false }
            PropertyChanges { target: stopButton; visible: false }
            PropertyChanges { target: closeIcon; visible: false }
        }
       ]
}
