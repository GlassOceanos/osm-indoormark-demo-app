import QtQuick 2.0
import QtLocation 5.0
import Rest 1.0
import RestParser 1.0
import "../components"

Item{
    id: root

    /*
    PositionSource{
        id: positionSource
        active: true

        onPositionChanged: {
            map.center = positionSource.position.coordinate
        }
    }*/
    Plugin {
        id: osmPlugin
        name : "osm"
    }

    Plugin {
        id: nokiaPlugin
        name : "nokia"
        PluginParameter { name: "app_id"; value: "WMl1i0meTG4kl6FdCBee" }
        PluginParameter { name: "token"; value: "UL3ph0fkqb8GIIPwFYjFnA" }
    }


    Map {
        id: nmap
        property variant container
        property int indoorLevel: 0

        function createMarker(p){
            var img,type,name
            if (p.type.length>0){
                img=p.type
                type=p.type
                name=p.name
            }
            else{
                img="burger"
                type="unknown"
                name="test"
            }
            var circle= Qt.createQmlObject('import QtQuick 2.0;import QtLocation 5.0;  Marker{symbol: "qrc:/map-icons/symbols/24/'+img+'"; name:\"'+name+'\"; type:\"'+type+'\"; }',nmap)
            var loc=  Qt.createQmlObject('import QtLocation 5.0; Location { coordinate { latitude: '+p.latitude+';longitude: '+p.longitude+' } }', nmap)
            circle.coordinate = loc.coordinate

            nmap.addMapItem(circle)

        }

        function createPolyLine(path){//We want to draw this only when we reach zommlevel 17
            var polyline= Qt.createQmlObject('import QtQuick 2.0;import QtLocation 5.0;  MapPolyline{line.color: "blue"; line.width:2; visible: nmap.zoomLevel>=17}',container)
            polyline.path = path

            nmap.addMapItem(polyline)
        }

        function createCircle(center){//We want to draw this only when we reach zommlevel 17
            var circle= Qt.createQmlObject('import QtQuick 2.0;import QtLocation 5.0;  MapCircle{color: "red"; radius:0.5; visible: nmap.zoomLevel>=17}',container)
            circle.center = center

            nmap.addMapItem(circle)
        }

        function queryData(){
            var bbBottomLeft=nmap.toCoordinate(Qt.point(0,nmap.height))
            var bbTopRight=nmap.toCoordinate(Qt.point(nmap.width,0))
            mapFeatures.doPost("{geometry: {$geoWithin: {$box:[ ["+bbBottomLeft.longitude+","+bbBottomLeft.latitude+"], ["+bbTopRight.longitude+","+bbTopRight.latitude+"]] }}}");
            if (nmap.zoomLevel>16){
                nmap.queryIndoorData(indoorLevel)
            }
        }


        function queryIndoorData(level){
            if(typeof(level)==='undefined') (level) = indoorLevel;
            if(typeof(container)!=='undefined') container.destroy()
            container= Qt.createQmlObject('import QtQuick 2.0;Item{ id:indoorContainer; objectName:"indoorContainer"; anchors.fill:parent;}',nmap)
            nmap.addMapItem(container)
            var bbBottomLeft=nmap.toCoordinate(Qt.point(0,nmap.height))
            var bbTopRight=nmap.toCoordinate(Qt.point(nmap.width,0))
            var query="{geometry: {$geoWithin: {$geometry: {type: \"Polygon\", coordinates: [[ ["+bbBottomLeft.longitude+","+bbBottomLeft.latitude+"], ["+bbBottomLeft.longitude+","+bbTopRight.latitude+"], ["+bbTopRight.longitude+","+bbTopRight.latitude+"], ["+bbTopRight.longitude+","+bbBottomLeft.latitude+"],["+bbBottomLeft.longitude+","+bbBottomLeft.latitude+"]]]}}}, propertiesRelations.level : '"+level+"'}"

/*             var bbBottomLeft=nmap.toCoordinate(Qt.point(0,nmap.height))
            var bbTopRight=nmap.toCoordinate(Qt.point(nmap.width,0))


            bbBottomLeft.longitude=-0.37385858790665694
            bbBottomLeft.latitude= 39.46909594152462

            // Query 1
            //bbTopRight.longitude=-0.3727857043006999
            //bbTopRight.latitude= 39.469592878552135

            // Query 2
            bbTopRight.longitude=-0.372796732668719
            bbTopRight.latitude= 39.4698616805572

            var query="{geometry: {$geoWithin: {$geometry: {type: \"Polygon\", coordinates: [[ ["+bbBottomLeft.longitude+","+bbBottomLeft.latitude+"], ["+bbBottomLeft.longitude+","+bbTopRight.latitude+"], ["+bbTopRight.longitude+","+bbTopRight.latitude+"], ["+bbTopRight.longitude+","+bbBottomLeft.latitude+"],["+bbBottomLeft.longitude+","+bbBottomLeft.latitude+"]]]}}}, propertiesRelations.level : '"+level+"'}"

            //var query= "{geometry: {$geoWithin: {$geometry: {type: \"Polygon\", coordinates: [[ [-0.37385858790665694,39.46909594152462], [-0.37385858790665694,39.469592878552135], [-0.3727857043006999,39.469592878552135], [-0.3727857043006999,39.46909594152462],[-0.37385858790665694,39.46909594152462]]]}}}, propertiesRelations.level : '5'}"

            var circle= Qt.createQmlObject('import QtQuick 2.0;import QtLocation 5.0;  MapCircle{color: "green"; radius:1; visible: nmap.zoomLevel>=17}',nmap)
            circle.center.longitude = bbBottomLeft.longitude
            circle.center.latitude = bbBottomLeft.latitude
            nmap.addMapItem(circle)
            circle= Qt.createQmlObject('import QtQuick 2.0;import QtLocation 5.0;  MapCircle{color: "green"; radius:1; visible: nmap.zoomLevel>=17}',nmap)
            circle.center.longitude = bbBottomLeft.longitude
            circle.center.latitude = bbTopRight.latitude
            nmap.addMapItem(circle)
            circle= Qt.createQmlObject('import QtQuick 2.0;import QtLocation 5.0;  MapCircle{color: "green"; radius:1; visible: nmap.zoomLevel>=17}',nmap)
            circle.center.longitude = bbTopRight.longitude
            circle.center.latitude = bbTopRight.latitude
            nmap.addMapItem(circle)
            circle= Qt.createQmlObject('import QtQuick 2.0;import QtLocation 5.0;  MapCircle{color: "green"; radius:1; visible: nmap.zoomLevel>=17}',nmap)
            circle.center.longitude = bbTopRight.longitude
            circle.center.latitude = bbBottomLeft.latitude
            nmap.addMapItem(circle)
            console.log("\n====================\n"+query+"\n====================\n")
*/
            indoorMap.doPost(query);
        }

        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        center: hud.coordinate //center: positionSource.position.coordinate //center: {latitude: 39.15; longitude: -0.435}
        zoomLevel: 10

        // Enable pinch gestures to zoom in and out
        gesture.flickDeceleration: 3000
        gesture.enabled: true
        gesture.onMovementStopped: {
            queryData()
        }

        plugin : nokiaPlugin//osmPlugin

        MapQuickItem {
            coordinate:hud.coordinate// {latitude: 39.15; longitude: -0.435}
            anchorPoint.x: circle.width/2
            anchorPoint.y: circle.height/2
            sourceItem: Rectangle{
                id:circle
                height:32
                width: height
                radius: height/2
                color: "blue"
                border.color: "white"
                border.width: 3
                opacity: 0.8
            }
        }


        MapMouseArea {
            id: mouseArea
            property variant lastCoordinate
            property int lastX:-999
            property int lastY:-999
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onDoubleClicked: {
                nmap.center = mouseArea.mouseToCoordinate(mouse)
                if (mouse.button == Qt.LeftButton){
                    nmap.zoomLevel += 1
                } else  nmap.zoomLevel -= 1
            }

            onPressed: {lastX=mouse.x; lastY=mouse.y}
            onPressAndHold:{
                var maxPixelDistance=10
                if (Math.abs(mouse.x-lastX)<maxPixelDistance && Math.abs(mouse.y-lastY)<maxPixelDistance){ //we want to avoid collision with map movement
                    var coord= mouseToCoordinate(mouse)

                    poiInfo.visible=true
                    poiInfo.debug1="Latitude:"
                    poiInfo.debug2=coord.latitude
                    poiInfo.debug3="Longitude:"
                    poiInfo.debug4=coord.longitude
                }
            }
        }

        Connections{
            target:hud
            onAddPOIToHUD: {
                nmap.createMarker(p)
            }
        }

        onZoomLevelChanged: queryData()

    }

    MapTopBar{
        id: mapTopBar
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
    }

    MapBottomBar{
        id: mapBottomBar
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width:parent.width

        /*onChangeMapProvider:{
            console.log("Changing")
            if (nmap.plugin.name=="osm")
                nmap.plugin=nokiaPlugin
            else
                nmap.plugin=osmPlugin
        }*/
    }

    PopUp{
        id:poiInfo
        objectName: "poiInfo"
        visible: false
    }

    Rest{
        id:mapFeatures
        apiKey: "1"
        backendURL: "http://dev.oceanos.u-tad.com/geolocation/territory/search?layer=FEATURES"

    }

    Connections{
        target: mapFeatures
        onReplyReceived:restParser.parseJSON(reply)
    }

    Connections{
        target: restParser
        onAddPOIToHUD: nmap.createMarker(p)
    }

    RestParser{
        id:restParser
    }

    Rest{
        id:indoorMap
        apiKey: "1"
        backendURL: "http://dev.oceanos.u-tad.com/geolocation/territory/search;pageSize=100?layer=MAP"

    }

    Connections{
        target: indoorMap
        onReplyReceived:restParser.parseIndoorMapJSON(reply)
    }

    Connections{
        target: restParser
        onAddPolyLine: nmap.createPolyLine(path)
        onAddDoor: nmap.createCircle(center)
    }


}
