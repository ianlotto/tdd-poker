require 'card'

class Deck
  
  def self.all_cards
    cards =[]
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end

    cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  def include?(card)
    @cards.include?(card)
  end

  def peek
    @cards[0]
  end

  def shuffle
    @cards.shuffle!
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise "not enough cards" if n > @cards.length
    @cards.shift(n)
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards += cards
  end

end