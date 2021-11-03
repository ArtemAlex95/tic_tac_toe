# frozen_string_literal: true

class TicTacToe
  def initialize
    @board = Array.new(9, ' ')
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
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '-----------'
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  end

  def input_to_index(string)
    @choice = string.to_i - 1
  end

  def move(index, player = 'X')
    @board[index] = player
  end

  def position_taken?(index)
    @board[index] == 'X' || @board[index] == 'O'
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0, 8)
  end

  def turn_count
    @board.count { |token| %w[X O].include?(token) }
  end

  def current_player
    turn_count.even? ? 'X' : 'O'
  end

  def display_valid_moves
    arr = []
    @board.each_with_index { |v, i| arr.push(i + 1) if v == ' ' }
    arr.join(', ')
  end

  def turn
    puts "\nPlease enter the available numbers as shown on the numpad: #{display_valid_moves}"
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
    @board.all? { |token| %w[X O].include?(token) }
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
    turn until over?
    if won?
      puts "\nCongrats, #{winner}!"
      one_more
    elsif draw?
      puts "\nIt was a worthy battle!"
      one_more
    end
  end

  def one_more
    puts "\nOne more? press 'y' for one more or type 'exit'"
    user_input = gets.chomp
    TicTacToe.new.play if user_input == 'y'
  end
end

test = TicTacToe.new
test.play
