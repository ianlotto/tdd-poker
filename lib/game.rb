require 'deck'
require 'hand'

class Game
  attr_reader :pool, :players

  def initialize(deck = nil)
    if deck.nil?
      deck = Deck.new
      deck.shuffle
      @players = []
    end

    @deck = deck
  end

  def play_round
    while true
      deal_cards
      get_bets
      handle_discards
      evaluate_hands
      dispense_pool
      return_cards
    end
  end

  def add_player
    print "What is your name? "
    name = gets.chomp
    print "What is your net worth? "
    net_worth = gets.chomp.to_i
    @players << Player.new(name, net_worth)
  end

  def deal_cards
    @players.each { |player| player.hand = Hand.deal_from(@deck) }
  end

  def get_bets
    pool = 0
    @players.each { |player| pool += player.place_bet }
    @pool = pool
  end

  def handle_discards
    @players.each do |player|
      discard_indices = player.identify_discards
      discards = player.hand.return_cards(discard_indices)
      @deck.return(discards)

      player.hand.add_cards(@deck.take(discards.count))
    end
  end

  def identify_hand
  end

  def evaluate_hands
  end

  def dispense_pool(winner)
    winner.recieve_winnings(@pool)
    @pool = 0
  end

  def return_cards
    @players.each { |player| player.return_cards(@deck) }
  end

end