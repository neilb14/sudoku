require './lib/board'

module Sudoku
	extend Board
end

board = Sudoku::load_file(ARGV.shift)
Sudoku::solve(board)
Sudoku::display(board)
