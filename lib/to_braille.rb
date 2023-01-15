class ToBraille
	attr_reader :incoming_text, :outgoing_file, :en_to_braille_dictionary
	
	def initialize(filepaths)
		begin
			@incoming_text = File.read("#{filepaths[0]}")
		rescue Errno::ENOENT => exception
			$stderr.puts "Incoming file not found. Please use the correct filepath"
			exit -1
		end
		@outgoing_file = File.new("#{filepaths[1]}", 'w')
		@en_to_braille_dictionary = {
			'a' => ['O.', '..', '..'],
      'b' => ['O.', 'O.', '..'],
      'c' => ['OO', '..', '..'],
      'd' => ['OO', '.O', '..'],
      'e' => ['O.', '.O', '..'],
      'f' => ['OO', 'O.', '..'],
      'g' => ['OO', 'OO', '..'],
      'h' => ['O.', 'OO', '..'],
      'i' => ['.O', 'O.', '..'],
      'j' => ['.O', 'OO', '..'],
      'k' => ['O.', '..', 'O.'],
      'l' => ['O.', 'O.', 'O.'],
      'm' => ['OO', '..', 'O.'],
      'n' => ['OO', '.O', 'O.'],
      'o' => ['O.', '.O', 'O.'],
      'p' => ['OO', 'O.', 'O.'],
      'q' => ['OO', 'OO', 'O.'],
      'r' => ['O.', 'OO', 'O.'],
      's' => ['.O', 'O.', 'O.'],
      't' => ['.O', 'OO', 'O.'],
      'u' => ['O.', '..', 'OO'],
      'v' => ['O.', 'O.', 'OO'],
      'w' => ['.O', 'OO', '.O'],
      'x' => ['OO', '..', 'OO'],
      'y' => ['OO', '.O', 'OO'],
      'z' => ['O.', '.O', 'OO'],
			',' => ['..', 'O.', '..'],
			';' => ['..', 'O.', 'O.'],
			':' => ['..', 'OO', '..'],
			'.' => ['..', 'OO', '.O'],
			'!' => ['..', 'OO', 'O.'],
			'(' => ['..', 'OO', 'OO'],
			')' => ['..', 'OO', 'OO'],
			'?' => ['..', 'O.', 'OO'],
			'"' => ['..', '.O', 'OO'],
			"'" => ['..', '..', 'O.'],
			'-' => ['..', '..', 'OO'],
			' ' => ['..', '..', '..']
		}
		puts "Created '#{filepaths[1]}' containing #{incoming_text.length} characters"
	end

	def convert_str_to_braille_arrays(str)
		braille = str.downcase.chars.map do |c|
			@en_to_braille_dictionary[c]
		end
		braille.compact
	end

	def split_into_printable_rows(braille_arrays)
		first_row = []
		second_row = []
		third_row = []
		braille_arrays.map do |braille_array|
			first_row << braille_array[0]
			second_row << braille_array[1]
			third_row << braille_array[2]
		end
		[first_row.join, second_row.join, third_row.join]
	end

	def translate_to_txt(array_with_strings)
		message = ''
		array_with_strings[0].chars.each_slice(80).to_a.count.times do |num|
			array_with_strings.map do |string|
				message << string.chars.each_slice(80).to_a[num].join << "\n"
			end
		end
		message.chop
	end

	def self.create_file(terminal_arguments)
		to_braille = ToBraille.new(terminal_arguments)
		braille_arrays = to_braille.convert_str_to_braille_arrays(to_braille.incoming_text)
		printable_rows = to_braille.split_into_printable_rows(braille_arrays)
		final_text = to_braille.translate_to_txt(printable_rows)
		to_braille.outgoing_file.write(final_text)
	end

end