# person.rb (lecture: classes & objects)

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    split_name = full_name.split
    @first_name = split_name.first
    @last_name = split_name.size > 1 ? split_name.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    split_name = full_name.split
    self.first_name = split_name.first
    self.last_name = split_name.size > 1 ? split_name.last : ''
  end

  def to_s
    name
  end
end

bob = Person.new('Robert Smith')
puts "The person's name is: #{bob}"

rob = Person.new('Robert Smith')

puts bob.name == rob.name