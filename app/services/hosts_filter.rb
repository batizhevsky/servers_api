class HostsFilter
  attr_reader :scope
  def initialize(scope)
    @scope = scope
  end

  def call(params)
    [:in_same_rack, :type, :location].reduce(scope) do |result, filter|
      next result unless params[filter]

      send(filter, params[filter], result)
    end
  end

  private

  def in_same_rack(host_id, current_scope)
    current_scope.in_same_rack(host_id)
  end

  def type(host_type, current_scope)
    current_scope.with_type host_type
  end

  def location(rack_location, current_scope)
    current_scope.in_location rack_location
  end
end
