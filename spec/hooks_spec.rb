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
    lead.product = product

    lead
  end

  let(:product) do
    product = OpenStruct.new
    product.name = ''

    product
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

  context 'when source is Facebook - Mega Colchões' do
    let(:source_name) { 'Facebook - Mega Colchões' }
    before { source.name = source_name }

    context 'when is to Mogi' do
      context 'when information come in message' do
        before { lead.message = 'Loja Mega Mogi - Charlotte' }

        it 'returns Facebook - Mega Colchões' do
          expect(switch_source).to eq("#{source_name} - Mogi")
        end
      end

      context 'when information come in product' do
        before { product.name = 'Loja Mega Mogi - Charlotte' }

        it 'returns Facebook - Mega Colchões' do
          expect(switch_source).to eq("#{source_name} - Mogi")
        end
      end
    end

    context 'when is to Analia Franco' do
      context 'when information come in message' do
        before { lead.message = 'conditional_question_3: Analia Franco - Rua Emília Marengo, 327 - Mega' }

        it 'returns Facebook - Mega Colchões - Analia Franco' do
          expect(switch_source).to eq("#{source_name} - Analia Franco")
        end
      end

      context 'when information come in product' do
        before { product.name = 'Analia Franco' }

        it 'returns Facebook - Mega Colchões - Analia Franco' do
          expect(switch_source).to eq("#{source_name} - Analia Franco")
        end
      end
    end

    context 'when is to Moema' do
      context 'when lead come in message' do
        before { lead.message = 'conditional_question_3: Moema - Alameda dos Nhambiquaras, 832 - Mega' }

        it 'returns Facebook - Mega Colchões - Analia Franco' do
          expect(switch_source).to eq("#{source_name} - Moema")
        end
      end

      context 'when lead come in product' do
        before { product.name = 'Loja Mega moema - Titanium 50%off' }

        it 'returns Facebook - Mega Colchões - Analia Franco' do
          expect(switch_source).to eq("#{source_name} - Moema")
        end
      end
    end

    context 'when is to Santo André' do
      before { lead.message = 'conditional_question_3: Centro - Avenida Portugal, 1477 - Mega' }

      it 'returns Facebook - Mega Colchões - Santo André' do
        expect(switch_source).to eq("#{source_name} - Santo André")
      end
    end
  end
end
