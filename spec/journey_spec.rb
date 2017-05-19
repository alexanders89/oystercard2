require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  # let(:station) { double :station, zone: 1 }

  it 'allows journey to start' do
    expect(journey).not_to be_complete
  end
  it 'allow for a penalty fare' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end
  it 'returns the journey when exiting' do
    expect(journey.finish(:Fulham)).to eq journey
  end

  it 'Allows an entry station to be added' do
    expect(journey.start(:Fulham)).to eq journey
  end

  it 'will only hold 2 stations in journey' do
    journey.start(:Fulham)
    journey.finish(:PG)
    expect { journey.start(:Fulham) }.to raise_error "You've already touched in"
  end

  it 'will only allow one exit station to be added to journey' do
    journey.finish(:ParsonsGreen)
    expect { journey.finish(:ParsonsGreen) }.to raise_error 'Already tched out'
  end
end
