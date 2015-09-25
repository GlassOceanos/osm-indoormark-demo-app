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


    MapFloorSelector{
        id: flickFloors
        height: parent.height
        width: 180
        contentWidth: 400
        anchors.centerIn: parent
        visible:nmap.zoomLevel>16
        lLimit:actionsTools.width
        rLimit:lLimit+width
    }

    Row{
        id: actionsTools
        anchors.left: parent.left
        anchors.right: flickFloors.left
        height: parent.height
        anchors.margins:5
        spacing: 5

        Icon{
            id: centerMap
            height: buttonHeight
            width: height
            icon: "qrc:/icons24/marker-white"
            iconSize: 40
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                nmap.center.latitude= hud.coordinate.latitude
                nmap.center.longitude= hud.coordinate.longitude
                nmap.queryData()
            }
        }

        Icon{
            id: wayButton
            height: buttonHeight
            width: height
            icon: "qrc:/icons24/way"
            iconSize: 40
            anchors.verticalCenter: parent.verticalCenter
        }

        Icon{
            id: poiButton
            height: buttonHeight
            width: height
            icon: "qrc:/icons24/poi"
            iconSize: 40
            anchors.verticalCenter: parent.verticalCenter
            onClicked:  { mapPanel.visible=false; hud.visible=true}
        }

    }

    Item{
        id: sliderItem
        anchors.right: parent.right
        width:250
        height:parent.height
        Slider{
            id: zoomSlider;
            anchors.rightMargin:12
            minimum: nmap.minimumZoomLevel;
            maximum: nmap.maximumZoomLevel;
            opacity: 1
            width:200

            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            value: nmap.zoomLevel

            Binding {
                target: zoomSlider; property: "value"; value: nmap.zoomLevel
            }

            onValueChanged: {
                nmap.zoomLevel = value
            }
        }
    }
  }
