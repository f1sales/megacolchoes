require 'megacolchoes/version'
require 'f1sales_custom/hooks'

module Megacolchoes
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      message = lead.message&.downcase || ''
      source_name = lead.source ? lead.source.name : ''

      if message['simmons store']
        "#{source_name} - Simmons Store"
      else
        source_name
      end
    end
  end
end
