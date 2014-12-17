module Forms
  module RackCabinet
    class UpdateForm < BaseForm
      attr_reader :rack

      def initialize(rack)
        @rack = rack
      end

      def call(params)
        rack.name = params[:name] if params[:name]
        rack.dc_location = Location.new(params[:location]) if params[:location]
        rack.save!
        rack
      end
    end
  end
end
