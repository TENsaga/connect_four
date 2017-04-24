require 'spec_helper'

RSpec.describe Board do
  before do
    @scoring = Scoring.new
    @scoring.instance_variable_set(:@marker, [5, 3])
    @board = @scoring.instance_variable_set(:@board,
                                   [["R", "R", "R", "R", "_", "_", "B"],
                                    ["B", "_", "_", "_", "_", "_", "B"],
                                    ["R", "_", "_", "R", "_", "B", "B"],
                                    ["B", "R", "_", "B", "B", "_", "B"],
                                    ["R", "_", "R", "B", "_", "_", "_"],
                                    ["B", "_", "_", "R", "_", "_", "_"]])

    @scoring.instance_variable_set(:@diagonal_down, [])
    @scoring.instance_variable_set(:@diagonal_up, [])
    @scoring.instance_variable_set(:@vertical_line, [])
    @scoring.instance_variable_set(:@results, [])
    @scoring.instance_variable_set(:@marker_down, [0, 0])
    @scoring.instance_variable_set(:@marker_up, [5, 0])
  end

  describe '#determine_win' do
    context 'horizontal' do
      it 'returns true with 4 in a row' do
        @marker = [0, 0]
        expect(@scoring.determine_win(@marker, @board)).to be_truthy
      end
      it 'returns false with less than 4 in a row' do
        @marker = [1, 0]
        expect(@scoring.determine_win(@marker, @board)).to_not be_truthy
      end
    end

    context 'vertical' do
      it 'returns true with 4 in a row' do
        @marker = [0, 6]
        expect(@scoring.determine_win(@marker, @board)).to be_truthy
      end
      it 'returns false with less than 4 in a row' do
        @marker = [1, 5]
        expect(@scoring.determine_win(@marker, @board)).to_not be_truthy
      end
    end

    context 'diagonal_down' do
      it 'returns true with 4 in a row' do
        @marker = [2, 0]
        expect(@scoring.determine_win(@marker, @board)).to be_truthy
      end
      it 'returns false with less than 4 in a row' do
        @marker = [1, 0]
        expect(@scoring.determine_win(@marker, @board)).to_not be_truthy
      end
    end

    context 'diagonal_up' do
      it 'returns true with 4 in a row' do
        @marker = [3, 4]
        expect(@scoring.determine_win(@marker, @board)).to be_truthy
      end
      it 'returns false with less than 4 in a row' do
        @marker = [3, 5]
        expect(@scoring.determine_win(@marker, @board)).to_not be_truthy
      end
    end
  end

  describe '#check_sequence' do
    it 'returns true with 4 R|B in a row' do
      expect(@scoring.send(:check_sequence,
                           ['R', 'R', 'R', 'R', '_', '_', '_'])).to be_truthy
    end
    it 'returns false with less than 4 R|B in a row' do
      expect(@scoring.send(:check_sequence,
                           ['R', '_', 'R', 'R', '_', '_', '_'])).to_not be_truthy
    end
  end

  describe '#horizontal_values' do
    it 'returns all values of row' do
      expect(@scoring.send(:horizontal_values)).to eq(["B", "_", "_", "R", "_", "_", "_"])
    end
  end

  describe '#vertical_values' do
    it 'returns all values of column' do
      expect(@scoring.send(:vertical_values)).to eq(["R", "_", "R", "B", "B", "R"])
    end
  end

  describe '#diagonal_down_shift_marker' do
    it 'moves @marker diagonally down, stops at boundary' do
      @scoring.send(:diagonal_down_shift_marker)
      expect(@scoring.instance_variable_get(:@marker_down)).to eq([5, 5])
    end
  end

  describe '#diagonal_down_values' do
    it 'collects values from @marker up to boundary' do
      @scoring.send(:diagonal_down_shift_marker)
      expect(@scoring.send(:diagonal_down_values)).to eq(["_", "_", "B", "_", "_", "R"])
    end
  end

  describe '#diagonal_up_shift_marker' do
    it 'moves @marker diagonally up, stops at boundary' do
      @scoring.send(:diagonal_up_shift_marker)
      expect(@scoring.instance_variable_get(:@marker_up)).to eq([0, 5])
    end
  end

  describe '#diagonal_up_values' do
    it 'collects values from @marker up to boundary' do
      @scoring.send(:diagonal_up_shift_marker)
      expect(@scoring.send(:diagonal_up_values)).to eq(["_", "_", "R", "_", "_", "B"])
    end
  end
end
