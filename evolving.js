/*

Copyright (c) 2015 Michele Bini


The novel techniques described and implemented by this library
encompass object inheritance and composition.

They may constitute a prior art which the author forbids the use of,
inclusion or reference in patents or patent claims by any parties.


This library is free software: you can redistribute it and/or modify
it under the terms of the version 3 of the GNU General Public License
as published by the Free Software Foundation.

This library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

var Evolving = (function() {
  function Evolving() {}

  Evolving.prototype.evolve = function(evolution) {
    var x, y;
    x = function() {};
    x.prototype = this;
    (y = new x).constructor = x;
    x.evolution = evolution;
    x.prototype = y;
    return evolution.call(y).constructor;
  };

  return Evolving;

})();

if (typeof exports !== "undefined" && exports !== null) {
  exports.Evolving = Evolving;
}
