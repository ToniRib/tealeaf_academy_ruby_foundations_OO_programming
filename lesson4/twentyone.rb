# twentyone.rb

require 'pry'
require 'pry-nav'

class Participant
  attr_accessor :hand, :name

  def initialize
    set_name
    @hand = []
  end

  def busted?
    total > 21
  end

  def total
    total = 0
    hand.each do |card|
      if card.numeric?
        total += card.value.to_i
      elsif card.face?
        total += 10
      elsif card.ace?
        total += 11
      end
    end

    hand.select(&:ace?).count.times do
      total -= 10 if total > 21
    end

    total
  end

  def show_hand
    puts "#{name}'s Hand:"
    hand.each { |card| puts "> #{card.to_s}" }
    puts "Total: #{total}"
  end
end

class Player < Participant
  def set_name
    n = nil
    loop do
      puts 'What is your name?'
      n = gets.chomp.capitalize
      break unless n.empty?
      puts 'Please enter a name to play'
    end
    self.name = n
  end
end

class Dealer < Participant
  DEALER_NAMES = %w(Dan Nick Max Arjun Sonja Morgan)

  def set_name
    self.name = DEALER_NAMES.sample
  end

  def show_initial_hand
    puts "#{name}'s Hand:"
    puts "> #{hand[0].to_s}"
    puts "> unknown card"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @cards << Card.new(suit, value)
      end
    end
    @cards.shuffle!
  end

  def deal_card
    cards.pop
  end
end

class Card
  SUITS = %w(clubs spades diamonds hearts)
  VALUES = %w(2 3 4 5 6 7 8 9 10 jack queen king ace)

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def numeric?
    value.to_i > 0
  end

  def face?
    value == 'jack' || value == 'queen' || value == 'king'
  end

  def ace?
    value == 'ace'
  end

  def to_s
    "#{value} of #{suit}"
  end
end

class Game
  attr_reader :dealer, :player
  attr_accessor :deck

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def display_welcome_message
    puts "----------------------"
    puts "Welcome to Twenty-One!"
    puts "----------------------"
  end

  def deal_initial_cards
    2.times do
      dealer.hand << deck.deal_card
      player.hand << deck.deal_card
    end
  end

  def show_initial_cards
    player.show_hand
    dealer.show_initial_hand
  end

  def show_cards
    player.show_hand
    dealer.show_hand
  end

  def player_turn
    puts "\n#{player.name}'s Turn:"
    puts "---------------"

    loop do
      answer = nil
      puts "\nWould you like to (h)it or (s)tay?"
      loop do
        answer = gets.chomp.downcase
        break if %w(h s).include?(answer)
        puts "Please enter either 'h' or 's'"
      end

      if answer == 's'
        puts "#{player.name} chose to stay."
        break
      elsif player.busted?
        break
      else
        player.hand << deck.deal_card
        player.show_hand
        break if player.busted?
      end
    end
  end

  def dealer_turn
    puts "\n#{dealer.name}'s Turn"
    puts "---------------"
    dealer.show_hand

    loop do
      if dealer.total >= 17  && !dealer.busted?
        puts "#{dealer.name} chose to stay."
        break
      elsif dealer.busted?
        break
      else
        dealer.hand << deck.deal_card
        dealer.show_hand
      end
    end
  end

  def show_busted
    if player.busted?
      puts "#{player.name} busted! That means #{dealer.name} wins!"
    elsif dealer.busted?
      puts "#{dealer.name} busted! That means #{player.name} wins!"
    end
  end

  def play_again?
    answer = nil

    loop do
      puts 'Would you like to play again?'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts 'Sorry, must be y or n'
    end

    answer == 'y'
  end

  def reset
    system 'clear'
    puts "Shuffling new deck..."
    self.deck = Deck.new
    player.hand = []
    dealer.hand = []
  end

  def display_goodbye_message
    puts 'Thank you for playing Twenty-One! Goodbye!'
  end

  def show_both_hands
    puts "\nFinal Cards"
    puts "---------------"
    player.show_hand
    dealer.show_hand
  end

  def determine_winner
    if player.total > dealer.total
      :player
    elsif dealer.total > player.total
      :dealer
    else
      :tie
    end
  end

  def display_result
    case determine_winner
    when :player
      puts "#{player.name} beat #{dealer.name}!"
    when :dealer
      puts "#{dealer.name} beat #{player.name}!"
    when :tie
      puts "It's a tie!"
    end
  end

  def start
    system 'clear'
    display_welcome_message

    loop do # main game loop
      deal_initial_cards
      show_initial_cards

      player_turn
      if player.busted?
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end

      dealer_turn
      if dealer.busted?
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end

      show_both_hands
      display_result

      play_again? ? reset : break
    end

    display_goodbye_message
  end
end

Game.new.start