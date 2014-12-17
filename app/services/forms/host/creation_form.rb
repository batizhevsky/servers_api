module Forms
  module Host
    class CreationForm < BaseForm
      def call(params)
        require_params! params, :name, :type

        ::Host.make(params[:name], HostType.new(params[:type]))
      end
    end
  end
end
