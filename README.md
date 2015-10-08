'Evolving' - adaptive object evolution.  Soar above classes, prototypes and mixins

Version: v0.1.1 (semantic versioning)

### Features

Main features:

* Flexibility: compose multiple objects or classes and even turn objects back into classes
* Simplicity: only one method, lets you create ordinary Javascript objects via new
* Compatibility: Uses only basic Javascript primitives, and creates standard Javascript classes
* Clarity: Enforces named constructors and explicit object initialization

### Synopsis

```coffee

# Firstly define four classes

# define a mewing kitten
Kitten = Evolving::evolve ->
       @sound = "mew~"
       @

# evolve them into a grow cat, who can "meow"
Cat = Kitten::evolve ->
       @sound = "~meow~"
       @

# define a person with a name
Person = Evolving::evolve ->
       @setName = (@name)-> @
       @intro = -> "Hi, I'm #{ @name }. #{ @sound ? "" }"
       @
       
# evolve them into a professor in certain subjects
Professor = Person::evolve ->
       # It is assumed that all professors know rudiments of epistemology!
       @subjects = [ "Epistemology" ] 
       @addSubject = (s)-> @subjects = @subjects.concat([ s ]); @
       @randomSubject = -> @subjects.sort(-> Math.random() - 0.5)[0]
       personIntro = @intro
       @intro = ->
       	      personIntro.call(@) +
       	      " Today, we are going to learn about " +
              @randomSubject()
       @

# Describe the evolution of an Odd Professor, by combining Professor and Cat and adding a training in Sociology
OddProfessorEvolution = ->
        Professor.evolution.call  @
        Cat.evolution.call        @
        @addSubject "Sociology"

# a kitten is born
kitten = new Kitten()

# name the kitten Alice, making them also a person in the process
alice = new ( kitten.evolve( Person.evolution ) ).setName('Alice')

# evolve Alice into an odd professor
aliceTheCatProfessor = new ( alice.evolve( OddProfessorEvolution ) )

console.log """

Alice in her own words:

    #{ alice.intro() }

Alice, after the evolution, introducing herself:

    #{ aliceTheCatProfessor.intro() }

"""       
```

### API

A single class `Evolving` is defined, with a single method 'evolve'.

```coffee
    Evolving::evolve evolution
```

Evolution is a function called with "this" a new prototype, manipulating it and returning a new prototype.  This is actually really simple:

```coffee
    Person = Evolving::evolve ->
        @greet = (x)-> "Hello, #{x}'
        @
```

An ordinary Javascript class is returned, which you can instantiate with 'new'.

```coffee	
    p = new Person()
    p.greet "Bob"
```


### Cheatsheet

#### Turn an object into a class

This keeps a dynamic link to object via prototype.

```coffee
	myClass = myObject.evolve( -> @ )
```

#### Apply multiple evolutions mixin-style

```coffee
    CatDog = Evolving::evolve ->
        Cat.evolution @
        Dog.evolution @
        @
```

#### Make an extended version of the current object

This keeps a dynamic link to the base object via prototype.

```coffee
    extendedSelf = new do=> @evolve ->
        @foo = 3
        @bar = 3
        @    
```

#### And more...

Many more usage patterns which were difficult to achieve before are now possible!  This was just an appetizer!


#### Notes

The only caveat is that this doesn't work with classes that have non-empty constructors.
So you have to use named constructors.

This is not necessarily bad, as named constructors are warmly adviced by many expert JS programmers.

In this document, for simplicity we used the term class instead of the more technically correct term "constructor".  But you don't need to know about this technical detail to use this library.


### Copyright and licensing

    Copyright (c) 2015 Michele Bini


    The novel techniques described and implemented by this library
    encompass object inheritance and composition.

    They may constitute a prior art which the author forbids the use of,
    inclusion or reference in patents or patent claims by any parties.

    The full licensing terms are in the file GPL-3

    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the version 3 of the GNU General Public License
    as published by the Free Software Foundation.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

