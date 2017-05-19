require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def in_journey
    @journey ||= Journey.new
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Balance too low : Top up Please' if @balance < MINIMUM_BALANCE
    in_journey
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    in_journey
    @journey.finish(exit_station)
    @journeys << @journey
    @journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end

# p card = Oystercard.new
# p card.top_up(10)
# p card.touch_in(:A)
# p card.touch_out(:B)
# p card
