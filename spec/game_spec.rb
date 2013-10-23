require 'rspec'
require 'game'
require 'player'

describe Game do
  subject(:game) { Game.new(deck) }

  let(:deck)    { Deck.new }
  let(:players) { [player1, player2] }
  let(:player1) { Player.new("player1", 100) }
  let(:player2) { Player.new("player2", 200) }

  describe "#add_player" do
    it "adds a player to players array" do
      game.stub!(:gets).and_return("1")
      expect do
        game.add_player
      end.to change { game.players.length }
    end
  end

  describe "#deal_cards" do
    it "deals hand to all players" do
      game.deal_cards
      game.players.all? { |player| player.hand.count == 5 }.should == true
    end
  end

  describe "#get_bets" do
    it "calls bet on all players" do
      game.players.all? { |player| player.should_receive(:place_bet) }.should == true
    end

    it "holds a pool of bets" do
      expect do
        game.get_bets
      end.to change { game.pool }
    end

  end

  describe "#handle_discards" do
    it "places discards onto the bottom of the deck" do
      expect do

        player.stub!(:gets).and_return("1")
        game.handle_discards
      end.to_not change { game.deck.length }
    end


    it "returns the same number of cards to the player" do
      expect do

        player.stub!(:gets).and_return("1")
        game.handle_discards
      end.to_not change { game.player[0].hand.count }
    end

  end

  describe "#identify_hand" do
    it "identifies the type of hand" do
      deck = Deck.new
      hand = Hand.deal_from(deck)

      game.identify_hand(hand).should == :straight_flush
    end
  end

  describe "#evaluate_hands" do
    it "identifies the best hand" do
      deck = Deck.new
      hand = Hand.deal_from(deck)
      hand2 = Hand.deal_from(deck)

      game.evaluate_hands([hand, hand2]).should == 1
    end
  end

  describe "#dispense_pool" do
    it "dispenses the pool to the winner" do
      expect do
        game.pool = 1
        winner = Player.new("Unlce Bob", 1_000)
        game.dispense_pool(winner)
      end.to change { winner.bankroll }
    end
  end

  describe "#return_cards" do
    it "returns all cards to the deck" do
      expect do
        game.return_cards
      end.to change { game.deck.count }
    end
  end

  describe "#play_round" do
    it "goes through the steps of a round" do
      [:deal_cards,
        :get_bets,
        :replace_discards,
        :evaluate_hands,
        :dispense_pool,
        :return_cards].each do |step|
        game.should_receive(step).ordered
      end

      game.play_round
    end
  end

end