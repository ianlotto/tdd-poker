class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returning a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    self.new(deck.take(5))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def add_cards(cards)
    @cards << cards
  end

  def return_cards(card_indicies)
    returned_cards = []
    card_indicies.each { |i| returned_cards << @cards.delete_at(i) }

    returned_cards
  end

  # def replace_cards(card_indices, cards)
#     add_cards(cards)
#     return_cards(card_indices)
#   end

  def count
    @cards.count
  end

  def to_s
    @cards.join(",")
  end
end