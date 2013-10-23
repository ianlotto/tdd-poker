require 'rspec'
require 'card'
require 'deck'
require 'hand'

describe Hand do
  describe "::deal_from" do
    it "deals a hand of five cards" do
      cards = [
        Card.new(:spades,   :deuce),
        Card.new(:clubs,    :three),
        Card.new(:hearts,   :four),
        Card.new(:diamonds, :five),
        Card.new(:spades,   :queen)
      ]

      deck = Deck.new(cards.dup)
      hand = Hand.deal_from(deck)

      deck.count.should == 0
      hand.cards.should =~ cards
    end
  end

  # context "with bad hand" do
  #   subject(:bad_hand) do
  #     Hand.new([
  #         Card.new(:spades, :deuce),
  #         Card.new(:clubs,  :four),
  #         Card.new(:spades, :six),
  #         Card.new(:clubs,  :eight),
  #         Card.new(:hearts, :nine)
  #       ])
  #
  #     deck = Deck.new(cards.dup)
  #   end

    # describe "#return_cards" do
#
#       it "reduces the size of your hand" do
#         bad_hand.
#       end
#
#       it "increases the size of the deck"
#
#     end
#
#     describe "#add_cards" do
#
#       it "increases the size of your hand"
#       it "decreases the size of the deck"
#       it "will not increase hand size above five"
#
#     end

    describe "#replace_cards" do

      it "changes the cards in your hand" do
        cards = [
          Card.new(:spades,   :deuce),
          Card.new(:clubs,    :three),
          Card.new(:hearts,   :four),
          Card.new(:diamonds, :five),
          Card.new(:spades,   :queen),
          Card.new(:spades,   :six)
        ]

        deck = Deck.new(cards.dup)
        hand = Hand.deal_from(deck)
        expect do
          hand.replace_cards([1], deck.take(1))
        end.to change{ hand.cards }
      end

      it "keeps the hand size at five" do
        cards = [
          Card.new(:spades,   :deuce),
          Card.new(:clubs,    :three),
          Card.new(:hearts,   :four),
          Card.new(:diamonds, :five),
          Card.new(:spades,   :queen),
          Card.new(:spades,   :six)
        ]

        deck = Deck.new(cards.dup)
        hand = Hand.deal_from(deck)
        expect do
          hand.replace_cards([1], deck.take(1))
        end.to_not change{ hand.count }
      end

    end

  # end

end