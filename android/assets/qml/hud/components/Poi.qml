import QtQuick 2.0
import QtLocation 5.0
import PoiBox 1.0

PoiBox{
    id: root
    property alias name: txtName.text
    property string textColor: "white"
    property int fontSize: 20
    property int margin: 10
    property int yLevel:0
    property bool overlapped: false

    visible: distance <hud.range
    state: "NORMAL"
    height:110; width:200;

    function collisionDetection(){//Collision detection
        if(x>0 && x<screen.width){ //If this box is visible in the screen
            var foreign = parent.childAt(x,y);
            if (foreign !== null && foreign.objectName !== '' && foreign.visible && foreign.objectName !== root.objectName){ //If the foreign item is valid
                if (foreign.y<y && foreign.y+foreign.height>y){ //Collision between boxes
                    console.log("    Colision de: >"+root.name + "< ("+x+","+y+","+z+") con >" + foreign.name+"< ("+foreign.x+","+foreign.y+","+foreign.z+") ("+foreign.x+","+foreign.y+","+foreign.height+")")
                    if (root.z>foreign.z){
                        console.log(root.objectName + "Está arriba")
                        textColor="white"
                        foreign.textColor="transparent"
                    }else{
                        textColor="transparent"
                        foreign.textColor="white"
                        overlapped=true;
                    }
                }
                else if (overlapped){
                    textColor="white"
                    overlapped=false
                }
            }
        }
    }

    Rectangle{
        anchors.centerIn: parent
        width: parent.width
        height:parent.height
        color: "grey"
        border.color: "white"
        radius:10
        border.width: radius
    }

    /*Image{
        id: poiboximg
        anchors.centerIn: parent
        source: "qrc:/poibox_big"
    }
*/
    Column{
        anchors.fill: parent
        spacing: 5
        anchors.margins: 10
        Row{
            anchors.leftMargin: 5
            spacing: 10
            Image {
                id: poiIcon
                source: "qrc:/peak"
            }

            Text {
                id: txtName
                color: textColor
                width:150
                font.pixelSize: fontSize
                font.bold: true
                elide:Text.ElideRight
                clip: true
            }
        }
        Row{
            anchors.leftMargin: 5
            spacing: 10
            Item{ //Currently only for spacing
                width:20
                height:width
            }
            Text {
                id: txtDistance
                color: textColor
                font.pixelSize: fontSize-2
                font.bold: true
                text:root.formattedDistance(distance)
            }
        }

        Row{
            anchors.leftMargin: 5
            spacing: 10
            Item{ //Currently only for spacing
                width:20
                height:width
            }
            Text {
                id: txtDescription
                color: textColor
                font.pixelSize: fontSize-2
                font.bold: true
                text: root.description
            }
        }
    }

    Flickable{
        id: pinchZone
        anchors.centerIn: parent
        width:parent.width
        height:parent.height
        flickableDirection: Flickable.VerticalFlick
        onFlickEnded: {
            console.log("***Desplazado: "+contentY + " vertical velocity "+ verticalVelocity)
            if(verticalVelocity>0 && yLevel<4){// && root.y<screen.height-root.height){
                yLevel++;
            }else if(verticalVelocity<0 && yLevel>-1){
                yLevel--;
            }
        }
    }


    states: [
        State {
            name: "BIG"
            PropertyChanges { target: root; height:110; width:200; fontSize:20}
            //PropertyChanges { target: poiboximg; source:"qrc:/poibox_big"}
        },
        State {
            name: "MEDIUM"
            PropertyChanges { target: root; height:90; width:180; fontSize:18}
            //PropertyChanges { target: poiboximg; source:"qrc:/poibox_medium"}
        },
        State {
            name: "SMALL"
            PropertyChanges { target: root; height:80; width:160; fontSize:16}
            //PropertyChanges { target: poiboximg; source:"qrc:/poibox_small"}
        }
    ]

    Connections{
        target: hud
        onCoordinateChanged: {
            updateDistance(hud.latitude,hud.longitude)
            if (distance<hud.range/3)
                root.state="BIG"
            else if (distance<2*hud.range/3)
                root.state="MEDIUM"
            else
                root.state="SMALL"

            if (visible)
                z=hud.range-distance //Just a trick to display nearer POIs on top

        }
    }
}
