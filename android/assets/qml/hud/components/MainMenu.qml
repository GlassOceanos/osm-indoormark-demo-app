import QtQuick 2.0

Item {
    id:root
    signal closed()
    property string background: "#535355"   // Menu background color
    property string highlight: "#454547"    // Highlighted item color

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

    Row{
        anchors.fill: parent
        Rectangle{
            color: background
            height: root.height
            width: root.width - closeArea.width

            Column {
                anchors.fill: parent

                MainMenuInfoArea{
                    text: "Sophie Limberk"
                }

                MainMenuItem {
                    id: mapLabel
                    text: qsTr("Report an issue")
                    icon: "qrc:/icons80/close-session"
                    onClicked: {mapPanel.visible=true; root.close()}

                }

                MainMenuItem {
                    id: aboutLabel
                    icon: "qrc:/icons80/close-session"
                    text: qsTr("About")
                }

                MainMenuItem {
                    id: configLabel
                    icon: "qrc:/icons80/close-session"
                    text: qsTr("Configuration")
                }

                MainMenuItem {
                    id: helpLabel
                    icon: "qrc:/icons80/close-session"
                    text: qsTr("Help")
                }

                MainMenuItem {
                    id: quitLabel
                    icon: "qrc:/icons80/close-session"
                    text: qsTr("Close session")
                }

            }
        }

        Item{
            id: closeArea
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            width:80
            MouseArea{
                anchors.fill: parent
                onClicked: {close() }
            }
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

}

