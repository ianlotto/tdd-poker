class Player
  attr_reader :name, :bankroll
  attr_accessor :hand

  def initialize(name, bankroll)
    @name, @bankroll = name, bankroll
  end

  def place_bet
    print "#{name.capitalize}, please place your bet: "
    bet = gets.chomp.to_i
    raise "player can't cover bet" if @bankroll < bet

    @bankroll -= bet
    bet
  end

  def identify_discards
    puts hand.to_s
    print "#{name.capitalize}, which cards would you like to discard? (1, 2...) "
    gets.chomp.split(', ').map { |char| char.to_i - 1 }
  end

  def recieve_winnings(winnings)
    @bankroll += winnings
  end

  def return_cards(deck)
    cards = hand.return_cards((0..4).to_a)
    @hand = nil
    deck.return(cards)
  end
end
