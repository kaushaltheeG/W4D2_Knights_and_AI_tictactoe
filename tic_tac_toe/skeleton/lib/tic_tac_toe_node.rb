require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if self.board.over?
      if next_mover_mark == self.board.winner
        return true 
      elsif evaluator == self.board.winner 
        return false  
      end
    end
    self.children.each do  |child|
      result = child.losing_node?(evaluator)
      if result 
        return true 
      end
    end 
    false 
  end

  def winning_node?(evaluator)
    if self.board.over?
      if evaluator == self.board.winner
        return true
      elsif next_mover_mark == self.board.winner 
        return false  
      end
    end
    self.children.each do  |child|
      result = child.winning_node?(evaluator)
      if result 
        return true 
      end
    end 
    false

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_boards = Array.new
    next_mover = (self.next_mover_mark == :x ? :o : :x)
    @board.rows.each_with_index do |row, ri|
      # p children_boards
      row.each_with_index do |col, ci|
        # p children_boards
        pos = [ri, ci]
        if @board.empty?(pos)
          duped = @board.dup
          duped[pos] = self.next_mover_mark
          children_boards << TicTacToeNode.new(duped, next_mover, pos)
          # p children_boards
        end
      end
    end
    return children_boards

  end

  def loser?
    

  end 
end
