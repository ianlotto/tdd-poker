require 'rspec'
require 'hand'
require 'card'

describe Hand do
  let(:cards) {[
                Card.new(:spades, :ten),
                Card.new(:hearts, :five),
                Card.new(:hearts, :ace),
                Card.new(:diamonds, :deuce),
                Card.new(:hearts, :deuce)
              ]}

  subject(:hand) { Hand.new(cards) }
  its(:cards) { should =~ cards }

  describe '#initialize' do
    it 'raises an error if not five cards' do
      expect do
        Hand.new(cards[0..3])
      end.to raise_error 'must have five cards'
    end
  end

  describe '#trade_cards' do
    let!(:take_cards) { hand.cards[0..1] }
    let!(:new_cards) { [Card.new(:spades, :five), Card.new(:clubs, :three)] }

    it 'discards specified cards' do
      hand.trade_cards(take_cards, new_cards)
      hand.cards.should_not include(*take_cards)
    end

    it 'takes specified cards' do
      hand.trade_cards(take_cards, new_cards)
      hand.cards.should include(*new_cards)
    end

    it 'raises an error if trade does not result in five cards' do
      expect do
        hand.trade_cards(hand.cards[0..0], new_cards)
      end.to raise_error 'must have five cards'
    end

    it 'raises an error if trade tries to discard unowned card' do
      expect do
        hand.trade_cards([Card.new(:hearts, :ten)], new_cards[0..0])
      end.to raise_error 'cannot discard unowned card'
    end
  end
end