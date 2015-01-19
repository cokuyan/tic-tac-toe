require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    board = game.board

    node = TicTacToeNode.new(board, mark)

    childrens = node.children

    childrens.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end

    childrens.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end

    raise "HOW DID I LOSE?!?!?!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
