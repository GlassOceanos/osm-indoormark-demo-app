/****************************************************************************
**
** Copyright (C) 2015 Zed Worldwide, S.A.
** http://www.zed.com/es/quienes-somos/investigacion-desarrollo
**
** This file is part of the examples of the Ubica2 Project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Zed Worldwide, S.A. nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.0
import QtMultimedia 5.5
import QZXing 2.3
import OSMQuery 1.0
import "../components"

Item {
    id: root

    anchors.fill: parent
    onVisibleChanged: {
        if (visible)
            state="Scanning"
        else
            state="Stopped"
    }

    state: "Stopped"
    states: [
        State {
            name: "Scanning"
            StateChangeScript {
                script: {
                    mapPanel.visible=false
                    visible=true
                    camera.captureMode = Camera.CaptureStillImage
                    camera.cameraState = Camera.ActiveState
                    camera.start()
                }
            }
        },
        State {
            name: "Stopped"
            StateChangeScript {
                script: {
                    mapPanel.visible=true
                    camera.imageCapture.cancelCapture()
                    camera.cameraState = Camera.UnloadedState
                    root.visible=false;
                }
            }
        }
    ]

    OSMQuery{
        id: osmQuery

        onPositionFound: {
            mapPanel.latitude=lat
            mapPanel.longitude=lon
            mapPanel.hideMessage()
            mapPanel.addMarker()
        }

        onUnknownPosition: {
            mapPanel.clearMap()
            mapPanel.showMessage("Unable to find your location")
        }
    }

    QZXing{
        id: decoder

        onDecodingStarted: {
            camera.imageCapture.cancelCapture()
        }

        onTagFound: {
            root.state="Stopped"
            osmQuery.url="http://www.overpass-api.de/api/xapi/?node[beacon:uuid="+tag+"]"
            mapPanel.showMessage("Searching QR " + tag + "...")
            osmQuery.query()
        }
        Component.onCompleted: setDecoder(QZXing.DecoderFormat_QR_CODE)
    }

    Camera {
        id: camera

        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }

        focus {
            focusMode: Camera.FocusContinuous
            focusPointMode: Camera.FocusPointCenter
        }

        flash.mode: Camera.FlashRedEyeReduction

        imageCapture {

            resolution: "640x480"

            onReadyChanged: {
                if (camera.imageCapture.ready && root.state == "Scanning")
                    camera.imageCapture.captureToLocation("qr.jpg")
            }

            onImageSaved: {
                decoder.decodeImageQML(path);
            }
        }
    }

    VideoOutput {
        source: camera
        anchors.fill: parent
        fillMode: VideoOutput.Stretch
        autoOrientation: true
    }

    Text{
        text: qsTr("Center the QR code")
        width: parent.width
        color: "white"
        anchors.top: parent.top
        anchors.topMargin: 20
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 24
    }

    Image{
        anchors.centerIn: parent
        source: "qrc:/icons24/red-dot"
        height: 40
        width: 40
    }

    QRBottomBar{
        id: qrBottomBar
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

}
