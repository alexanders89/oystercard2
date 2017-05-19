require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:card) { Oystercard.new }

  it 'allows journey to start' do
    expect(journey).not_to be_complete
  end
  it 'allow for a penalty fare' do
    journey.finish(:A)
    expect(journey.info[:fare]).to eq Journey::PENALTY_FARE
  end
  it 'returns the journey when exiting' do
    expect(journey.finish(:Fulham)).to eq journey
  end

  it 'Allows an entry station to be added' do
    expect(journey.start(:Fulham)).to eq journey
  end
end
