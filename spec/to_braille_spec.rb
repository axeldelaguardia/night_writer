require './spec/spec_helper'

describe ToBraille do
	before do
		@filepath = ['message.txt', 'braille.txt']
	end

	let(:translator) { ToBraille.new(@filepath) }

	describe '#initialize' do
		it 'exists' do
			expect(translator).to be_a(ToBraille)
		end

		it 'has attributes' do
			allow(translator).to receive(:incoming_text).and_return('hello world')
			expect(translator.incoming_text).to eq('hello world')
			expect(translator.en_to_braille_dictionary['a']).to eq(['10', '00', '00'])
			expect(translator.en_to_braille_dictionary['f']).to eq(['11', '01', '00'])
		end
	end
	
	describe '#convert_str_to_braille_chars' do
		it 'converts string to braille' do
			txt = 'hi'
			hi_in_braille = [["11", "00", "10"], ["01", "01", "00"]]

			expect(translator.convert_str_to_braille_chars(txt)).to eq(hi_in_braille)
		end
	end

	describe '#convert_to_braille' do
		it 'converts to printable braille' do
			hi = ["110010", "010100"]

			expect(translator.convert_to_braille(hi)).to eq("O..O\nOOO.\n....\n")
		end
	end
end