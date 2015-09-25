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

    OptionsList{
        id: optionsList
        anchors.fill: parent
        onClose: {
            root.visible=false
        }
        title: qsTr("Favoritos")

        items{
            OptionsItem {
                text: qsTr("Reservar plaza en el parking")
                icon: "qrc:/icons32/label"
                selector: "qrc:/icons32/white-strike-heart"
            }

            OptionsItem {
                text: qsTr("Visitar librería")
                icon: "qrc:/icons32/label"
                selector: "qrc:/icons32/white-strike-heart"
            }

            OptionsItem {
                text: qsTr("Museo nacional")
                icon: "qrc:/icons32/label"
                selector: "qrc:/icons32/white-strike-heart"
            }

            OptionsItem {
                text: qsTr("Museo neoclásico")
                icon: "qrc:/icons32/label"
                selector: "qrc:/icons32/white-strike-heart"
            }

            OptionsItem {
                text: qsTr("Información sobre el parking")
                icon: "qrc:/icons32/label"
                selector: "qrc:/icons32/white-strike-heart"
            }

            OptionsItem {
                text: qsTr("Ir al rectorado")
                icon: "qrc:/icons32/label"
                selector: "qrc:/icons32/white-strike-heart"
            }
        }
    }
}
