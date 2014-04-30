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

import "qrc:///js/constants.js" as Constants
import "qrc:///js/scores.js" as Scores


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
                onClicked: {
                    var i;
                    for (i=0 ; i < maxLevels; i++ )
                        Scores.setHighScore(i, 0);
                }
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
                Row
                {
                    id: thisRow
                    //width: column.width - Theme.paddingLarge
                    anchors.horizontalCenter: column.horizontalCenter
                    property int score : Scores.getHighScore(index)

                    Label
                    {
                        text: "Level "
                        font.family: Constants.font_family
                        font.pixelSize: Constants.fontsize_besttime
                        color: Theme.highlightColor
                    }
                    Label
                    {
                        text: (index+1)
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
                        text: thisRow.score
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

            }
        }
    }
}
