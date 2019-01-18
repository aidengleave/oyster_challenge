require 'station.rb'

RSpec.describe Station do
  subject(:station) { described_class.new("station", 1) }

  it 'station has a name' do
    expect(subject.name).to eq('station')
  end

  it 'station has a zone' do
    expect(subject.zone).to eq(1)
  end
end
