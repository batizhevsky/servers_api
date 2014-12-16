module Forms
  class RackCabinetUpdateForm < BaseForm
    attr_reader :rack

    def initialize(rack)
      @rack = rack
    end

    def call(params)
      rack.update!(name: params[:name], dc_location: Location.new(params[:location]))
      rack
    end
  end
end
