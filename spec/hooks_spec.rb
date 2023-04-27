require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Hooks::Lead do
  let(:source_name) { 'Diferent Source' }
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

  let(:switch_source) { described_class.switch_source(lead) }

  it 'when is from a Diferent source' do
    expect(switch_source).to eq('Diferent Source')
  end

  context 'when lead come from Simmons' do
    context 'when lead come with Facebook source' do
      before do
        lead.message = 'conditional_question_3: Analia Franco Tatuape - Rua Itapura, 1352 - Simmons Store'
        source.name = 'Simmons - Facebook'
      end

      it 'returns source name' do
        expect(switch_source).to eq('Simmons - Facebook - Simmons Store')
      end
    end

    context 'when lead come with Widgrid Simmons source' do
      before do
        lead.message = 'Simmons - ESC - Analia Franco Tatuape - Rua Itapura, 1352 - Simmons Store'
        source.name = 'Simmons - Widgrid'
      end

      it 'returns source name' do
        expect(switch_source).to eq('Simmons - Widgrid - Simmons Store')
      end
    end
  end
end
