'Evolving' - adaptive object evolution.  Soar above classes, prototypes and mixins

    ###
    
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
    
    ###



Define 'Evolving' as a generic base class

    class Evolving


Define the 'evolve' method, that applies 'evolution' to the current class.

It returns an ordinary Javascript class you can instantiate with 'new'.

Technically, since Javascript objects have prototypal inheritance, "classes" are just constructors.

      evolve: (evolution)->
          x = ->
          x.prototype = @
          evolution.call(y = new x).constructor = x
          x.evolution = evolution
          x.prototype = y
          x


Export 'Evolving' if necessary

    exports?.Evolving = Evolving

