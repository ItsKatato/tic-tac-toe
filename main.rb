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

    def info()
        return "Player ##{self.player_num}'s name is #{self.name} and has the marker #{self.marker}."
    end

end

class Board 
    @@game_board = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]
    @@ROW_SEP = '-+-+-'

    def initialize()
    end

    def self.show_board()
        puts @@game_board[0].join('|')
        puts @@ROW_SEP
        puts @@game_board[1].join('|')
        puts @@ROW_SEP
        puts @@game_board[2].join('|')
    end

    def self.place_marker(space, player_marker)
        @@game_board[@@game_board.find_index {|i| i.include?(space)}][@@game_board.find_index {|i| i.include?(space)}] = player_marker
    end
end

# @@game_board[:r1][]

player_1 = Player.new("player_1", "x", 1)
player_2 = Player.new("player_2", "o", 2)


# puts "Welcome to Tik-Tac-Toe! What's is your name?"
# puts player_1.name + ", what's is your name?"
# player_1.customization()
# puts player_2.name + ", what's is your name?"
# player_2.customization()

Board.place_marker(5, player_1.marker)
Board.show_board()