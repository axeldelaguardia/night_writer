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
		end
	end
	
end