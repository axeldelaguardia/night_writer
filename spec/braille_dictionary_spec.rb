require './spec/spec_helper'

describe BrailleDictionary do
	before do
		@terminal_arguments = ['./io_files/from_braille.txt', './io_files/to_english.txt']
	end

	let(:braille_dictionary) { BrailleDictionary.new(@terminal_arguments) }

	describe '#initialize' do
		it 'exists' do
			expect(braille_dictionary).to be_a(BrailleDictionary)
		end

		it 'has attributes' do
			allow(braille_dictionary).to receive(:incoming_text).and_return('hello world')

			expect(braille_dictionary.incoming_text).to eq('hello world')
			expect(braille_dictionary.en_to_braille_dictionary['a']).to eq(['O.', '..', '..'])
			expect(braille_dictionary.en_to_braille_dictionary['f']).to eq(['OO', 'O.', '..'])
			expect(braille_dictionary.outgoing_file).to be_a(File)
		end
	end

	describe '#finished message' do
		it 'creates the message that the job has finished' do
			expect(braille_dictionary.finished_message('hello world')).to eq("Created './io_files/to_english.txt' containing 11 characters")
		end
	end

	describe 'Raise Error' do
		it 'returns an error message when the incoming file doesnt exist' do
			terminal_arguments = ['./io_files/unavailable.txt', './io_files/to_english.txt']
			braille_dictionary = BrailleDictionary.new(terminal_arguments)
			expect{braille_dictionary.io}.to output("No such file or directory @ rb_sysopen - ./io_files/unavailable.txt\n").to_stdout
		end
	end
end