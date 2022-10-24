require 'byebug'

require_relative '00_tree_node'

class KnightPathFinder

    def self.valid_moves(pos)
        valid_moves = Array.new
        [-1, 1].each do |i|
            [-2, 2].each do |j|
                valid_moves.push([(pos[0] + i), (pos[1] + j)], [(pos[0] + j), (pos[1] + i)])
            end
        end
        valid_moves.select do |sub| 
            (sub[0] < 8 && sub[0] > -1) && (sub[1] < 8 && sub[1] > -1)
        end
       #valid_moves
    end

    attr_reader :considered_positions

    def initialize(pos)
        @start_pos = pos
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = Array.new()
    end

    def new_move_positions(pos)
        valid_moves = KnightPathFinder.valid_moves(pos)
        final_valid_moves = Array.new
        valid_moves.each do |move|
            # debugger
            if !@considered_positions.include?(move)
                final_valid_moves << move
            end
        end

        final_valid_moves
    end

    def build_move_tree
        queue = Array.new
        queue << @root_node

        until queue.empty?
            node = queue.shift
            new_moves = new_move_positions(node.value)
            @considered_positions += new_moves
            @considered_positions.uniq!
            new_moves.each do |move|
                kiddo = PolyTreeNode.new(move)
                node.add_child(kiddo)
            end
          

            queue += node.children
        end
        #p @considered_positions.length
    end

    def find_path(end_pos)
        self.build_move_tree
        end_node = @root_node.dfs(end_pos)
        nodes_arr = trace_path_back(end_node)
        nodes_arr.map {|node| node.value}
    end 
    
    def trace_path_back(node)
        return [] if node == nil 
        nodes_arr = trace_path_back(node.parent)
        nodes_arr <<  node
    end 


end
