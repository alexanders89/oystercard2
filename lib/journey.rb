class Journey
  PENALTY_FARE = 6
  MINIMUM_FARE = 2

  attr_reader :info

  def initialize
    @info = { start: nil, finish: nil, fare: nil }
  end

  def incomplete?
    return true if @info[:start].nil? || @info[:finish].nil?
    false
  end

  def terminate_incomplete_journey
    if incomplete?
      fare
      return @info
    end
  end

  def fare
    @info[:fare] = PENALTY_FARE if @info[:start].nil? || @info[:finish].nil?
    @info[:fare] = MINIMUM_FARE if !@info[:start].nil? && !@info[:finish].nil?
    nil
  end

  def start(entry_station)
    # fail "You have already touched in" if !@info[:start].nil?
    terminate_incomplete_journey

    @info[:start] = entry_station
    fare
    self
  end

  def finish(exit_station)
    # fail "You have already touched out" if !@info[:finish].nil?
    @info[:finish] = exit_station
    fare
    self
  end
end
