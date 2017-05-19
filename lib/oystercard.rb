require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
    @journey_started = false
    @journey = Journey.new
  end

  def in_journey?
    return true if @journey.info[:start] != nil && @journey.info[:finish] == nil
    return true if @journey.info[:start] == nil && @journey.info[:finish] != nil
    false
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Balance too low : Top up Please' if @balance < MINIMUM_BALANCE
    if in_journey?
      save_journey
      deduct(journey.info[:fare])
    end
    @journey = journey
    @journey.start(entry_station)
    @journey_started = true
  end

  def touch_out(exit_station)
    @journey = Journey.new if !@journey_started
    @journey.finish(exit_station)
    deduct(journey.info[:fare])
    @journey_started = false
    save_journey
  end

  private

  def save_journey
    @journeys << @journey.info
  end

  def deduct(amount)
    @balance -= amount
  end

end

p card = Oystercard.new
p card.top_up(10)
p card.touch_in(:A)
p card.touch_out(:B)
p card
