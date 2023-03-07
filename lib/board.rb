# Class for chess board
class ChessBoard
  def self.board
    board_ary = []
    8.times do |i|
      8.times do |j|
        board_ary << [i + 1, j + 1]
      end
    end
    board_ary
  end
end
