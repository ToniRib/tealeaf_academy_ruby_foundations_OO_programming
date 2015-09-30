# twentyone.rb

require 'pry'

class Participant
  def initialize(name)
    @name = name
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Player < Participant
end

class Dealer < Participant
end

class Deck
  SUITES = %w(clubs spades diamonds hearts)

  def initialize

  end
end

class Card
  def initialize

  end
end

class Game
  def initialize
    @deck = Deck.new
    @player = Player.new(player_name)
    @dealer = Dealer.new(dealer_name)
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start