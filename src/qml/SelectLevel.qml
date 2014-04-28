
import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog
{
    property int level
    property int maxLevels

    id: selectLevel

    canAccept: true

    onDone:
    {
        if (result === DialogResult.Accepted)
        {
            level = levelSlider.value
        }
    }

    Column
    {
        id: column

        width: parent.width
        spacing: Theme.paddingLarge
        DialogHeader
        {
            acceptText: "Go to level " + levelSlider.value
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
    }
}
