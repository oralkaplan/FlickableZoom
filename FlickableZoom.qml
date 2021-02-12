import QtQuick 2.15

Item {
    id: itm_flickableRoot

    Flickable {
        id: flck_control

        anchors.fill: parent
        contentWidth: itm_content.contentWidth
        contentHeight: itm_content.contentHeight

        Item {
            id: itm_content

            readonly property real contentWidth: width * scale
            readonly property real contentHeight: height * scale

            width: flck_control.width
            height: flck_control.height
            transformOrigin: Item.TopLeft
            onScaleChanged: ma_content.forceActiveFocus()

            Rectangle {
                id: rect_content

                readonly property real contentWidth: width * scale
                readonly property real contentHeight: height * scale

                anchors.centerIn: parent
                width: 200
                height: 200
                transformOrigin: Item.TopLeft
                color: Qt.rgba( Math.random(), Math.random(), Math.random(), 1.0 )

                Repeater {
                    model: 8
                    delegate: Rectangle {
                        readonly property real size: Math.min( parent.width * 0.5 / index , parent.height * 0.5 / index )

                        anchors.centerIn: parent
                        width: size
                        height: size
                        color: Qt.rgba( Math.random(), Math.random(), Math.random(), 1.0 )
                    }
                }
            }
        }

        MouseArea {
            id: ma_content

            readonly property real scaleFactor: 0.8
            readonly property bool down: pressed || flck_control.dragging


            anchors.fill: parent
            hoverEnabled: true
            cursorShape: down ? Qt.ClosedHandCursor : Qt.PointingHandCursor
            onWheel: {
                let nx = wheel.x / parent.width
                let ny = wheel.y / parent.height

                if( wheel.angleDelta.y > 0 )
                    zoomIn( nx, ny, scaleFactor, itm_content, flck_control )
                else if( itm_content.scale > 1.0 )
                    zoomOut( nx, ny, scaleFactor, itm_content, flck_control )
            }
        }
    }

    function zoomIn( nx, ny, scaleFactor, target, control ) {
        let ds = ( target.scale / scaleFactor ) - target.scale
        let dw = ds * target.width
        let dh = ds * target.height
        let dx = dw * nx
        let dy = dh * ny
        control.contentX += dx
        control.contentY += dy
        target.scale /= scaleFactor
    }

    function zoomOut( nx, ny, scaleFactor, target, control ) {
        let dScale = ( target.scale * scaleFactor ) - target.scale
        let dw = dScale * target.width
        let dh = dScale * target.height
        let dx = dw * nx
        let dy = dh * ny
        control.contentX += dx
        control.contentY += dy
        target.scale *= scaleFactor
    }

    function resetZoom( target, control ) {
        control.contentX = 0
        control.contentY = 0
        target.scale = 1.0
    }
}
