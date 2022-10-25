require 'byebug'
require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    root = TicTacToeNode.new(game.board, mark)
    children = root.children
    children.each do |kiddo| 
      if kiddo.winning_node?(mark)
        return kiddo.prev_move_pos
      end
    end

    if root.children.all? {|kiddo| kiddo.losing_node?}
      raise 'error, no non-losing nodes - jeff do better next time >:('
    else
      1.times do 
        jeff = self.random_move
          if !jeff.losing_node?
            return jeff
          else
            redo
          end
      end
    end

      
        

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
