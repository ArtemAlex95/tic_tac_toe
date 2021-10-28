class TicTacToe

    def initialize
      @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ].freeze

    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(string)
      @choice = string.to_i - 1
    end

    def move(index, player = "X")
      @board[index] = player
    end

    def position_taken?(index)
     @board[index] == "X" || @board[index] == "O"
    end

    def valid_move?(index)
     !position_taken?(index) && index.between?(0, 8)
    end

    def turn_count
      @board.count { |token| token == "X" || token == "O"}
    end

    def current_player
      turn_count.even? ? "X" : "O"
    end

    def turn
      puts "Please, enter a number between 1-9"
      user_input = gets.chomp
      index = input_to_index(user_input)
      if valid_move?(index)
        move(index, current_player)
        display_board
      else
        turn
      end
    end

    def won?
      WIN_COMBINATIONS.detect do |combo|
        @board[combo[0]] == @board[combo[1]] &&
        @board[combo[1]] == @board[combo[2]] &&
        position_taken?(combo[0])
      end
    end

    def full?
      @board.all?{ |token| token == "X" || token == "O" }
    end

    def draw?
      !won? && full?
    end

    def over?
      won? || draw?
    end

    def winner
      if winning_combo = won?
        @board[winning_combo.first]
      end
    end

    def play
      while !over?
        turn
      end
      if won?
        puts "Congrats, #{winner}!"
      elsif draw?
        puts "\nOne more?"
      end
    end
end

test = TicTacToe.new
test.play