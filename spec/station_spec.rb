require 'station'

describe Station do
  subject { described_class.new('Fulham', 2) }
  it 'should have a name' do
    expect(subject.name).to eq 'Fulham'
  end

  it 'should have a zone' do
    expect(subject.zone).to eq 2
  end
end
