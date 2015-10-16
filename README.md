'Evolving' - adaptive object evolution.  Soar above classes, prototypes and mixins

Version: v0.1.1 (semantic versioning)

### Features

Main features:

* Flexibility: compose multiple objects or classes and even turn objects back into classes
* Simplicity: only one method, lets you create ordinary Javascript objects via new
* Compatibility: Uses only basic Javascript primitives, and creates standard Javascript classes
* Clarity: Encourages named constructors and explicit object initialization

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

You can define custom implicit constructor in the Evolutions, by modifying '@constructor'.  However it is a good practice to use named, fluent constructors instead.  This makes it more explicit what is happening during an object's construction, and it helps in the long run if you are going to combine multiple evolutions.

For simplicity we used the common term "class" instead of the technically more correct term "constructor".  Javascript has a prototypal object system, so there is no clear class/instance distinction.  For many use cases, you can use the library without knowing this detail.


### Copyright and licensing

    Copyright (c) 2015 Michele Bini

    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the version 3 of the GNU General Public License
    as published by the Free Software Foundation.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
