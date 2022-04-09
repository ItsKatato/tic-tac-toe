# Frozen_String_Literal = false

class Player
  attr_accessor :name, :marker
  attr_reader :player_num

  def initialize(name, marker, player_num)
    @name = name
    @marker = marker
    @player_num = player_num
  end

  def customization
    name = gets.chomp
    while name == "" || name == " "
      puts 'Please enter what you would like your name to be.'
      name = gets.chomp
    end
    puts "Hello #{name}, you are player ##{player_num}!"
    puts "So #{name}, what 1 letter or character do you want your game marker to be?"
    marker = gets.chomp
    while marker == "" || marker == " " || marker.length > 1 || /\d/.match(marker)
      puts 'Your marker have to be one character long and not include a number.'
      self.marker = gets.chomp
    end
    puts "Okay #{name}, your marker is #{marker}."
  end

  def info
    "Player ##{player_num}'s name is #{name} and has the marker #{marker}."
  end
end
