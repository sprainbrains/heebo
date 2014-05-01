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

import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog
{
    property int level
    property int maxLevels
    property int map
    property bool penalty
    property bool particles

    id: settings

    canAccept: true

    onDone:
    {
        if (result === DialogResult.Accepted)
        {
            level = levelSlider.value
            map = mapSlider.value
            penalty = penaltySwitch.checked
            particles = particleSwitch.checked
        }
    }

    Column
    {
        id: column

        width: parent.width
        spacing: Theme.paddingSmall

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

        Label
        {
            visible: map != mapSlider.value
            x: Theme.paddingLarge
            font.pixelSize: Theme.fontSizeMedium
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            text: "ZÖMG! Map change quits Heebo,"
        }
        Label
        {
            visible: map != mapSlider.value
            x: Theme.paddingLarge
            font.pixelSize: Theme.fontSizeMedium
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            text: "you'll need to restart it!"
        }
        SectionHeader
        {
            text: "Other"
        }
        TextSwitch
        {
            id: penaltySwitch
            text: "Penalty"
            description: "Get punished from wrong flicks"
            checked: penalty
        }
        TextSwitch
        {
            id: particleSwitch
            text: "Explöde"
            description: "Animations when blocks explodes"
            checked: particles
        }
    }
}
