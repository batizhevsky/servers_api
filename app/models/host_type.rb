class HostType
  AVAILABLE_TYPES = %w[server switch apc]
  UnknownType = Class.new(StandardError)
  attr_reader :type

  def initialize(type)
    type.downcase!
    raise(UnknownType, type) unless AVAILABLE_TYPES.include?(type)
    @type = type
  end

  def ==(other)
    type == other.type
  end
end
