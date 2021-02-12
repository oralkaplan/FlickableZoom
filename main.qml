import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 400
    height: 400
    visible: true
    title: "Flickable Zoom"

    FlickableZoom {
        anchors.fill: parent
    }
}
