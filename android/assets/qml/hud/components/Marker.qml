import QtQuick 2.0
import QtLocation 5.0

MapQuickItem {
    id: root
    property alias symbol:symbol.source
    property string name
    property string type

    anchorPoint.x: pin.width/2
    anchorPoint.y: pin.height

    sourceItem: Image {
        id: pin
        source: "qrc:/pins/blue"
        Image{
            id: symbol
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

        }

        MapMouseArea{
            anchors.fill:parent
            onClicked: {
                poiInfo.visible=true
                poiInfo.debug1="Name:"
                poiInfo.debug2=name
                poiInfo.debug3="Type:"
                poiInfo.debug4=type
            }
        }
    }
}
