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
        while self.marker == "" || self.marker == " " || self.marker.length > 1
            puts "Your marker have to be one character long."
            self.marker = gets.chomp
        end
        puts "Okay #{self.name}, your marker is #{self.marker}."
    end

end

player_1 = Player.new("player_1", "x", 1)
player_2 = Player.new("player_2", "o", 2)

board = Array.new(9)


puts "Welcome to Tik-Tac-Toe! What's is your name?"
puts player_1.name + ", what's is your name?"
player_1.customization()
