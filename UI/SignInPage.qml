import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Component {

    Rectangle {

        signal connector

        onConnector: {
            rot_cont.visible = false
            rot_anima.running = false

            if(username) {
                stack.push(welcPage)
            }

        }

        Rectangle {
            anchors.fill: parent

            Image {
                sourceSize: Qt.size(parent.width, parent.height)
                fillMode: Image.PreserveAspectCrop
                anchors.centerIn: parent
                source: "./images/train.jpg"
            }

        }

        ColumnLayout {
            anchors.centerIn:parent
            width: 240
            spacing: 24

            Text {
                Layout.fillWidth: true
                text: "LOGO"
                color: "white"
                font.pixelSize: 24
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                Layout.bottomMargin: 128
            }


            CustTextField {
                id: email_field
                placeholderText: "Email"
            }

            CustTextField {
                id: passcode_field
                placeholderText: "Password"
                echoMode: TextField.Password
            }

            Button {
                Layout.fillWidth: true
                text: "Sign In"

                background: Rectangle {
                    color: "transparent"
                }

                contentItem: Text {
                    text: parent.text
                    color: parent.hovered ? "#77ffffff" : "white"
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                }

                onClicked:  {
                    stack.push(welcPage)
//                    rot_cont.visible = true
//                    rot_anima.running = true
//                    backend.authenticate(email_field.text, passcode_field.text)
                }

            }

        }

        Rectangle {
            id: rot_cont
            anchors.fill: parent
            visible: false

            Image {
                anchors.centerIn: parent
                source: "./images/loading.jpg"
                sourceSize: Qt.size(128, 128)

                RotationAnimation on rotation {
                    id: rot_anima
                    from: 0
                    to: 360
                    duration: 1000
                    loops: Animation.Infinite
                    running: false
                }
            }



        }

    }

}
