require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Hooks::Lead do
  let(:source_name) { 'Facebook - Simmons - mega' }
  let(:source) do
    source = OpenStruct.new
    source.name = source_name

    source
  end

  let(:lead) do
    lead = OpenStruct.new
    lead.source = source

    lead
  end

  context 'when message contains "mega-emilamerengo 327"' do
    before { lead.message = 'conditional_question_3: mega-emilamerengo 327' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons - mega - Anália Franco')
    end
  end

  context 'when message contains "mega-nhambiquaras 801"' do
    before { lead.message = 'conditional_question_3: mega-nhambiquaras 801' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons - mega - Moema')
    end
  end

  context 'when message contains "capitao manoel rudge 823"' do
    before { lead.message = 'conditional_question_3: mega-capitao manoel rudge 823' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons - mega - Mogi das Cruzes')
    end
  end
end