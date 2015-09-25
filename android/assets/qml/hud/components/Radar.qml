import QtQuick 2.0
import RadarItem 1.0

RadarItem{
    id: mainarea
    property int margin: 10
    default property alias points: pointsContainer.children

    height: radius*2
    width: height
    anchors { top: parent.top;left: parent.left;margins: margin }

    Image{
        source: "qrc:/radar_base"
        anchors.centerIn: parent
    }

    Item{        
        id: pointsContainer
        anchors.fill: parent

        Connections{
            target:hudcontainer
            onAddPOIToHUD: {
                var exists=false
                for (var i = 0; i < pointsContainer.children.length; ++i){
                    if (pointsContainer.children[i].objectName=="dot"+p.sourceId)
                        exists=true
                }
                if (!exists){
                    Qt.createQmlObject("RadarPoint{id: dot"+p.sourceId+"; objectName: \"dot"+p.sourceId+"\"; }",pointsContainer)
                }
            }
        }
    }


    Image{
        source: "qrc:/radar_top"
        anchors.centerIn: parent
    }

/*
    //External circle
    Rectangle{
        radius: parent.radius
        height: radius*2
        width: height
        color: "transparent"
        border.color: "red"
        border.width: 5
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 0
    }
    */
}
