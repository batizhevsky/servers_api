module Forms
  class RackCabinetCreationForm < BaseForm
    attr_reader :rack

    def initialize(rack = ::RackCabinet.new)
      @rack = rack
    end

    def call(params)
      require_params! params, :name, :location

      RackCabinetRepository.create_from_api!(params)
    end
  end
end
