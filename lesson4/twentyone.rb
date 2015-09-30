# twentyone.rb

require 'pry'

class Participant
  attr_accessor :hand, :name

  def initialize
    set_name
    @hand = []
  end

  def hit
    hand << Deck.deal_card
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
  attr_reader :dealer, :player, :deck

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

  def start
    display_welcome_message
    deal_initial_cards
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end
end

Game.new.start