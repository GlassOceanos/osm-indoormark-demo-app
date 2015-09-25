import QtQuick 2.0

Item{
    id: tools
    property int boxMargin:12
    property int buttonHeight:64

    signal changeMapProvider

    height: 70

    Rectangle{
        anchors.fill:parent
        color:"grey"
        opacity:0.3
    }

    Row{
        id: actionsTools
        anchors.left: parent.left
        anchors.right: closeIcon.left
        height: parent.height
        anchors.margins:5
        spacing: 5


        Icon{
            id: wayButton
            height: buttonHeight
            width: height
            icon: "qrc:/icons24/way"
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                infoPanel.text= "This is a test of infoPanel.When a timer is started, the first trigger is usually after the specified interval has elapsed. It is sometimes desirable to trigger immediately when the timer is started; for example, to establish an initial state.If triggeredOnStart is true, the timer is triggered immediately when started, and subsequently at the specified interval. Note that if repeat is set to false, the timer is triggered twice; once on start, and again at the interval."
                infoPanel.visible=true
            }
        }


    }

    Icon{
        id:closeIcon
        anchors.right: parent.right

        height: buttonHeight
        width: height
        icon: "qrc:close"
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {hud.visible=false; mapPanel.visible=true}

    }
}
