require './lib/braille_dictionary'

class ToBraille < BrailleDictionary
	
	def initialize(filepaths)
		super(filepaths)
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

	def string_to_text_format(string)
		braille_arrays = convert_str_to_braille_arrays(incoming_text)
		printable_rows = split_into_printable_rows(braille_arrays)
		final_text = translate_to_txt(printable_rows)
	end

	def self.create_file(terminal_arguments)
		to_braille = ToBraille.new(terminal_arguments)
		final_text = to_braille.string_to_text_format(to_braille.incoming_text)
		to_braille.outgoing_file.write(final_text)
		to_braille.finished_message(to_braille.incoming_text)
	end

end