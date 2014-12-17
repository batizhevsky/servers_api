module Forms
  module Host
    class UpdateForm < BaseForm
      attr_reader :record

      def initialize(record)
        @record = record
      end

      def call(params)
        record.name = params[:name] if params[:name]
        record.save!
        record
      end
    end
  end
end
