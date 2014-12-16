class HostType
  AVAILABLE_TYPES = %w[server switch APC]
  UnknownType = Class.new(StandardError)
  attr_reader :type

  def initialize(type)
    raise(UnknownType, type) unless AVAILABLE_TYPES.include?(type)
    @type = type
  end

  def ==(other)
    type == other.type
  end
end
