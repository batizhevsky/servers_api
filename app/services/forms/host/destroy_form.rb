module Forms
  module Host
    class DestroyForm < BaseForm
      attr_reader :record

      def initialize(record)
        @record = record
      end

      def call
        record.destroy!
      end
    end
  end
end
