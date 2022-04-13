# Frozen_String_Literal: false

require_relative '../lib/board'

describe Board do
  subject(:gameboard) { described_class.new }

  describe '#gameover?' do
    context 'When theres a matching column' do
      before do
        allow(gameboard).to receive(:column_match?).and_return(true)
        allow(gameboard).to receive(:column_winner).and_return(true)
      end
      it 'returns column_winner' do
        expect(gameboard.gameover?).to eq(true)
        gameboard.gameover?
      end
    end

    context 'When theres a matching row' do
      before do
        allow(gameboard).to receive(:row_match?).and_return(true)
        allow(gameboard).to receive(:row_winner).and_return(true)
      end
      it 'returns row_winner' do
        expect(gameboard.gameover?).to eq(true)
        gameboard.gameover?
      end
    end

    context 'When theres a matching diagonal' do
      before do
        allow(gameboard).to receive(:diagonals_match?).and_return(true)
        allow(gameboard).to receive(:diagonal_winner).and_return(true)
      end
      it 'returns diagonal_winner' do
        expect(gameboard.gameover?).to eq(true)
        gameboard.gameover?
      end
    end

    context 'When theres no more available spaces' do
      before do
        allow(gameboard).to receive(:board_full?).and_return(true)
      end
      it 'returns true' do
        expect(gameboard.gameover?).to eq(true)
        gameboard.gameover?
      end
    end

    context 'When theres no matches but spaces are available' do
      before do
        allow(gameboard).to receive(:column_match?).and_return(false)
        allow(gameboard).to receive(:row_match?).and_return(false)
        allow(gameboard).to receive(:diagonals_match?).and_return(false)
        allow(gameboard).to receive(:board_full?).and_return(false)
      end
      it 'returns false' do
        expect(gameboard.gameover?).to eq(false)
        gameboard.gameover?
      end
    end
  end
end
