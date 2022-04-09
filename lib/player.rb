# Frozen_String_Literal = false

class Player
  attr_accessor :name, :marker
  attr_reader :player_num

  def initialize(name,marker,player_num)
      @name = name
      @marker = marker
      @player_num = player_num
  end

  def customization()
      self.name = gets.chomp
      while self.name == "" || self.name == " "
          puts "Please enter what you would like your name to be."
          self.name = gets.chomp
      end
      puts "Hello #{self.name}, you are player ##{self.player_num}!"
      puts "So #{self.name}, what 1 letter or character do you want your game marker to be?"
      self.marker = gets.chomp
      while self.marker == "" || self.marker == " " || self.marker.length > 1 || /\d/.match(self.marker)
          puts "Your marker have to be one character long and not include a number."
          self.marker = gets.chomp
      end
      puts "Okay #{self.name}, your marker is #{self.marker}."
  end

  def info()
      return "Player ##{self.player_num}'s name is #{self.name} and has the marker #{self.marker}."
  end

end