# Frozen_String_Literal: false

# This class is holds the methods for the main gameplay
class Gameplay
  def self.player_play(player_obj)
    Board.show_board
    puts "#{player_obj.name}, enter a number (1-9) that is not already taken by a player marker."
    space_sel = gets.chomp
    space_sel = sel_valid_num(space_sel)
    sel_valid_space(space_sel, player_obj)
  end

  def sel_valid_num(selected_num)
    until selected_num.to_i < 10 && selected_num.to_i.positive?
      puts 'Please enter a number (1-9).'
      selected_num = gets.chomp
    end
  end

  def sel_valid_space(selected_space, player_obj)
    until Board.place_marker(selected_space, player_obj.marker)
      puts 'Please enter a number (1-9) that is not already taken.'
      selected_space = gets.chomp
    end
  end

  def self.gameplay(player1, player2)
    puts 'Welcome to Tik-Tac-Toe!'
    player_customization(player1, player2)
    player_turn_loop(player1, player2)
    share_winner(player1, player2)
  end

  def player_customization(player1, player2)
    puts "#{player1.name}, what's is your name?"
    player1.customization
    puts "\n#{player2.name}, what's is your name?"
    player2.customization
    puts ''
  end

  def player_turn_loop(player1, player2)
    loop do
      puts ''
      player_play(player1)
      break if Board.match?

      puts ''
      player_play(player2)
      break if Board.match?
    end
  end

  def share_winner(player1, player2)
    Board.show_board
    if Board.winner_marker == player1.marker
      puts "#{player1.name} is the winner!"
    elsif Board.winner_marker == player2.marker
      puts "#{player2.name} is the winner!"
    else
      puts 'Tied Game!'
    end
  end
end
