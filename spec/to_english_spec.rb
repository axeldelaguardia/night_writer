require './spec/spec_helper'

describe ToEnglish do
	before do
		@terminal_arguments = ['./io_files/from_braille.txt', './io_files/to_english.txt']
	end

	let(:translator) { ToEnglish.new(@terminal_arguments) }

	describe '#initialize' do
		it 'exists' do
			expect(translator).to be_a(ToEnglish)
		end

		it 'has attributes' do
			allow(translator).to receive(:incoming_text).and_return('hello world')
			expect(translator.incoming_text).to eq('hello world')
			expect(translator.en_to_braille_dictionary['a']).to eq(['O.', '..', '..'])
			expect(translator.en_to_braille_dictionary['f']).to eq(['OO', 'O.', '..'])
		end
	end

	describe '#split_text_to_rows' do
		it 'splits text into rows' do
			text = "O.O.O.O.O.\nOO.OO.O..O\n....O.O.O."

			expected = [
				["O", ".", "O", ".", "O", ".", "O", ".", "O", "."],
				["O", "O", ".", "O", "O", ".", "O", ".", ".", "O"],
				[".", ".", ".", ".", "O", ".", "O", ".", "O", "."]
			]

			expect(translator.split_text_to_rows(text)).to eq(expected)
		end
	end

	describe '#split_text_to_columns' do
		it 'splits text into columns' do
			rows = [
				["O", ".", "O", ".", "O", ".", "O", ".", "O", "."],
				["O", "O", ".", "O", "O", ".", "O", ".", ".", "O"],
				[".", ".", ".", ".", "O", ".", "O", ".", "O", "."]
			]

			expected = [[["O", "."], ["O", "."], ["O", "."], ["O", "."], ["O", "."]], 
									[["O", "O"], [".", "O"], ["O", "."], ["O", "."], [".", "O"]], 
									[[".", "."], [".", "."], ["O", "."], ["O", "."], ["O", "."]]]

			expect(translator.split_text_to_columns(rows)).to eq(expected)
		end
	end
end