# Frozen_String_Literal: false

require_relative 'player'
require_relative 'board'

# This class is holds the methods for the main gameplay
class Gameplay
  attr_accessor :player1, :player2
  attr_reader :board

  def initialize
    @board = Board.new
    @player1 = Player.new('player_1', 'x', 1)
    @player2 = Player.new('player_2', 'o', 2)
  end

  def sel_valid_num(selected_num)
    until selected_num.to_i < 10 && selected_num.to_i.positive?
      puts 'Please enter a number (1-9).'
      selected_num = gets.chomp
    end
    selected_num
  end

  def sel_valid_space(selected_space, player_obj)
    while @board.space_taken?(selected_space)
      puts 'Please enter a number (1-9) that is not already taken.'
      selected_space = gets.chomp
    end
    @board.place_marker(selected_space, player_obj.marker)
  end

  def play
    puts 'Welcome to Tik-Tac-Toe!'
    player_customization
    player_turn_loop
    share_winner
  end

  def player_customization
    puts "#{@player1.name}, what's is your name?"
    @player1.customization
    puts "\n#{@player2.name}, what's is your name?"
    @player2.customization
    puts ''
  end

  def player_turn_loop
    loop do
      puts ''
      player_play(@player1)
      break if @board.match?

      puts ''
      player_play(@player2)
      break if @board.match?
    end
  end

  def player_play(player_obj)
    @board.show_board
    puts "#{player_obj.name}, enter a number (1-9) that is not already taken by a player marker."
    space_sel = gets.chomp
    space_sel = sel_valid_num(space_sel)
    sel_valid_space(space_sel, player_obj)
  end

  def share_winner
    @board.show_board
    return puts "#{@player1.name} is the winner!" if player1_win?
    return puts "#{@player2.name} is the winner!" if player2_win?

    puts 'Tied Game!'
  end

  def player1_win?
    return true if @board.winner_marker == @player1.marker

    false
  end

  def player2_win?
    return true if @board.winner_marker == @player2.marker

    false
  end
end
