class ToBraille
	attr_reader :incoming_text, :outgoing_file, :en_to_braille_dictionary
	
	def initialize(terminal_arguments)
		@incoming_text = File.read("./io_files/#{terminal_arguments[0]}")
		@outgoing_file = File.new("./io_files/#{terminal_arguments[1]}", 'w')
		puts "Created '#{terminal_arguments[1]}' containing #{incoming_text.length} characters"
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
		# a1, a2, a3, a4 = [], [], [], []
		3.times do |n|
			array.each do |x|
				x[n + 0].to_s == '1' ? message << "O" : message << "."
				x[n + 3].to_s == '1' ? message << "O" : message << "."
			end
			# require 'pry'; binding.pry
			message << "\n"
		end
		message
	end

	def self.create_file(terminal_arguments)
		to_braille = ToBraille.new(terminal_arguments)
		braille_array = to_braille.convert_str_to_braille_chars(to_braille.incoming_text)
		new_text = to_braille.convert_to_braille(braille_array)
		to_braille.outgoing_file.write(new_text)
	end

end