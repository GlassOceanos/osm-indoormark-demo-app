import QtQuick 2.0

Item{
    id: tools
    height: 64
    signal changeMapProvider

    Row{
        id: zoomTools
        anchors.left: parent.left
        height: parent.height
        anchors.margins:5
        spacing: 5

        Button{
            id: zoomIn
            icon: "qrc:/zoomin"
            onClicked:{
                nmap.zoomLevel=nmap.zoomLevel+1;
                if (nmap.zoomLevel>16)
                    nmap.queryIndoorData()
            }
        }

        Button{
            id: zoomOut
            icon: "qrc:/zoomout"
            onClicked: {
                nmap.zoomLevel=nmap.zoomLevel-1;
                nmap.queryData()
            }
        }

        Button{
            id: changeMap
            text:"M"
            onClicked: changeMapProvider()
        }

        Flickable{
            flickableDirection: Flickable.HorizontalFlick
            height: parent.height
            width: 50
            contentWidth: 250
            visible:nmap.zoomLevel>16
            Row{
                id: floorLevel
                anchors.left: parent.left
                height: parent.height
                anchors.margins:5
                spacing: 5

                Button{
                    id: sub1
                    text:"-1"
                    onClicked:{
                        nmap.queryIndoorData(-1)
                    }
                }

                Button{
                    id: level0
                    text:"0"
                    onClicked: {
                        nmap.queryIndoorData(0)
                    }
                }

                Button{
                    id: level1
                    text:"1"
                    onClicked: {
                        nmap.queryIndoorData(1)
                    }
                }
            }
        }
    }

    Button{
        id: closeButton
        anchors.right: parent.right
        anchors.margins:5
        icon: "qrc:/close"
        onClicked: { root.visible=false}

    }
}
