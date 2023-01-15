class ToBraille
	attr_reader :incoming_text, :outgoing_file, :en_to_braille_dictionary
	
	def initialize(filepaths)
		@incoming_text = File.read("./io_files/#{filepaths[0]}")
		@outgoing_file = File.new("./io_files/#{filepaths[1]}", 'w')
		puts "Created '#{filepaths[1]}' containing #{incoming_text.length} characters"
		@en_to_braille_dictionary = {
			'a' => ['10', '00', '00'],
			'b' => ['11', '00', '00'],
			'c' => ['10', '01', '00'],
			'd' => ['10', '01', '10'],
			'e' => ['10', '00', '10'],
			'f' => ['11', '01', '00'],
			'g' => ['11', '01', '10'],
			'h' => ['11', '00', '10'],
			'i' => ['01', '01', '00'],
			'j' => ['01', '01', '10'],
			'k' => ['10', '10', '00'],
			'l' => ['11', '10', '00'],
			'm' => ['10', '11', '00'],
			'n' => ['10', '11', '10'],
			'o' => ['10', '10', '10'],
			'p' => ['11', '11', '00'],
			'q' => ['11', '11', '10'],
			'r' => ['11', '10', '10'],
			's' => ['01', '11', '00'],
			't' => ['01', '11', '10'],
			'u' => ['10', '10', '01'],
			'v' => ['11', '10', '01'],
			'w' => ['01', '01', '11'],
			'x' => ['10', '11', '01'],
			'y' => ['10', '11', '11'],
			'z' => ['10', '10', '11'],
			',' => ['01', '00', '00'],
			';' => ['01', '10', '00'],
			':' => ['01', '00', '10'],
			'.' => ['01', '01', '10'],
			'!' => ['01', '10', '10'],
			'(' => ['01', '11', '10'],
			')' => ['01', '11', '10'],
			'?' => ['01', '11', '00'],
			'"' => ['01', '11', '00'],
			"'" => ['00', '10', '00'],
			'-' => ['00', '11', '00'],
			' ' => ['00', '00', '00']
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