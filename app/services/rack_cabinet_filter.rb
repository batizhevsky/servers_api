class RackCabinetFilter
  attr_reader :scope
  def initialize(scope)
    @scope = scope
  end

  def call(params)
    filter(params[:state])
  end

  private

  def filter(state)
    case(state.to_s)
    when 'empty'
      scope.without_hosts
    when 'multi_apc'
      scope.with_multi HostType.new('apc')
    else
      scope.all
    end
  end
end
