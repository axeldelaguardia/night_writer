require './spec/spec_helper'

describe ToBraille do
	before do
		@terminal_arguments = ['./io_files/message.txt', './io_files/braille.txt']
	end

	let(:translator) { ToBraille.new(@terminal_arguments) }

	describe '#initialize' do
		it 'exists' do
			expect(translator).to be_a(ToBraille)
		end

		it 'has attributes' do
			expect(translator.incoming_text).to eq('hello world')
			expect(translator.en_to_braille_dictionary['a']).to eq('100000')
			expect(translator.en_to_braille_dictionary['f']).to eq('110100')
		end
	end
	
	describe '#convert_str_to_braille_chars' do
		it 'converts string to braille' do
			txt = 'hi'

			expect(translator.convert_str_to_braille_chars(txt)).to eq(["110010", "010100"])
		end
	end

	describe '#convert_to_braille' do
		it 'converts to printable braille' do
			hi = ["110010", "010100"]

			expect(translator.convert_to_braille(hi)).to eq("O..O\nOOO.\n....\n")
		end
	end
end