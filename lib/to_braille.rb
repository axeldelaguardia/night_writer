class ToBraille
	attr_reader :incoming_text
	
	def initialize(terminal_arguments)
		@incoming_text = File.read(terminal_arguments[0])
		@outgoing_file = File.new(terminal_arguments[1], 'w')
	end
end