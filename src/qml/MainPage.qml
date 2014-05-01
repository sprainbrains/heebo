/*
  Copyright 2012 Mats Sjöberg
  
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
import QtQuick.Particles 2.0
import Sailfish.Silica 1.0

import "qrc:///js/constants.js" as Constants
import "qrc:///js/jewels.js" as Jewels
import "qrc:///js/scores.js" as Scores

Page {
    id: mainPage

    property real buttonOffset: 0.0

    property bool isRunning: false

    property int currentElapsedTime: 0

    property bool particles: true
    property bool penalty: false

    property int dt: 0
    
    signal animDone()
    signal jewelKilled();
    
    Component.onCompleted: {
        Jewels.init();
        animDone.connect(Jewels.onChanges);
        jewelKilled.connect(Jewels.onChanges);
        okDialog.closed.connect(Jewels.dialogClosed);
        okDialog.opened.connect(tintRectangle.show);
        particles = Jewels.getParticlesMode();
        penalty = Jewels.getPenaltyMode();
    }

    function openFile(file) {
        pageStack.push(Qt.resolvedUrl(file))
    }

    JewelDialog {
        id: okDialog
        anchors.centerIn: background
        z: 55
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: mainPage.height
        id: flick
    }


    Item {
        id: background;

        property ParticleSystem ps: particleSystem

        width: parent.width
        anchors { bottom: parent.bottom; top: toolBar.bottom;}

        MouseArea {
            anchors.fill: parent
            onPressed: Jewels.mousePressed(mouse.x, mouse.y)
            onPositionChanged: if (pressed) Jewels.mouseMoved(mouse.x, mouse.y)
        }

        ParticleSystem {
            id: particleSystem
            z: 5
            running: Qt.application.active & particles
            anchors.centerIn: parent
            Component.onDestruction: console.log("particleSystem destroyed")
            Component.onCompleted: console.log("particleSystem ready")
            ImageParticle {
                groups: ["circle"]
                system: particleSystem
                source: "qrc:///images/particle_circle.png"
                alpha: 0.1
            }
            ImageParticle {
                groups: ["polygon"]
                system: particleSystem
                source: "qrc:///images/particle_polygon.png"
                alpha: 0.1
            }
            ImageParticle {
                groups: ["square"]
                system: particleSystem
                source: "qrc:///images/particle_square.png"
                alpha: 0.1
            }
            ImageParticle {
                groups: ["triangle_down"]
                system: particleSystem
                source: "qrc:///images/particle_triangle_down.png"
                alpha: 0.1
            }
            ImageParticle {
                groups: ["triangle_up"]
                system: particleSystem
                source: "qrc:///images/particle_triangle_up.png"
                alpha: 0.1
            }
        }
    }

    ToolBar {
        id: toolBar

            Row {
                id: currentLevel
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    verticalCenterOffset: -(Jewels.fontsize_main/2)
                    leftMargin: Jewels.tool_bar_left_margin +
                                (currentLevelText.text.length == 1 ? Jewels.level_margin_1digit_offset : 0)
                }

                Text {
                    text: Jewels.toolbar_level_text
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_main
                    color: Theme.highlightColor //Jewels.color_uiaccent
                }
                Text {
                    id: currentLevelText
                    text: "??"
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_main
                    color: Theme.primaryColor //Jewels.color_main
                }
                Text {
                    text: "/"
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_main
                    color: Theme.highlightColor //Jewels.color_uiaccent
                }
                Text {
                    id: lastLevelText
                    text: "??"
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_main
                    color: Theme.primaryColor //Jewels.color_main
                }
            }
            Row {
                id: elapsedTime
                anchors {
                    verticalCenter: parent.verticalCenter
                    verticalCenterOffset: Jewels.fontsize_time
                    horizontalCenter: currentLevel.horizontalCenter
                }

                Text {
                    text: "Time: "
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_time
                    color: Theme.highlightColor
                }
                Text {
                    id: currentElapsedTimeText
                    text: currentElapsedTime
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_time
                    color: Theme.primaryColor
                }
                Text {
                    text: " s"
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_time
                    color: Theme.highlightColor
                }

                Text {
                    visible: (currentBestTimeText.text != "0")
                    text: " - Best: "
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_time
                    color: Theme.highlightColor
                }
                Text {
                    id: currentBestTimeText
                    visible: (currentBestTimeText.text != "0")
                    text: "0"
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_time
                    color: Theme.primaryColor
                }
                Text {
                    visible: (currentBestTimeText.text != "0")
                    text: " s"
                    font.family: Jewels.font_family
                    font.pixelSize: Jewels.fontsize_time
                    color: Theme.highlightColor
                }

                Timer {
                    running: (!tintRectangle.visible && (mainMenu.opacity == 0) && applicationActive && (mainPage.status === PageStatus.Active))
                    repeat: true
                    interval: 1000
                    onTriggered: currentElapsedTime++
                }

            }

        Image {
            id: menuButton
            source: "qrc:///images/icon_menu.png"
            width: 64; height: 64

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: -Jewels.menu_jump*mainPage.buttonOffset
                rightMargin: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: mainMenu.toggle()
                onPressed: menuButton.source="qrc:///images/icon_menu_pressed.png"
                onReleased: menuButton.source="qrc:///images/icon_menu.png"
            }

            Behavior on anchors.verticalCenterOffset {
                SpringAnimation {
                    epsilon: 0.25
                    damping: 0.1
                    spring: 3
                }
            }

        }
    }

    Rectangle {
        id: tintRectangle
        anchors.fill: parent
        color: "#3399FF"
        opacity: 0.0
        visible: opacity > 0

        z: 10

        function show() {
            var colors = ["#3399FF", "#11FF00", "#7300E6", "#FF3C26",
                          "#B300B3" /*, "#FFD500"*/];

            tintRectangle.color = colors[Jewels.random(0,4)];
            tintRectangle.opacity = 0.65;
        }

        function hide() {
            tintRectangle.opacity = 0;
        }            

        MouseArea {
            anchors.fill: parent
            enabled: tintRectangle.opacity
            onClicked: {
                mainMenu.hide();
                if (!okDialog.isClosed())
                  okDialog.hide();
            }
        }

        Behavior on opacity {
            //SmoothedAnimation { velocity: 2.0 }
            NumberAnimation { duration: 500 }
        }
    }

   Image {
        id: mainMenu
        z: 50

        source: "qrc:///images/main_menu_bg.png"

        signal closed

        function toggle() {
            if (okDialog.isClosed()) {
              //visible ? hide() : show(); // was giving warning
                if (visible) hide()
                 else
                    show()
            }
        }
    
        function show() {
            mainMenu.opacity = 1;
            tintRectangle.show();
            mainPage.buttonOffset = 1.0;
        }
        
        function hide() {
            mainMenu.opacity = 0;
            tintRectangle.hide();
            mainMenu.closed();
            mainPage.buttonOffset = 0.0;
        }

        opacity: 0
        visible: opacity > 0
        
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: Jewels.main_menu_offset
        }

        Image {
            source: "qrc:///images/heebo_logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.baseline: parent.top
            anchors.baselineOffset: -32
        }

        Grid {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2
            columns: 2

            MenuButton {
                text: "New game"
                buttonImage: "qrc:///images/icon_newgame.png"
                pressedButtonImage: "qrc:///images/icon_newgame_pressed.png"
                onClicked: { mainMenu.hide(); Jewels.firstLevel() }
            }
            MenuButton {
                text: "Restart level"
                buttonImage: "qrc:///images/icon_restart.png"
                pressedButtonImage: "qrc:///images/icon_restart_pressed.png"
                onClicked: { mainMenu.hide(); Jewels.startNewGame() }
            }

            MenuButton {
                text: "Settings"
                buttonImage: "qrc:///images/icon_settings.png"
                pressedButtonImage: "qrc:///images/icon_settings_pressed.png"
                onClicked: {
                    mainMenu.hide();
                    var dialog = pageStack.push(Qt.resolvedUrl("qrc:///qml/SettingsDialog.qml"),
                                          { "level": currentLevelText.text,
                                            "maxLevels": lastLevelText.text,
                                            "map": Jewels.getMap(),
                                            "penalty": penalty,
                                            "particles": particles})
                    dialog.accepted.connect( function()
                    {
                        if (currentLevelText.text != dialog.level)
                            Jewels.setLevel(dialog.level)
                        if ((penalty !== dialog.penalty) || (particles !== dialog.particles))
                        {
                            penalty = dialog.penalty
                            particles = dialog.particles
                            Jewels.storeOtherSettings(penalty, particles)
                        }
                        console.log("Penalty " + (penalty ? "on" : "off"))
                        console.log("Particles " + (particles ? "on" : "off"))

                        /* This as last, as it should shutdown heebo */
                        if (Jewels.getMap() != dialog.map)
                            Jewels.changeMap(dialog.map)

                    } )
                }
            }
            MenuButton {
                text: "Best times"
                buttonImage: "qrc:///images/icon_besttimes.png"
                pressedButtonImage: "qrc:///images/icon_besttimes_pressed.png"
                onClicked: {
                    mainMenu.hide();
                    var bestis = pageStack.push(Qt.resolvedUrl("qrc:///qml/BestTimesDialog.qml"),
                                                { "maxLevels": lastLevelText.text } )

                    bestis.accepted.connect ( function()
                    {
                        Jewels.updateBestTime(); // Just in case that bets times were cleared
                        if (bestis.newLevel > 0 )
                            Jewels.setLevel(bestis.newLevel)
                    } )
                }
            }
            MenuButton {
                text: "Help"
                buttonImage: "qrc:///images/icon_help.png"
                pressedButtonImage: "qrc:///images/icon_help_pressed.png"
                onClicked: { mainMenu.hide(); openFile("qrc:///qml/HelpPage.qml") }
            }
            MenuButton {
                text: "About"
                buttonImage: "qrc:///images/icon_about.png"
                pressedButtonImage: "qrc:///images/icon_about_pressed.png"
                onClicked: { mainMenu.hide(); openFile("qrc:///qml/AboutPage.qml") }
            }

        }
    }

}

