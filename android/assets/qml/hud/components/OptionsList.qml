import QtQuick 2.0

Item{
    id:root
    property string background: "black"   // Menu background color
    property string highlight: "black"    // Highlighted item color
    property alias items: itemsColumn.data
    property alias title: title.text

    signal close()

    Rectangle{
        color: background
        opacity:0.3
        anchors.fill: parent
    }

    Rectangle{
        id:topBar
        width:parent.width
        height:80
        anchors.top:parent.top
        Text{
            id: title
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Quizá quisiste decir:")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 24
        }

        Icon{
            id:closeIcon
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 20
            height:60
            width: 60
            iconSize: 40
            icon:"qrc:/icons24/grey-cross"
            onClicked: root.close()
        }
    }

    Column {
        id: itemsColumn
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        /*OptionsItem {
            text: qsTr("Ir al parking")
        }

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
        }*/
    }
}
