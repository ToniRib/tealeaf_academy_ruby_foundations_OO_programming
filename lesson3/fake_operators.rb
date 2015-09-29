# fake_operators.rb

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end
end

bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)

puts "bob is older than kim" if bob > kim

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys.members << Person.new("Emmitt Smith", 46)
cowboys.members << Person.new("Troy Aikman", 48)
cowboys.members << Person.new("Michael Irvin", 49)

puts cowboys[1]
cowboys[3] = Person.new("JJ", 72)
puts cowboys[3]

saints = Team.new("New Orleans Saints")
saints.members << Person.new("Drew Brees", 36)
saints.members << Person.new("Mark Ingram", 25)
saints.members << Person.new("Brandin Cooks", 22)

gross_team = cowboys + saints
puts gross_team.inspect