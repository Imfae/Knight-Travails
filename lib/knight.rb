require_relative 'board'
# Class for possible Knight placements from current position
class Knight
  def self.possible_placements(current_position)
    placements = []
    [-2, 2].each do |i|
      [-1, 1].each do |j|
        placements << [current_position[0] + i, current_position[-1] + j]
        placements << [current_position[0] + j, current_position[-1] + i]
      end
    end
    placements.delete_if { |coor| !ChessBoard.board.include?(coor) }
  end
end
