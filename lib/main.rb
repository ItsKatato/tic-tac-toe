# Frozen_String_Literal: false

require_relative 'gameplay'
require_relative 'player'
require_relative 'board'

$player_1 = Player.new("player_1", "x", 1)
$player_2 = Player.new("player_2", "o", 2)


TikTacToe.gameplay