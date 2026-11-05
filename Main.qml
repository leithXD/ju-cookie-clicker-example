import QtQuick
import QtQuick.Controls.Basic


ApplicationWindow {
    id: window
    width: 640
    height: 480
    minimumWidth: 200
    minimumHeight: 250
    visible: true
    color: "black"
    title: "timer"

    property int count: 0
    property bool dontAccept: false
    property int timeLeft: 10

    Text {
        y: 30
        text: count
        font.pointSize: 28
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
    }

    Text {
        y: 400
        text: "Zeit übrig: " + timeLeft
        font.pointSize: 28
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
    }

    Rectangle {
        id: cookie
        width: 200
        height: 200
        anchors.centerIn: parent
        radius: width / 2
        color: "#612a02"
        clip: true

        Repeater {
            model: 20
            Rectangle {
                width: 10
                height: 10
                radius: width
                color: "black"
                x: Math.random() * (cookie.width - width)
                y: Math.random() * (cookie.height - height)
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 50
                easing.type: Easing.OutBack
            }
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: cookie
        onClicked: {
            timer.running = true
            if (!window.dontAccept) {
                window.count++
                cookie.scale = 1.1
                resetAnim.running = true
            }
        }
    }

    Timer {
        id: resetAnim
        interval: 50
        repeat: false
        running: false
        onTriggered: {
            cookie.scale = 1
        }
    }

    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: false

        onTriggered: {
            if (timeLeft > 0) {
                timeLeft--;
            } else {
                timer.stop()
                window.dontAccept = true
            }
        }
    }


}
