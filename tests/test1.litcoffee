{ Evolving } = require '../evolving'

# Firstly define four classes

# define a mewing kitten
Kitten = Evolving::evolve ->
       @sound = "~mew~"
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
       # It is assumed that every professors knows rudiments of epistemology!
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
alice = (new ( kitten.evolve( Person.evolution ) )).setName('Alice')

# evolve Alice into an odd professor
aliceTheCatProfessor = new ( alice.evolve( OddProfessorEvolution ) )

console.log """

Alice in her own words:

    #{ alice.intro() }

Alice, after the evolution, introducing herself:

    #{ aliceTheCatProfessor.intro() }

"""
