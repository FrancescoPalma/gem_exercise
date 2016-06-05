module Fxify
  class ECBData
    class ExchangeDate
      attr_accessor :day, :currencies

      def initialize(day, currencies)
        @day, @currencies = day, currencies
      end 
    end

    class Currency 
      attr_accessor :name, :value

      def initialize(attributes={})
        attributes.each { |k,v| send("#{k}=", v) }
      end
    end
  end 
end  