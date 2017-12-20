require_relative 'node'

class OpenAddressing
  attr_reader :nodes

  def initialize(size)
    @nodes = Array.new(size)
  end

  def []=(key, value)
    index = index(key, @nodes.size)
    next_index = next_open_index(index)
    new_node = Node.new(key, value)

      if @nodes[index] == nil
        @nodes[index] = new_node
      elsif next_index != -1
        @nodes[next_index] = new_node
      elsif next_index == -1
        self.resize
        self.[]=(key, value)
      end
  end

  def [](key)
    index = index(key, @nodes.size)
    current_index = index

    while current_index < @nodes.size or current_index != index
      if @nodes[current_index].key == key
        break
      elsif current_index + 1 == @nodes.size
        current_index = 0
      else
        current_index += 1
      end
    end
    @nodes[current_index].value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    hash_index = key.sum % size
    hash_index
  end

  # Given an index, find the next open index in @nodes
  def next_open_index(index)
    open_index = nil
    current_index = index

    if index >= @nodes.size
      open_index = index - 1
    end

    while current_index < @nodes.size or current_index != index
      if current_index <= @nodes.size and @nodes.size < 2
        open_index = -1
        break
      elsif @nodes[current_index] == nil
        open_index = current_index
        break
      elsif current_index + 1 == @nodes.size
        current_index = 0
      elsif current_index + 1 == index
        open_index = -1
        break
      else
        current_index += 1
      end
    end
    open_index
  end

  # Simple method to return the number of items in the hash
  def size
    @nodes.size
  end

  # Resize the hash
  def resize
    old_nodes = @nodes
    @nodes = Array.new(old_nodes.size * 2)

    old_nodes.each do |n|
      if n != nil
        self.[]=(n.key, n.value)
      end
    end
  end

  def get_load_factor
    node_count = 0
    load_factor = 0.0

    @nodes.each do |n|
      if n != nil
        node_count += 1
      end
    end
    if node_count > 0
      load_factor = node_count / @nodes.size
    end
    load_factor
  end

  def print_hash
    current_load_factor = self.get_load_factor
    puts "Current load factor: #{current_load_factor}"
    puts "Current hash state: \n"
    puts"{"
    @nodes.each do |n|
      if n.nil?
        puts "\t:Nil"
      else
        puts "\tKey: #{n.key} Value: #{n.value}"
      end
    end
    puts "}"
  end
end