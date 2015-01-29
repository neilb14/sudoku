require './lib/board'

module Sudoku
	extend Board
end

puts Sudoku::load_file(ARGV.shift).inspect
