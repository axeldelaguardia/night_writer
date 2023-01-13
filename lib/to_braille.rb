class ToBraille
	attr_reader :incoming_text, :en_to_braille_dictionary
	
	def initialize(terminal_arguments)
		@incoming_text = File.read(terminal_arguments[0])
		@outgoing_file = File.new(terminal_arguments[1], 'w')

		@en_to_braille_dictionary = {
			'a' => '100000',
			'b' => '110000',
			'c' => '100100',
			'd' => '100110',
			'e' => '100010',
			'f' => '110100',
			'g' => '110110',
			'h' => '110010',
			'i' => '010100',
			'j' => '010110',
			'k' => '101000',
			'l' => '111000',
			'm' => '101100',
			'n' => '101110',
			'o' => '101010',
			'p' => '111100',
			'q' => '111110',
			'r' => '111010',
			's' => '011100',
			't' => '011110',
			'u' => '101001',
			'v' => '111001',
			'w' => '010111',
			'x' => '101101',
			'y' => '101111',
			'z' => '101011',
			',' => '010000',
			';' => '011000',
			':' => '010010',
			'.' => '010110',
			'!' => '011010',
			'(' => '011110',
			')' => '011110',
			'?' => '011100',
			'"' => '011100',
			"'" => '001000',
			'-' => '001100',
			' ' => '000000'
		}
	end

	def convert_str_to_braille_chars(str)
		braille = str.downcase.chars.map do |c|
			@en_to_braille_dictionary[c]
		end
		braille.compact
	end

	def convert_to_braille(array)
		message = ''
		3.times do |n|
			array.each do |x|
				x[n + 0].to_s == '1' ? message << "O" : message << "."
				x[n + 3].to_s == '1' ? message << "O" : message << "."
			end
			message << "\n"
		end
		message
	end

end