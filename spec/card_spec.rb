require 'rspec'
require 'card'

describe Card do
  subject(:card) do
    Card.new(:clubs, :ace)
  end

  its(:suit) { should == :clubs }
  its(:value) { should == :ace }
end