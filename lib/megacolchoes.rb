require 'megacolchoes/version'
require 'f1sales_custom/hooks'

module Megacolchoes
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      def switch_source(lead)
        @lead = lead

        return "#{source_name} - Simmons Store" if simmons_store?
        return "#{source_name} - Mogi" if mogi?
        return "#{source_name} - Analia Franco" if analia_franco?
        return "#{source_name} - Moema" if moema?
        return "#{source_name} - Santo André" if santo_andre?

        source_name
      end

      def product_name
        @lead.product&.name&.downcase || ''
      end

      def message
        @lead.message&.downcase || ''
      end

      def source_name
        @lead.source&.name || ''
      end

      def simmons_store?
        message['simmons store'] || product_name['simmons store']
      end

      def mogi?
        message['mogi'] || product_name['mogi']
      end

      def analia_franco?
        message['lia franco'] || product_name['lia franco']
      end

      def moema?
        message['moema'] || product_name['moema']
      end

      def santo_andre?
        message['avenida portugal'] || product_name['santo andr']
      end
    end
  end
end
