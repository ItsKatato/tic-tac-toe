module TikTacToe

    def self.player_play(player_obj)
        Board.show_board
        puts player_obj.name + ", enter a number (1-9) that is not already taken by a player marker."
        space_sel = gets.chomp
        until space_sel.to_i < 10 && space_sel.to_i > 0
            puts "Please enter a number (1-9)."
            space_sel = gets.chomp
        end
        until Board.place_marker(space_sel, player_obj.marker)
            puts "Please enter a number (1-9) that is not already taken."
            space_sel = gets.chomp
        end
    end

    def self.gameplay()
        puts "Welcome to Tik-Tac-Toe! What's is your name?"
        puts $player_1.name + ", what's is your name?"
        $player_1.customization()
        puts ""
        puts $player_2.name + ", what's is your name?"
        $player_2.customization()
        puts ""
        loop do
            puts ""
            player_play($player_1)
            if Board.match?()
                break
            end
            puts ""
            player_play($player_2)
            if Board.match?()
                break
            end
        end
        puts ""
        Board.show_board()
        if Board.winner_marker == $player_1.marker
            puts "#{$player_1.name} is the winner!"
        elsif Board.winner_marker == $player_2.marker
            puts "#{$player_1.name} is the winner!"
        else
            puts "Tied Game!"
        end
    end
    
    
end

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

class Board 
    @@game_board = [["1", "2", "3"],["4", "5", "6"],["7", "8", "9"]]
    @@ROW_SEP = '-+-+-'
    @@winner_marker = nil

    def initialize()
    end

    def self.winner_marker
        @@winner_marker
    end

    def self.show_board()
        puts @@game_board[0].join('|')
        puts @@ROW_SEP
        puts @@game_board[1].join('|')
        puts @@ROW_SEP
        puts @@game_board[2].join('|')
    end

    def self.place_marker(space, player_marker)
        begin 
            @@game_board[@@game_board.find_index {|i| i.include?(space)}][@@game_board[@@game_board.find_index {|i| i.include?(space)}].index(space)] = player_marker
        rescue TypeError
            return false
        else
            return true
        end   
    end

    def self.match?()
        case
        when @@game_board.transpose.any? {|col| col.uniq.length == 1}
            @@winner_marker = @@game_board.transpose.find {|col| col.uniq.length == 1}[0]
            p @@winner_marker 
            return true
        when @@game_board.any? {|row| row.uniq.length == 1}
            @@winner_marker = @@game_board.find {|row| row.uniq.length == 1}[0]
            p @@winner_marker 
            return true
        when @@game_board[0][0] == @@game_board[1][1] && @@game_board[1][1] == @@game_board[2][2]
            @@winner_marker = @@game_board[1][1]
            p @@winner_marker 
            return true
        when @@game_board[0][2] == @@game_board[1][1] && @@game_board[1][1] == @@game_board[2][0]
            @@winner_marker = @@game_board[1][1]
            p @@winner_marker 
            return true
        when @@game_board.all? {|row| row.none?(/\d/)}
            return true
        else 
            return false
        end
    end

end

$player_1 = Player.new("player_1", "x", 1)
$player_2 = Player.new("player_2", "o", 2)


TikTacToe.gameplay