import QtQuick 2.0

Item{
    id: tools
    property int boxMargin:12
    property int buttonHeight:60
    property int buttonWidth:buttonHeight*1.6

    height: 90

    FlatButton{
        id: wayButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins:20
        height: buttonHeight
        width: buttonWidth
        icon: "qrc:/icons32/green-camera"
        iconSize: height/2
    }




    FlatButton{
        id:closeIcon
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins:20

        height: buttonHeight
        width:buttonWidth
        icon: "qrc:/icons24/grey-cross"
        iconSize: height/2
        onClicked: {qrReader.visible=false; mapPanel.visible=true}

    }
}
