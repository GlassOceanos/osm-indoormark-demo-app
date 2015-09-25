import QtQuick 2.0
import "../components"

Item {
    id:root
    signal closed()
    property string background: "black"   // Menu background color
    property string highlight: "lightgrey"    // Highlighted item color

    function close(){
        //visible=false
        x=-width
        closed()
    }

    function open(){
        x=0
    }

    width: parent.width
    height: parent.height
    visible: false
    x: -width

    Rectangle{
        color: background
        height: root.height
        width: root.width
        opacity: 0.75
    }


    MainMenuInfoArea{
        id: infoArea
        text: "Sophie Limberk"
        onClose: root.close()
    }

    Column {
        anchors.top: infoArea.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        OptionsItem {
            id: mapLabel
            text: qsTr("Report an issue")
            //icon: "qrc:/icons80/close-session"
            onClicked: {mapPanel.visible=true; root.close()}

        }

        OptionsItem {
            id: aboutLabel
            //icon: "qrc:/icons80/close-session"
            text: qsTr("About")
        }

        OptionsItem {
            id: configLabel
            //icon: "qrc:/icons80/close-session"
            text: qsTr("Configuration")
            onClicked: {
                if (root.state=="option1")
                    root.state="option2"
                else
                    root.state="option1"
            }
        }

        OptionsItem {
            id: helpLabel
            //icon: "qrc:/icons80/close-session"
            text: qsTr("Help")
        }

        OptionsItem {
            id: quitLabel
            //icon: "qrc:/icons80/close-session"
            text: qsTr("Close session")
        }

    }


    Item{
            id: closeArea
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.left: parent.right
            width:80
            MouseArea{
                anchors.fill: parent
                onClicked: {close() }
            }
       }


    Behavior on x {
        NumberAnimation { duration: 100 }
    }

    onXChanged: {
        if (x==-width)
            visible=false
        else visible=true
    }


    state: "option1"
    states: [
        State {
            name: "option1"
            PropertyChanges { target: root; width: root.parent.width }
            PropertyChanges { target: closeArea; visible: false }
            PropertyChanges { target: infoArea; showCloseIcon: true}
        },
        State {
            name: "option2"
            PropertyChanges { target: root; width:root.parent.width -closeArea.width }
            PropertyChanges { target: closeArea; visible: true }
            PropertyChanges { target: infoArea; showCloseIcon: false}
        }
    ]

}

