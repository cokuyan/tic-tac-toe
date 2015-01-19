require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  attr_reader :board, :prev_move_pos, :next_mover_mark

  def losing_node?(evaluator)
    if board.over?
      return false if board.tied? || board.winner == evaluator
      return true
    end

    if @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end

  end

  def winning_node?(evaluator)
    if board.over?
      return true if board.winner == evaluator
      return false
    end

    if @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    # set of boards one move away
    children = []
    (0..2).each do |x|
      (0..2).each do |y|
        board_dup = board.dup
        pos = [x, y]

        next unless board_dup.empty?(pos)
        board_dup[pos] = next_mover_mark

        next_next_mover_mark = ((self.next_mover_mark == :x) ? :o : :x)

        children << TicTacToeNode.new(board_dup, next_next_mover_mark, pos)
      end
    end

    children
  end

end
