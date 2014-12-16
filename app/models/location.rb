class Location
  AVAILABLE_DC = %w[dc1 dc2]
  UnknownType = Class.new(StandardError)

  attr_reader :name
  def initialize(dc_name)
    raise(UnknownType, dc_name) unless AVAILABLE_DC.include?(dc_name)

    @name = dc_name
  end

  def ==(other)
    name == other.name
  end
end
