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

  context 'when message contains "rua_emilia_marengo,_327" - Facebook promotion' do
    before { lead.message = 'por_qual_loja_você_prefere_ser_atendido?_: loja_anália_franco:_rua_emilia_marengo,_327_-_jardim_anália_franco_-_são_paulo_-_sp' }

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

  context 'when message does not have a specific address' do
    before { lead.message = 'conditional_question_3:' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons - mega')
    end
  end
end