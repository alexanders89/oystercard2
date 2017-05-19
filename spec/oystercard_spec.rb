require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new(10) }
  subject(:empty_oystercard) { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station, fare: 2 } }

  it 'instance has default value of 0' do
    expect(empty_oystercard.balance).to eq(0)
  end

  describe '#top_up' do
    it 'can top up the balance' do
    expect { empty_oystercard.top_up 1 }.to change { empty_oystercard.balance }.by 1
    end
  end

  it 'raises an error if the maximum balance is exceeded' do
    empty_oystercard.top_up Oystercard::MAXIMUM_BALANCE
    expect { empty_oystercard.top_up 1 }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
  end

  describe '#touch_in' do
    it 'Allows touch in when sufficient credit present' do
    expect { oystercard.touch_in(entry_station) }.to_not raise_error
    end
    it 'Raises an error when balance below £1' do
    expect { empty_oystercard.touch_in(entry_station) }.to raise_error 'Balance too low : Top up Please'
    end

  end

  describe '#journeys' do
    it 'shows that a card has an empty list of journeys' do
    expect(oystercard.journeys).to be_empty
    end
  end
end
