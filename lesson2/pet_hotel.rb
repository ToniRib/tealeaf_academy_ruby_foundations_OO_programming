# pet_hotel.rb (lecture: Inheritance and lecture: Modules)

module Swim
  def swim
    'swimming!'
  end
end

class Fish
  include Swim
end

class Mammals
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Mammals
  include Swim

  def speak
    'bark'
  end

  def fetch
    'fetching!'
  end
end

class BullDog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Mammals
  def speak
    'meow'
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim

bully = BullDog.new
puts bully.swim

alia = Cat.new

puts alia.run
puts alia.speak
# puts alia.fetch

fish = Fish.new
puts fish.swim

puts BullDog.ancestors