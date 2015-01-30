module Sudoku
	module Board
		def load_file(file)
			board = []
			File.open(file, 'r').each_line do |l|
				row = []
				l.each_char do |c|
					if c =~ /\d/
						row << {solved:true, value:c.to_i}
					else
						row << {solved:false, set:[1,2,3,4,5,6,7,8,9]}
					end
				end
				board << row
			end
			board
		end

		def solved?(board)
			result = true
			for i in 0..8
				for j in 0..8
					next if board[i][j][:solved]
					raise "Invalid Set #{board[i][j].inspect}" unless board[i][j][:set].length >= 1
					if board[i][j][:set].length == 1
						board[i][j][:solved] = true
						board[i][j][:value] = board[i][j][:set].first 
					end
					result = false
				end
			end
			result
		end

		def solve(board)
			while not solved?(board)
				for i in 0..8
					for j in 0..8
						cell = board[i][j]
						next if cell[:solved]
						for x in 0..8
							next if x==i
							check = board[x][j]
							next unless check[:solved]
							cell[:set] = cell[:set].reject{|v| v == check[:value]}
							raise "Invalid set #{cell.inspect}" unless cell[:set].length >= 1
						end
						for y in 0..8
							next if y==j
							check = board[i][y]
							next unless check[:solved]
							cell[:set] = cell[:set].reject{|v| v == check[:value]}
							raise "Invalid set #{cell.inspect}" unless cell[:set].length >= 1
						end
						row,col,map = i%3,j%3,{0 => [0,1,2], 1 => [3,4,5], 2 => [6,7,8]}
						map[row].each do |x|
							map[col].each do |y|
								next if x==i and y==j
								check = board[x][y]
								next unless check[:solved]
								puts "[#{i}][#{j}] [#{x}][#{y}] " + cell.inspect + " | " + check.inspect
								cell[:set] = cell[:set].reject{|v| v == check[:value]}
								raise "Invalid set #{cell.inspect}" unless cell[:set].length >= 1
							end
						end
					end
				end
				display(board)
				puts "------------------"
			end
		end

		def display(board)
			board.each do |row|
				row.each do |col|
					if col[:solved]
						print col[:value].to_s + ' '
					else
						print("  ")
					end
				end
				puts ""
			end
		end
	end
end