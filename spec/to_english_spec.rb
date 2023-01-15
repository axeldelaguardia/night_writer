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
			expect(translator.en_to_braille_dictionary['a']).to eq(['10', '00', '00'])
			expect(translator.en_to_braille_dictionary['f']).to eq(['11', '01', '00'])
		end
	end
end