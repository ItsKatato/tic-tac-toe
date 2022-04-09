# Frozen_String_Literal: false

class Board 
  @@game_board = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]
  @@ROW_SEP = '-+-+-'
  @@winner_marker = nil

  def self.winner_marker
    @@winner_marker
  end

  def self.show_board
    puts @@game_board[0].join('|')
    puts @@ROW_SEP
    puts @@game_board[1].join('|')
    puts @@ROW_SEP
    puts @@game_board[2].join('|')
  end

  def self.place_marker(space, player_marker)
    @@game_board[@@game_board.find_index {|i| i.include?(space)}][@@game_board[@@game_board.find_index {|i| i.include?(space)}].index(space)] = player_marker
  rescue TypeError
    false
  else
    true
  end

  def self.match?
    case
    when @@game_board.transpose.any? { |col| col.uniq.length == 1 }
      @@winner_marker = @@game_board.transpose.find { |col| col.uniq.length == 1 }[0]
      p @@winner_marker 
      return true
    when @@game_board.any? { |row| row.uniq.length == 1 }
      @@winner_marker = @@game_board.find { |row| row.uniq.length == 1 }[0]
      p @@winner_marker 
      true
    when @@game_board[0][0] == @@game_board[1][1] && @@game_board[1][1] == @@game_board[2][2]
      @@winner_marker = @@game_board[1][1]
      p @@winner_marker 
      true
    when @@game_board[0][2] == @@game_board[1][1] && @@game_board[1][1] == @@game_board[2][0]
      @@winner_marker = @@game_board[1][1]
      p @@winner_marker 
      true
    when @@game_board.all? { |row| row.none?(/\d/) }
      true
    else
      false
    end
  end
end