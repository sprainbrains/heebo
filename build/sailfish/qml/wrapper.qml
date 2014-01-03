import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow
{
    initialPage: Qt.resolvedUrl("qrc:///qml/main.qml")
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    Component.onCompleted: console.log("-- application window complete")
}
