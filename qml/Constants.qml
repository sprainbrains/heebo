import QtQuick 2.1
import Sailfish.Silica 1.0

QtObject
{
    id: constants

    // Block pixel size
    property int block_width: 90
    property int block_height: 90

    // height of toolbar
    property int toolbar_height: Theme.itemSizeLarge

    property int tool_bar_left_margin: 90
    property int level_margin_1digit_offset: 10

    property int menu_jump: 30
    property int main_menu_offset: -30

    property string toolbar_level_text: "Level: "

    property int animationDuration: 350 * (0.5 + (90 / block_width / 2))

    // Number of different "jewel" types
    property int jewel_maxtype: 5

    // Board size
    property int board_width: 6
    property int board_height: 9

    // Pixels to drag/swipe until it's interpreted as a movement
    property int move_limit: block_width/10

    // Font settings
    property string font_family: "Arial"
    property int fontsize_dialog: 22
    property int fontsize_time: Theme.fontSizeExtraSmall
    property int fontsize_besttime: Theme.fontSizeMedium
    property int fontsize_main: Theme.fontSizeLarge

    property color color_uiaccent:  "#D800D8"
    property color color_dark: "#333333"
    property color color_main: "#F2F2F2"


    //-----------------------------------------------------------------------------
    // Dialog messages
    //-----------------------------------------------------------------------------

    property int level_text_num: 7
    property int level_fail_text_num: 2

    property var level_text:  [ "ZÖMG! You just cleared that level! "+
                                "The next one won't be that easy!",

                                "OH NOES! That level was too eeeasy! "+
                                "Let’s crank it up a notch!",

                                "WHOOPS! That one almost cleared itself! "+
                                "Don’t worry, the next one won't be that easy!",

                                "That level was no match for your superior intellect! "+
                                "Next one will be more formidable!",

                                "WHOA! You just PWNED that level! "+
                                "Don’t get cocky, 'cos the next one will fight back!",

                                "LÖL! That level was no match for your powers! "+
                                "But the next one will make you WEEP!",

                                "NOM! That level was just for starters! "+
                                "The next one will be the real lunch!" ]

    property var level_fail_text: [ "ZÖMG! You didn't beat best time! "+
                                    "You might want to try again?",

                                    "OH NOES! That level was tricky for you! "+
                                    "Need more practice ?!" ]


    property var level_answer: [ "Yeah, right!",
                                 "Next one, plz!",
                                 "Neeext!",
                                 "BAZZINGA!",
                                 "Let’s go get sum’!",
                                 "Bring it on, baby!",
                                 "I’m still hungry!" ]

    property string last_level_msg: "That was the last level!\n"+
                                    "You PWNED the game!\n"+
                                    "CONGRATULASHUNS!!1"

    property string last_level_answer: "ZÖMG!!"

    //-----------------------------------------------------------------------------
    // About
    //-----------------------------------------------------------------------------

    property string heebo_version: "Sailfish 0.3-0"
    property string heebo_description: "Simple and addictive Match 3 game with quirky characters."
    property string heebo_copyright: "Copyright 2012,2014,2015 &copy; Mats Sjöberg, Niklas Gustafsson, Kimmo Lindholm<br/><br/>"+
    "All the source code and game level maps for Heebo are licensed under GPLv3. All graphics are licensed under CC-BY-SA.<br/><br/>The source code can be downloaded from <a style=\"color: "+color_uiaccent+"\" href=\"http://gitorious.org/heebo\">http://gitorious.org/heebo</a><br/><br/>Sailfish version from<br/><a style=\"color: "+color_uiaccent+"\" href=\"https://github.com/kimmoli/heebo\">https://github.com/kimmoli/heebo</a><br/><br/>"

    property string  code_license :
        "This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.<br/><br/>"+
        "This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.<br/><br/>"+
        "You should have received a copy of the GNU General Public License along with this program.  If not, see <a style=\"color: "+color_uiaccent+"\" href=\"http://www.gnu.org/licenses/\">http://www.gnu.org/licenses/</a>."

    property string graphics_license: "All graphics in Heebo are licensed under the <a style=\"color: "+color_uiaccent+"\" href=\"http://creativecommons.org/licenses/by-sa/3.0/\">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.";

    property string heebo_credit_coding: "<i>Cöde</i><br\><b>Mats Sj&ouml;berg</b><br\>mats@sjoberg.fi<br/><a style=\"color: "+color_uiaccent+"\" href=\"http://www.sjoberg.fi/mats/\">www.sjoberg.fi/mats</a><br\><br\><i>Sailfish pört</i><br\><b>Kimmo Lindholm</b><br\>kimmo@eke.fi<br/><a style=\"color: "+color_uiaccent+"\" href=\"http://google.com/+kimmolindholm\">google.com/+kimmolindholm</a>"

    property string heebo_credit_graphics: "<i>Gräphix</i><br\><b>Niklas Gustafsson</b><br\>nikui@nikui.net<br/><a style=\"color: "+color_uiaccent+"\" href=\"http://www.nikui.net/\">www.nikui.net</a>"

    //-----------------------------------------------------------------------------
    // Help
    //-----------------------------------------------------------------------------

    property string heebo_help_topic_1: "Match them blocks!"
    property string heebo_help_1: "Get three or more blocks of the same colour in a line. Blocks can be swapped by flicking over them. You can only swap blocks when either one of them will line up with three or more in a line. You can also move a block into an empty tile."

    property string heebo_help_topic_2: "Turn all gold!"
    property string heebo_help_2: "When three or more blocks of the same colour line up they will explode and turn the background into gold plates! To win a level you must turn all background tiles golden."

    property string heebo_help_topic_3: "Bonus sweetie"
    property string heebo_help_3: "If you explode more than three blocks in a line, a bonus background tile with a same colour block on it will be turned into gold. This is handy to get to those last hard-to-reach tiles!"

    property string heebo_help_topic_4: "Locked blocks"
    property string heebo_help_4: "In the later levels some blocks are locked and can't be moved.  Free them by matching them up with two or more other blocks of the same colour! Some times there are two locks, then you need to match them up twice."

    property string heebo_help_5: "Now go flip some blocks!!"
}
