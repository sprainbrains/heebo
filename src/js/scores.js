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

var getHighScore = function (level) {
   return mapset.getHighScore(mapset.getMap(), level);
}

//-----------------------------------------------------------------------------
var changeMap = function(map) {
    console.log("Trying to change map " + map)
    mapset.writeNewMap(map);
}

//-----------------------------------------------------------------------------
var getMap = function() {
    return mapset.getMap();
}

//-----------------------------------------------------------------------------
var setHighScore = function (level, time) {
    return mapset.storeHighScore(mapset.getMap(), level, time)
}
