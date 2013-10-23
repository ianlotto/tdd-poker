require 'rspec'
require 'deck'
require 'hand'
require 'player'



describe Player do
  subject(:player) do
    Player.new("Nick the Greek", 200_000)
  end

  let(:deck) do
    Deck.new([
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :nine),
        Card.new(:spades, :queen),
        Card.new(:spades, :seven)
      ])
  end

  before do
    player.hand = Hand.deal_from(deck)
  end

  its(:name) { should == "Nick the Greek" }
  its(:bankroll) { should == 200_000 }
  its("hand.cards.count") { should == 5 }

  # describe "#place_bet" do
#     let(:game) { double("game", :take_bet => nil) }
#
#     it "registers bet with game" do
#
#       player.stub!(:gets).and_return("10000")
#       #@mirror.should_receive(:puts).with("phrase")
#       player.place_bet(game)
#
#       game.should_receive(:take_bet).with(player, 10_000)
#     end
#
#     it "deducts bet from bankroll" do
#       player.stub!(:gets).and_return("10000")
#       player.place_bet(game)
#
#       player.bankroll.should == 190_000
#     end
#
#     it "enforces limits" do
#       player.stub!(:gets).and_return("1000000000")
#       expect do
#         player.place_bet(game)
#       end.to raise_error("player can't cover bet")
#     end
#
#   end

  describe "#recieve_winnings" do
    it "adds to winnings" do
      expect do
        player.recieve_winnings(200)
      end.to change{player.bankroll}.by(200)
    end
  end

  describe "#return_cards" do
    it "returns player's cards to the deck" do
      deck = double("deck")
      #player.hand.add_cards([Card.new(:hearts,:three), Card.new(:hearts,:nine)])
      player.return_cards(deck)
      player.hand.should_receive(:return_cards).with([0,1,2,3,4])

    end

    it "resets hand to nil" do
      player.return_cards(deck)
      player.hand.should be_nil
    end
  end
end