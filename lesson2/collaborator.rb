# collaborator.rb (for lecture: collaborator objects)

require_relative 'pet_hotel'

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")
bud = BullDog.new
kitty = Cat.new

bob.pets << kitty
bob.pets << bud
puts bob.pets

bob.pets.each do |pet|
  puts pet.jump
end
