require 'megacolchoes/version'
require 'f1sales_custom/hooks'

module Megacolchoes
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      def switch_source(lead)
        @lead = lead

        return "#{source_name} - Simmons Store" if message['simmons store']
        return "#{source_name} - Mogi" if message['mogi'] || product_name['mogi']
        return "#{source_name} - Analia Franco" if message['analia franco'] || product_name['analia franco']
        return "#{source_name} - Moema" if message['moema'] || product_name['moema']
        return "#{source_name} - Santo André" if message['avenida portugal']

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
    end
  end
end
