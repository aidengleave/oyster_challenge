require 'Oystercard'


RSpec.describe Oystercard do
  it 'Card has a default balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq(0)
  end

context '#top_up' do
  it 'checks that if a top_up method is invoked with the top up value as the argument' do
    card = Oystercard.new
    amount = double('some value')
    expect(card.top_up(amount))
  end
end


end
