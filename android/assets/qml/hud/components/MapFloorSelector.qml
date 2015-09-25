import QtQuick 2.0


Flickable{
    id: root
    property int lLimit: 0      //Item visibility right limit
    property int rLimit: width  //Item visibility leftt limit

    function calculateVisibility(item){
        var x1= floorLevel.mapToItem(mainPage,item.x,item.y).x
        var x2 = x1+item.width
        //console.log(item.text + ": " + lLimit + " " + x1 + " " + x2 + " " + rLimit)
        return lLimit < x1 && x2 < rLimit
    }

    flickableDirection: Flickable.HorizontalFlick
    boundsBehavior: Flickable.StopAtBounds

    /*Rectangle{
        anchors.fill:parent
        color:"red"
    }*/

    Item{
        id: floorLevel
        anchors.fill: parent
        //spacing: 5
        width:parent.contentWidth

        FlatButton{
            id: sub1
            text:"-1"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            height: 48; width:height
            visible: calculateVisibility(sub1)
            onClicked:{
                nmap.indoorLevel=-1
                nmap.queryIndoorData(-1)
            }
            Connections{
                target:root
                onContentXChanged:{
                    sub1.visible= calculateVisibility(sub1)
                }

            }
        }

        FlatButton{
            id: level0
            text:"0"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: sub1.right
            anchors.leftMargin: 5
            height: 48; width:height
            visible: calculateVisibility(level0)
            onClicked: {
                nmap.indoorLevel=0
                nmap.queryIndoorData(0)
            }
            Connections{
                target:root
                onContentXChanged: level0.visible= calculateVisibility(level0)
            }
        }

        FlatButton{
            id: level1
            text:"1"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: level0.right
            anchors.leftMargin: 5
            height: 48; width:height
            visible: calculateVisibility(level1)
            onClicked: {
                nmap.indoorLevel=1
                nmap.queryIndoorData(1)
            }
            Connections{
                target:root
                onContentXChanged: level1.visible= calculateVisibility(level1)
            }
        }


        FlatButton{
            id: level2
            text:"2"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: level1.right
            anchors.leftMargin: 5
            height: 48; width:height
            visible: calculateVisibility(level2)
            onClicked: {
                nmap.indoorLevel=2
                nmap.queryIndoorData(2)
            }
            Connections{
                target:root
                onContentXChanged: level2.visible= calculateVisibility(level2)
            }
        }

        FlatButton{
            id: level3
            text:"3"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: level2.right
            anchors.leftMargin: 5
            height: 48; width:height
            visible: calculateVisibility(level3)
            onClicked: {
                nmap.indoorLevel=3
                nmap.queryIndoorData()
            }
            Connections{
                target:root
                onContentXChanged: level3.visible= calculateVisibility(level3)
            }
        }

        FlatButton{
            id: level4
            text:"4"
            anchors.verticalCenter: parent.verticalCenter
            height: 48; width:height
            anchors.left: level3.right
            anchors.leftMargin: 5
            visible: calculateVisibility(level4)
            onClicked: {
                nmap.indoorLevel=4
                nmap.queryIndoorData()
            }
            Connections{
                target:root
                onContentXChanged: level4.visible= calculateVisibility(level4)
            }
        }

        FlatButton{
            id: level5
            text:"5"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: level4.right
            anchors.leftMargin: 5
            height: 48; width:height
            visible: calculateVisibility(level5)
            onClicked: {
                nmap.indoorLevel=5
                nmap.queryIndoorData(5)
            }
            Connections{
                target:root
                onContentXChanged: level5.visible= calculateVisibility(level5)
            }
        }
    }
}
