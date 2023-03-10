require_relative 'knight'
# Each node contains a set of 2d coordinates as its value
class Node
  def initialize(value = nil)
    @value = value
  end
  attr_accessor :value

  def create_child(input)
    # Choose a variable name for new child with value 'input' and declare variable
    child_index = 0
    child_index += 1 while instance_variable_defined?("@child#{child_index}")
    instance_variable_set("@child#{child_index}", Node.new(input))

    # Ensure the newly created child is readable outside the class
    self.class.send(:attr_reader, "child#{child_index}")
  end
end

# Class for knight movement tree
class Tree
  def initialize(current_position, terminal_position)
    @root = Node.new(current_position)
    @terminal_position = terminal_position
  end

  def breadth_first_search(node = @root, traversed_positions = [], queue = [])
    # Avoid looping back to the same position
    node = queue.shift if traversed_positions.include?(node.value)
    traversed_positions << node.value

    # Create child nodes of current node
    # Add child nodes to search queue unless child node's position is terminal position
    children = Knight.possible_placements(node.value)
    children.length.times do |i|
      node.create_child(children[i])
      return if children[i] == @terminal_position

      queue << node.instance_variable_get("@child#{i}")
    end
    breadth_first_search(queue.shift, traversed_positions, queue)
  end

  def knight_moves(node = @root, queue = [], path = [])
    moves = -1

    # Find nodes that have child node with terminal_position as value
    loop do
      if include_terminal_node?(node)
        path << node.value
        moves += 1
        i = 0
        while node.instance_variable_defined?("@child#{i}")
          queue.unshift node.instance_variable_get("@child#{i}")
          i += 1
        end
      end
      break if node.value == @terminal_position
      node = queue.shift
    end
    puts "You made it in #{moves} moves! Here's your path:"
    path.map {|i| p i}
  end

  def include_terminal_node?(node = @root, queue = [])

    # Check if the parameter node include child node with terminal_position as value
    if node.instance_variable_defined?('@child0')
      i = 0
      while node.instance_variable_defined?("@child#{i}")
        queue.unshift node.instance_variable_get("@child#{i}")
        i += 1
      end
    elsif node.value == @terminal_position
      return true
    end

    include_terminal_node?(queue.shift, queue) unless queue.empty?
  end
end

t = Tree.new([1, 1], [8, 8])
t.breadth_first_search
t.knight_moves
