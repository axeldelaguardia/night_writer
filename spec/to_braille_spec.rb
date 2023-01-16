require './spec/spec_helper'

describe ToBraille do
	before do
		@filepath = ['./io_files/message.txt', './io_files/braille.txt']
	end

	let(:translator) { ToBraille.new(@filepath) }

	describe '#initialize' do
		it 'exists' do
			expect(translator).to be_a(ToBraille)
		end

		it 'has attributes' do
			allow(translator).to receive(:incoming_text).and_return('hello world')
			expect(translator.incoming_text).to eq('hello world')
			expect(translator.en_to_braille_dictionary['a']).to eq(['O.', '..', '..'])
			expect(translator.en_to_braille_dictionary['f']).to eq(['OO', 'O.', '..'])
		end
	end
	
	describe '#convert_str_to_braille_arrays' do
		it 'converts string to braille' do
			txt = 'hi'
			hi_in_braille = [['O.', 'OO', '..'], ['.O', 'O.', '..']]

			expect(translator.convert_str_to_braille_arrays(txt)).to eq(hi_in_braille)
		end
	end

	describe '#split_into_printable_rows' do
		it 'splits braille chars into three printable rows' do
			hello_in_braille = [['O.', 'OO', '..'], ['O.', '.O', '..'], ['O.', 'O.', 'O.'], 
													['O.', 'O.', 'O.'], ['O.', '.O', 'O.']]

			converted_to_rows = ["O.O.O.O.O.", "OO.OO.O..O", "....O.O.O."]

			expect(translator.split_into_printable_rows(hello_in_braille)).to eq(converted_to_rows)
		end
	end

	describe '#translate_to_txt' do
		it 'translates an array to a single string and ready to write on a text file' do
			dots_and_os = ['OOO.OOOOO.', '....O.O.O.', 'O.O.....O.']

			expect(translator.translate_to_txt(dots_and_os)).to eq("OOO.OOOOO.\n....O.O.O.\nO.O.....O.")
		end
	end

	describe '#string_to_text_format' do
		it 'combines all methods to convert the string to text format ' do
			incoming_text = 'hello world'

			expected = "O.O.O.O.O....OO.O.O.OO\nOO.OO.O..O..OO.OOOO..O\n....O.O.O....OO.O.O..."
			
			allow(translator).to receive(:incoming_text).and_return(incoming_text)

			expect(translator.string_to_text_format(incoming_text)).to eq(expected)
		end
	end

	describe '#create_file' do
		it 'runs all methods, converts english to braille and writes on new file' do
			expect(ToBraille.create_file(@filepath)).to eq("Created './io_files/braille.txt' containing 43 characters")
		end
	end
end