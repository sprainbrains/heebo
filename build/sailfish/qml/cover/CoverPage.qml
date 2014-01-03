
import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Image {
         source: "qrc:///images/heebo.png"
         anchors.centerIn: parent
         Label
         {
             anchors.bottom: parent.top
             anchors.horizontalCenter: parent.horizontalCenter
             font.pixelSize: 50
             text: "Heebo"
         }

     }
}
