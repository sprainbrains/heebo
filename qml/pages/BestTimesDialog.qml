/*
  Copyright 2014 Kimmo Lindholm

  This file is part of the Heebo programme.

  Heebo is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  Heebo is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
  License for more details.

  You should have received a copy of the GNU General Public License
  along with Heebo.  If not, see <http://www.gnu.org/licenses/>.
*/
//-----------------------------------------------------------------------------

import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/constants.js" as Constants
import "../js/scores.js" as Scores


Dialog
{
    id: bestTimes

    property int maxLevels
    property int newLevel: 0
    property Item contextMenu

    Component.onCompleted:
    {
        var i;
        for (i=0 ; i<maxLevels ; i++)
        {
            myList.append({"score": Scores.getHighScore(i), "level": i+1});
        }
    }

    ListModel
    {
        id: myList
    }


    SilicaListView
    {
        id: listView
        model: myList
        width: parent.width
        height: parent.height

        VerticalScrollDecorator {}

        header: DialogHeader
        {
            title: "Best times evö"
        }

        PullDownMenu
        {
            MenuItem
            {
                text: "Reset all"
                onClicked: {
                    var i;
                    for (i=0 ; i < maxLevels; i++ )
                        Scores.setHighScore(i, 0);
                    newLevel = 0; // Do not change level
                    bestTimes.accept();
                }
            }
        }

        delegate: ListItem
        {
            id: myListItem
            menu: contextMenu
            width: ListView.view.width

            contentHeight: Theme.itemSizeSmall

            Row
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Label
                {
                    text: "Level "
                    font.family: Constants.font_family
                    font.pixelSize: Constants.fontsize_besttime
                    color: Theme.highlightColor
                }
                Label
                {
                    text: level
                    font.family: Constants.font_family
                    font.pixelSize: Constants.fontsize_besttime
                    color: Theme.primaryColor
                }
                Label
                {
                    text: (score > 0) ? " Time " : " No time yet"
                    font.family: Constants.font_family
                    font.pixelSize: Constants.fontsize_besttime
                    color: Theme.highlightColor
                }
                Label
                {
                    visible: (score > 0)
                    text: score
                    font.family: Constants.font_family
                    font.pixelSize: Constants.fontsize_besttime
                    color: Theme.primaryColor
                }
                Label
                {
                    visible: (score > 0)
                    text: " sec"
                    font.family: Constants.font_family
                    font.pixelSize: Constants.fontsize_besttime
                    color: Theme.highlightColor
                }
            }

            Component
            {
                id: contextMenu
                ContextMenu
                {
                    MenuItem
                    {
                        text: "Replay level " + level
                        onClicked:
                        {
                            newLevel = level
                            console.log("Want to replay level " + level)
                            bestTimes.accept()
                        }
                    }
                }
            }
        }
    }
}


