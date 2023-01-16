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

	describe '#convert_columns_to_braille' do
		it 'converts columns to braille arrays' do
			columns = [[["O", "."], ["O", "."], ["O", "."], ["O", "."], ["O", "."]], 
								 [["O", "O"], [".", "O"], ["O", "."], ["O", "."], [".", "O"]], 
								 [[".", "."], [".", "."], ["O", "."], ["O", "."], ["O", "."]]]

			hello = [['O.', 'OO', '..'], ['O.', '.O', '..'], ['O.', 'O.', 'O.'], 
							 ['O.', 'O.', 'O.'], ['O.', '.O', 'O.']]

			expect(translator.convert_columns_to_braille(columns)).to eq(hello)
		end
	end

	describe '#translate_to_english' do
		it 'translates braille arrays to english characters' do
			hello = [['O.', 'OO', '..'], ['O.', '.O', '..'], ['O.', 'O.', 'O.'], 
							 ['O.', 'O.', 'O.'], ['O.', '.O', 'O.']]

			expect(translator.translate_to_english(hello)).to eq('hello')
		end
	end

	describe '#braille_to_text' do
		it 'integrates all methods and braille to english' do
			braille = ".OO.O...OOO..OOOO...O.O.O..OOO..OOO.OO...OO.OOOO.O..O.O.O.O....OO.O...O.O.O.OO..\nOOOO.O..OO..O.......O.OO.OOO.O..O..O....OO....O.O....OO..OOO..OOOO.O..O....O.O..\nO.......O.OO....O.....O.O..OO.....O.OO....OOO.O.O...O.OO..O...O.......O...OOOO..\nOOO.OO\n.O.OOO\n..O..."

			expect(translator.braille_to_text(braille)).to eq("the quick brown fox jumps over the lazy dog")
		end
	end

	describe '#create_file' do
		it 'runs all methods, converts braille to english and writes on new file' do
			expect(ToEnglish.create_file(@terminal_arguments)).to eq("Created './io_files/to_english.txt' containing 177 characters")
		end
	end
end