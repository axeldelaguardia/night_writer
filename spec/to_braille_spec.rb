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
	
	describe '#convert_str_to_braille_arrays' do
		it 'converts string to braille' do
			txt = 'hi'
			hi_in_braille = [["11", "00", "10"], ["01", "01", "00"]]

			expect(translator.convert_str_to_braille_arrays(txt)).to eq(hi_in_braille)
		end
	end

	describe '#split_into_printable_rows' do
		it 'splits braille chars into three printable rows' do
			hello_in_braille = [["11", "00", "10"], ["10", "00", "10"], ["11", "10", "00"], 
													["11", "10", "00"], ["10", "10", "10"]]

			converted_to_rows = [['11', '10', '11', '11', '10'], ['00', '00', '10', '10', '10'],
													 ['10', '10', '00', '00', '10']]

			expect(translator.split_into_printable_rows(hello_in_braille)).to eq(converted_to_rows)
		end
	end

	describe 'convert_nums_to_dots' do
		it 'converts 1s and 0s to dots or Os' do
			string = '11001001110'

			expect(translator.convert_nums_to_dots(string)).to eq('OO..O..OOO.')
		end
	end

	describe 'convert_all_rows_to_dots' do
		it 'converts multiple arrays into dots' do
			rows = [['11', '10', '11', '11', '10'], ['00', '00', '10', '10', '10'],
								['10', '10', '00', '00', '10']]

			dots_and_os = ['OOO.OOOOO.', '....O.O.O.', 'O.O.....O.']

			expect(translator.convert_all_rows_to_dots(rows)).to eq(dots_and_os)
		end
	end

	describe '#translate_to_txt' do
		it 'translates an array to a single string and ready to write on a text file' do
			dots_and_os = ['OOO.OOOOO.', '....O.O.O.', 'O.O.....O.']

			expect(translator.translate_to_txt(dots)).to eq("OOO.OOOOO.\n....O.O.O.\nO.O.....O.")
		end
	end
	
	# describe '#convert_to_braille' do
	# 	it 'converts to printable braille' do
	# 		hi = ["110010", "010100"]

	# 		expect(translator.convert_to_braille(hi)).to eq("O..O\nOOO.\n....\n")
	# 	end
	# end
end