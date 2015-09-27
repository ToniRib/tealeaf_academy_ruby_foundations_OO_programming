# rock_paper_scissors.rb

require 'pry'

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Hal Chappie Sonny Number5).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = %w(rock paper scissors lizard spock)

  def initialize(value)
    @value = value
  end

  def >(other_move)
    rock? && (other_move.lizard? || other_move.scissors?) ||
      paper? && (other_move.rock? || other_move.spock?) ||
      scissors? && (other_move.lizard? || other_move.paper?) ||
      spock? && (other_move.scissors? || other_move.rock?) ||
      lizard? && (other_move.spock? || other_move.paper?)
  end

  def <(other_move)
    rock? && (other_move.paper? || other_move.spock?) ||
      paper? && (other_move.lizard? || other_move.scissors?) ||
      scissors? && (other_move.rock? || other_move.spock?) ||
      spock? && (other_move.paper? || other_move.lizard?) ||
      lizard? && (other_move.rock? || other_move.scissors?)
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def to_s
    @value
  end
end

# TODO: left off here creating new classes
class Rock < Move
end

class Paper < Move
end

class Scissors < Move
end

class Lizard < Move
end

class Spock < Move
end
# -- end of new classes

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "First person to 5 points wins the game!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    case determine_winner
    when :human
      puts "#{human.name} won!"
    when :computer
      puts "#{computer.name} won!"
    when :tie
      puts "It's a tie!"
    end
  end

  def determine_winner
    if human.move > computer.move
      :human
    elsif human.move < computer.move
      :computer
    else
      :tie
    end
  end

  def score_winner
    case determine_winner
    when :human
      human.score += 1
    when :computer
      computer.score += 1
    end
  end

  def display_scores
    puts "\n-- Current Scores --"
    puts "#{human.name}: #{human.score} points"
    puts "#{computer.name}: #{computer.score} points"
  end

  def winner?
    human.score > 4 || computer.score > 4
  end

  def determine_final_winner
    human.score > 4 ? :human : :computer
  end

  def display_final_winner
    case determine_final_winner
    when :human
      puts "You won the game! Congratulations!"
    when :computer
      puts "Looks like the computer won the game. Better luck next time!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "\nWould you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      score_winner
      display_scores
      break if winner?
      break unless play_again?
    end

    if winner?
      display_final_winner
    end

    display_goodbye_message
  end
end

RPSGame.new.play
