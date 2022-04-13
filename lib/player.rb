# Frozen_String_Literal: false

# This class is holds the methods related to player information
class Player
  attr_accessor :name, :marker, :player_num

  def initialize(name, marker, player_num)
    @name = name
    @marker = marker
    @player_num = player_num
  end

  def customization
    choose_name
    choose_marker
  end

  def choose_name
    @name = gets.chomp
    sel_valid_name
    puts "Hello #{@name}, you are player ##{player_num}!"
  end

  def sel_valid_name
    while ['', ' '].include?(@name)
      puts 'Please enter what you would like your name to be.'
      @name = gets.chomp
    end
  end

  def choose_marker
    puts "So #{@name}, what 1 letter or character do you want your game marker to be?"
    @marker = gets.chomp
    sel_valid_marker
    puts "Okay #{@name}, your marker is #{@marker}."
  end

  def sel_valid_marker
    while ['', ' '].include?(@marker) || @marker.length > 1 || /\d/.match(@marker)
      puts 'Your marker have to be one character long and not include a number.'
      @marker = gets.chomp
    end
  end
end
