module Forms
  class RackCabinetDestroyForm < BaseForm
    attr_reader :rack

    def initialize(rack)
      @rack = rack
    end

    def call

    end
  end
end
