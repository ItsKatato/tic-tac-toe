# Frozen_String_Literal = false

class Gameplay
  def self.player_play(player_obj)
    Board.show_board
    puts "#{player_obj.name}, enter a number (1-9) that is not already taken by a player marker."
    space_sel = gets.chomp
    until space_sel.to_i < 10 && space_sel.to_i.positive?
      puts 'Please enter a number (1-9).'
      space_sel = gets.chomp
    end
    until Board.place_marker(space_sel, player_obj.marker)
      puts 'Please enter a number (1-9) that is not already taken.'
      space_sel = gets.chomp
    end
  end

  def self.gameplay
    puts "Welcome to Tik-Tac-Toe! What's is your name?"
    puts $player_1.name + ", what's is your name?"
    $player_1.customization
    puts ""
    puts $player_2.name + ", what's is your name?"
    $player_2.customization
    puts ""
    loop do
      puts ""
      player_play($player_1)
      if Board.match?
        break
      end
      puts ""
      player_play($player_2)
      if Board.match?
        break
      end
    end
    puts ""
    Board.show_board
    if Board.winner_marker == $player_1.marker
      puts "#{$player_1.name} is the winner!"
    elsif Board.winner_marker == $player_2.marker
      puts "#{$player_1.name} is the winner!"
    else
      puts 'Tied Game!'
    end
  end   
end