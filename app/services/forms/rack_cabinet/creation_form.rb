module Forms
  module RackCabinet
    class CreationForm < BaseForm
      def call(params)
        require_params! params, :name, :location

        ::RackCabinet.make(params[:name], Location.new(params[:location]))
      end
    end
  end
end
