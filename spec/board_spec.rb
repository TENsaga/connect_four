require 'spec_helper'

RSpec.describe Board do
  before do
    @board = Board.new
  end

  describe '#board' do
    it 'returns full 7x6 board' do
      expect(@board.board).to eq([['_', '_', '_', '_', '_', '_', '_'],
                                  ['_', '_', '_', '_', '_', '_', '_'],
                                  ['_', '_', '_', '_', '_', '_', '_'],
                                  ['_', '_', '_', '_', '_', '_', '_'],
                                  ['_', '_', '_', '_', '_', '_', '_'],
                                  ['_', '_', '_', '_', '_', '_', '_']])
    end
    it 'returns single 1x6 row from board' do
      expect(@board.board[0]).to eq(['_', '_', '_', '_', '_', '_', '_'])
    end
  end

  describe '#check_column' do
    context 'passed a column with space' do
      it 'returns same column' do
        expect(@board.check_column(1)).to eq(1)
      end
    end

    context 'passed a column without space' do
      it 'returns false' do
        6.times { @board.update_board('B', 1) }
        expect(@board.check_column(1)).to be_falsey
      end
    end
  end

  describe '#update_board' do
    context 'dropped in empty column' do
      it 'returns @marker [row, col] of bottom space' do
        expect(@board.update_board('B', 2)).to eq([5, 2])
        expect(@board.update_board('R', 5)).to eq([5, 5])
      end
    end

    context 'dropped into column with pieces' do
      it 'returns @marker [row, col] of first available space' do
        3.times { @board.update_board('B', 4) }
        4.times { @board.update_board('R', 1) }
        expect(@board.update_board('B', 4)).to eq([2, 4])
        expect(@board.update_board('R', 1)).to eq([1, 1])
      end
    end
  end
end
