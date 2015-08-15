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

//-----------------------------------------------------------------------------

.pragma library

//-----------------------------------------------------------------------------
// Utility functions
//-----------------------------------------------------------------------------

Function.prototype.method = function (name, func) {
    this.prototype[name] = func;
    return this;
};

//-----------------------------------------------------------------------------

Number.method('sign', function () {
    return this > 0 ? 1 : this < 0 ? -1 : 0;
});

//-----------------------------------------------------------------------------

Number.method('abs', function () {
    return Math.abs(this);
});

//-----------------------------------------------------------------------------

var isNumber = function (obj) {
    return typeof obj === 'number';
}


var getHighScore = function (level) {
   return mapset.getHighScore(mapset.getMap(), level);
}


//-----------------------------------------------------------------------------
var getMap = function() {
    return mapset.getMap();
}

//-----------------------------------------------------------------------------
var setHighScore = function (level, time) {
    return mapset.storeHighScore(mapset.getMap(), level, time);
}

//-----------------------------------------------------------------------------
var random = function (from, to) {
    return Math.floor(Math.random()*(to-from+1)+from);
};
