
import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog
{
    property int level
    property int maxLevels
    property int map

    id: settings

    canAccept: true

    onDone:
    {
        if (result === DialogResult.Accepted)
        {
            level = levelSlider.value
            map = mapSlider.value
        }
    }

    Column
    {
        id: column

        width: parent.width
        spacing: Theme.paddingLarge
        DialogHeader
        {
        }
        SectionHeader
        {
            text: "Change level"
        }

        Slider  /* TODO: Change this to a timepicker, and show level value in middle */
        {
            id: levelSlider
            width: parent.width-10
            label: "Level"
            anchors.horizontalCenter: parent.Center
            minimumValue: 1
            maximumValue: maxLevels
            value: level
            stepSize: 1
            valueText: value
        }
        SectionHeader
        {
            text: "Change map"
        }
        Slider
        {
            id: mapSlider
            width: parent.width-10
            label: "map"
            anchors.horizontalCenter: parent.Center
            minimumValue: 1
            maximumValue: 2
            value: map
            stepSize: 1
            valueText: (value == 1) ? "Standard" : "Extras"
        }

        Label {
            visible: map != mapSlider.value
            x: Theme.paddingLarge
            font.pixelSize: Theme.fontSizeMedium
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Note! Map change needs Heebo restart!"
        }


    }
}
