require "megacolchoes/version"
require "f1sales_custom/hooks"

module Megacolchoes
  class Error < StandardError; end
  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      message = lead.message
      source_name = lead.source ? lead.source.name : ''

      if message.include?('emilamerengo')
        "#{source_name} - Anália Franco"
      elsif message.include?('nhambiquaras')
        "#{source_name} - Moema"
      elsif message.include?('rudge')
        "#{source_name} - Mogi das Cruzes"
      else
        lead.source.name
      end
    end
  end
end
