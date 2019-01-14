require 'Oystercard'

RSpec.describe Oystercard do

  it 'Card has a default balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq(0)
  end

end
