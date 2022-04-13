# Frozen_String_Literal: false

require_relative '../lib/gameplay'
require_relative '../lib/player'
require_relative '../lib/board'
require 'stringio'

describe Gameplay do
  subject(:main_game) { described_class.new }

  before do
    main_game.instance_variable_set(:@board, instance_double(Board))
  end

  describe '#play' do
    it 'play game' do
      allow(main_game).to receive(:puts)
      allow(main_game).to receive(:customize_players)
      allow(main_game).to receive(:player_turn_loop)
      allow(main_game).to receive(:share_winner)

      main_game.play
    end
  end

  describe 'player_customization' do
    it 'creates player 1' do
      player_name = 'Kaelah'
      player_marker = 'K'
      player_number = '1'
      allow(main_game).to receive(:puts)
      allow($stdin).to receive(:gets).and_return(player_name)
      allow(main_game).to receive(:choose_marker).and_return(player_marker)
      expect(Player).to receive(:new).with(player_name, player_marker, player_number)
      main_game.player_customization(player_number)
    end
  end

  describe 'player_turn_loop' do
    context 'when the first player matches' do
      before do
        expect(main_game.board).to receive(:gameover?).and_return(true)
      end

      it 'stops the loop' do
        expect(main_game).to receive(:player_play).once
        main_game.player_turn_loop
      end
    end

    context 'when the second player matches' do
      before do
        expect(main_game.board).to receive(:gameover?).and_return(false, true)
      end

      it 'stops the loop after second turn' do
        expect(main_game).to receive(:player_play).twice
        main_game.player_turn_loop
      end
    end
  end

  describe 'player_play' do
    context 'when its player 1s turn' do
      let(:player1) { Player.new('Kaelah', 'X', '1') }
      it 'selects space on board' do
        selected_space = '5'
        expect(main_game.board).to receive(:show_board)
        allow(main_game).to receive(:puts)
        allow($stdin).to receive(:gets).and_return(selected_space)
        allow(main_game).to receive(:sel_valid_num).and_return(selected_space)
        expect(main_game).to receive(:sel_valid_space)
        main_game.player_play(player1)
      end
    end
  end

  describe 'sel_valid_num' do
    context 'when number is valid' do
      it 'returns selected_num' do
        selected_num = '5'
        expect(main_game).to receive(:sel_valid_num).and_return(selected_num)
        main_game.sel_valid_num(selected_num)
      end
    end
    context 'when number is invalid' do
      it 'returns does loop once then breaks' do
        selected_num = '20'
        valid_num = '4'
        expect(main_game).to receive(:sel_valid_num).and_return(selected_num)
        allow(main_game).to receive(:puts)
        allow($stdin).to receive(:gets).and_return(valid_num).once
        main_game.sel_valid_num(selected_num)
      end
    end
  end

  describe 'sel_valid_space' do
    context 'when space is valid' do
      let(:player1) { Player.new('Kaelah', 'X', '1') }
      before do
        allow(main_game.board).to receive(:space_taken?).and_return(false)
      end
      it 'places marker' do
        selected_space = '5'
        expect(main_game.board).to receive(:place_marker).with(selected_space, player1.marker)
        main_game.sel_valid_space(selected_space, player1)
      end
    end

    context 'when space is invalid' do
      let(:player1) { Player.new('Kaelah', 'X', '1') }
      before do
        allow(main_game.board).to receive(:space_taken?).and_return(true, false)
      end
      it 'loop once then place marker' do
        selected_space = '5'
        valid_space = '7'
        allow($stdin).to receive(:gets).and_return(valid_space).once
        expect(main_game.board).to receive(:place_marker).with(valid_space, player1.marker)
        main_game.sel_valid_space(selected_space, player1)
      end
    end
  end

  describe 'share_winner' do
    context 'when player_1_win' do
      before do
        main_game.instance_variable_set(:@player1, Player.new('Kaelah', 'X', '1'))
        allow(main_game).to receive(:player1_win?).and_return(true)
      end
      it 'returns player1 win announcement' do
        winner_announcement = 'Kaelah is the winner!'
        allow(main_game.board).to receive(:show_board)
        expect(main_game).to receive(:share_winner).and_return(winner_announcement)
        main_game.share_winner
      end
    end

    context 'when player_2_win' do
      before do
        main_game.instance_variable_set(:@player1, Player.new('Malia', 'O', '2'))
        allow(main_game).to receive(:player2_win?).and_return(true)
      end
      it 'returns player2 win announcement' do
        winner_announcement = 'Malia is the winner!'
        allow(main_game.board).to receive(:show_board)
        expect(main_game).to receive(:share_winner).and_return(winner_announcement)
        main_game.share_winner
      end
    end

    context 'when neither players win' do
      before do
        allow(main_game).to receive(:player1_win?).and_return(false)
        allow(main_game).to receive(:player2_win?).and_return(false)
      end
      it 'returns tied announcement' do
        tied_announcement = 'Tied Game!'
        allow(main_game.board).to receive(:show_board)
        expect(main_game).to receive(:share_winner).and_return(tied_announcement)
        main_game.share_winner
      end
    end
  end
end
