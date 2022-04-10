# Frozen_String_Literal: false

# This class is holds the methods related to board information
class Board
  attr_accessor :game_board, :winner_marker, :diagonal_left, :diagonal_right

  def initialize
    @game_board = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]
    @row_sep = '-+-+-'
    @winner_marker = nil
  end

  def show_board
    puts ''
    puts @game_board[0].join('|')
    puts @row_sep
    puts @game_board[1].join('|')
    puts @row_sep
    puts @game_board[2].join('|')
  end

  def place_marker(space, player_marker)
    row = @game_board.find_index { |i| i.include?(space) }
    space_index = @game_board[row].index(space)
    @game_board[row][space_index] = player_marker
  end

  def space_taken?(space)
    row = @game_board.index { |i| i.include?(space) }
    space_index = @game_board[row].index(space)
    p space_index
    if /\D/.match?(@game_board[row][space_index])
      true
    else
      false
    end
  end

  def match?
    return column_winner if column_match?
    return row_winner if row_match?
    return diagonal_winner if diagonals_match?
    return true if @game_board.all? { |row| row.none?(/\d/) }

    false
  end

  def column_match?
    return true if @game_board.transpose.any? { |col| col.uniq.length == 1 }

    false
  end

  def column_winner
    @winner_marker = @game_board.transpose.find { |col| col.uniq.length == 1 }[0]
    true
  end

  def row_match?
    return true if @game_board.any? { |row| row.uniq.length == 1 }

    false
  end

  def row_winner
    @winner_marker = @game_board.find { |row| row.uniq.length == 1 }[0]
    true
  end

  def diagonals_match?
    diagonal_left = [@game_board[0][0], @game_board[1][1], @game_board[2][2]]
    diagonal_right = [@game_board[0][2], @game_board[1][1], @game_board[2][0]]
    return true if diagonal_left.uniq.length == 1
    return true if diagonal_right.uniq.length == 1

    false
  end

  def diagonal_winner
    @winner_marker = @game_board[1][1]
    true
  end
end
