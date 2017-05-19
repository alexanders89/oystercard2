class Journey
  PENALTY_FARE = 6
  MINIMUM_FARE = 2

  attr_reader :journey

  def initialize
    @journey = { start: nil, finish: nil, fare: nil }
  end

  def complete?
  end

  def fare
    @journey[:fare] = PENALTY_FARE if @journey[:start].nil? || @journey[:finish].nil?
    @journey[:fare] = MINIMUM_FARE if !@journey[:start].nil? && !@journey[:finish].nil?
  end

  def start(entry_station)
    # fail "You have already touched in" if !@journey[:start].nil?
    @journey[:start] = entry_station
    self
  end

  def finish(exit_station)
    # fail "You have already touched out" if !@journey[:finish].nil?
    @journey[:finish] = exit_station
    fare
    self
  end
end
