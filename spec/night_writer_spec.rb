require './lib/spec_helper'

descibe NightWriter do
	let(:writer) { NightWriter.new }

	describe '#initialize' do
		expect(writer).to be_a(NightWriter)
	end
end