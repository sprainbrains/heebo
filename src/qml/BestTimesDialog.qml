
import QtQuick 2.0
import Sailfish.Silica 1.0


Page
{
    id: bestTimes

    property int maxLevels


    SilicaFlickable
    {
        anchors.fill: parent

        PullDownMenu
        {
            MenuItem
            {
                text: "Reset all"
            }
        }

        contentHeight: column.height

        Column
        {
            id: column

            width: parent.width
            spacing: Theme.paddingLarge
            PageHeader
            {
                title: "Best times evö"
            }
            Repeater
            {
                model: maxLevels
                Label
                {
                    text: "Level " + (index+1) + ": "
                }
            }

        }
    }
}
