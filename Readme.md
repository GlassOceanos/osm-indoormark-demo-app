 
# osm-indoormark-demo-app

This a demo app showing how to use the indoormark tag specification at Open Street Map

## Usage

Indoor location and navigation are fields of investigation that require a geographical information system to store information. Not only the layout of a building and navigation graphs, also the location of indoor beacons are important for such solutions. Inside a building, the problem to solve is very similar to air and sea transport, having the same objective: to position and guide a user through the venue.

Using indoormark tag it is possible to label several types of indoor beacons. The Ubica2 project developed by Zed with the collaboration of URJC is creating an indoor navigation system based on several indoor positioning technologies. Some of these technologies require the use of beacons such us:

    ibeacons: they provide proximity location enabling triangulation positioning
    NFC tags: they can provide the coordinate of the current position
    QR codes: as the NFC tags, they can provide a known coordinate.

But all these items have to be deployed in a building and therefore, their information has to be stored in a geographical data base. Having this, navigation applications could query the information required to locate and guide the user.
Tagging

The tag is defined in a similar way as is established for seamark and airmark tags. To this end, the key/value indoormark=beacon is used. Furthermore, we can extend a beacon with a number of attributes that allow accommodate all the information necessary.

The scheme devised as follows:


	Key 	Value 	Comment 	Suitable for
required 	indoormark 	beacon 	Mandatory tag for defining a point which is a beacon 	All
required 	beacon:type 	String 	Distinguisses the type of the beacon: bluetooth, nfc, qr... 	All
optional 	beacon:address 	String 	Network address identifier 	ibeacons, NFC
optional 	beacon:uuid 	String 	Unique identifier given normally for ibeacons 	ibeacons, QRs
optional 	beacon:major 	Integer 	ibeacon major number 	ibeacons
optional 	beacon:minor 	Integer 	ibeacon minor number 	ibeacons
optional 	beacon:measured 	Integer 	signal strength calibration value of an ibeacon 	ibeacons
required 	level 	* 	Level where the beacon is deployed. This is specified by Simple Indoor Tagging 	all


The only mandatory tag is the indoormark key but it is suggested to add some more information using the other tags shown in the previous table. In addition, the use of the level tag provides compatibility with the specifications written in the Simple Indoor Tagging wiki page. Doing all that, navigation systems could retrieve all the data they need to position the user. For instance, an ibeacon based application should know the major and minor numbers to distinguish any ibeacon. A NFC tag would give its unique address when detected and this value could be use to match an indoormark in Open Street Maps and obtain its coordinates. See the examples below to know how this can be achieved.

## Examples

QR beacon

QR codes can be used to give a unique identifier when scanned. An approach to transform that to a position within a building is to match the unique identifier given by the QR with the item tagged in our OSM map. Doing this, we can get the coordinates and also the level where the QR is placed.

    indoormark=beacon
    level=0
    beacon:type=QR
    beacon:uuid=123456

NFC tag

NFC can be used in a similar way to QR codes. In this case, the address of the NFC is unique and the procedure to obtain the location could use its value to get the coordinates and level from the map.

    indoormark=beacon
    level=0
    beacon:type=nfc
    beacon:address=11:11:11:11:13

bluetooth (ibeacon)

In the case of an ibeacon, we will need more data in order to make work our triangulation algorithm. Useful information to store is the uuid of the beacon, its major and minor numbers and the signal calibration value (measured)

    indoormark=beacon
    level=0
    beacon:type=bluetooth
    beacon:uuid=123456789
    beacon:major=1
    beacon:minor=2
    beacon:measured=-56