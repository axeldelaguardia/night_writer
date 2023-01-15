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
		[first_row, second_row, third_row]
	end

	def convert_nums_to_dots(string)
		message = ''
		string.chars.each do |char|
			char == '1' ? message << "O" : message << "."
		end
		message
	end

	def convert_all_rows_to_dots(array_of_rows)
		three_rows = []
		array_of_rows.each do |row|
			three_rows << convert_nums_to_dots(row.join)
		end
		three_rows
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
		ready_rows = to_braille.convert_all_rows_to_dots(printable_rows)
		final_text = to_braille.translate_to_txt(ready_rows)
		to_braille.outgoing_file.write(final_text)
	end

end