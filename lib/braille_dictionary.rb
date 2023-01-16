class BrailleDictionary
	attr_reader :en_to_braille_dictionary, :filepaths, :incoming_text, :outgoing_file
	
	def initialize(filepaths)
		@filepaths = filepaths
		begin
			@incoming_text = File.read("#{filepaths[0]}")
		rescue Errno::ENOENT => exception
			$stderr.puts "#{filepaths[0]} is not a valid filepath. Please try again"
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
	end

	def finished_message(filename)
		puts "Created '#{filepaths[1]}' containing #{filename.length} characters"
	end
end