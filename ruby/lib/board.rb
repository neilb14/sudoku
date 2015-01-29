module Sudoku
	module Board
		def load_file(file)
			board = []
			File.open(file, 'r').each_line do |l|
				row = []
				l.each_char do |c|
					if c =~ /\d/
						row << c.to_i 
					else
						row << nil 
					end
				end
				board << row
			end
			board
		end
	end
end