require './lib/braille_dictionary'

class ToEnglish < BrailleDictionary
	
	def initialize(filepaths)
		super(filepaths)
	end

	def self.create_file(terminal_arguments)
		to_english = ToEnglish.new(terminal_arguments)
		final_text = to_english.braille_to_text(to_english.incoming_text)
		to_english.outgoing_file.write(final_text)
		p to_english.finished_message(final_text)
	end

	def braille_to_text(incoming_text)
		exit_if_not_exist(incoming_text)
		rows = split_text_to_rows(incoming_text)
		columns = split_text_to_columns(rows)
		braille_arrays = convert_columns_to_braille(columns)
		translate_to_english(braille_arrays)
	end

	def split_text_to_rows(incoming_text)
		incoming_text.split.map {|row| row.chars}
	end

	def split_text_to_columns(rows)
		rows.map {|y| y.each_slice(2).to_a}
	end
	
	def convert_columns_to_braille(columns)
		letters = []
		row_pairs = columns.each do |row|
			row.map!(&:join)
		end
		row_pairs.each_slice(3).map do |letter|
			letters += letter.transpose
		end
		letters
	end

	def translate_to_english(braille_arrays)
		text = ''
		braille_arrays.each do |braille_letter|
			text << @en_to_braille_dictionary.key(braille_letter)
		end
		convert_to_caps(text)
	end

	def convert_to_caps(text)
		message = ''
		text.chars.each_with_index do |x, y|
			text.chars[y-1] == '|' ? message << x.upcase : message << x
		end
		message.gsub('|', '')
	end
end