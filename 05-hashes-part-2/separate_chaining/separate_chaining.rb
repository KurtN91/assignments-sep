class SeparateChaining
    require_relative 'linked_list'
  
    attr_reader :max_load_factor
  
    def initialize(size)
      @max_load_factor = 0.7
      @items = Array.new(size)
    end
  
    def []=(key, value)
      hash_index = index_from_key(key)
      llist = LinkedList.new
  
      if @items[hash_index] == nil
        llist.add_to_front(key, value)
        @items[hash_index] = llist
      elsif @items[hash_index].size == 5
        self.resize
        self.[]=(key, value)
      else
        @items[hash_index].add_to_front(key, value)
      end
    end
  
  
    def [](key)
      hash_index = index_from_key(key)
      list_from_items = @items[hash_index]
      matching_node = nil
      current_node = list_from_items.head
  
      while current_node != nil and current_node.key != key
        current_node = current_node.next
      end
      matching_node = current_node
      matching_node.value
    end
  
    # Returns a unique, deterministically reproducible index into an array
    # We are hashing based on strings, let's use the ascii value of each string as
    # a starting point.
    def index(key, size)
      index = key.sum(64) % size
      index
    end
  
    # Calculate the current load factor
    def load_factor
      node_count = 0.0
  
      @items.each do |item|
        if item != nil
          current_node = item.head
          while current_node != nil
            node_count += 1
            current_node = current_node.next
          end
        end
      end
      @max_load_factor = (node_count / @items.size)
      if @max_load_factor > 0.70
        self.resize
        self.load_factor
      else
        @max_load_factor
      end
    end
  
    # Simple method to return the number of items in the hash
    def size
      @items.size
    end
  
    # Resize the hash
    def resize
      old_items = @items
      @items = Array.new((old_items.size * 2))
  
      old_items.each do |item|
        if item != nil
          current_node = item.head
          while current_node != nil
            self.[]=(current_node.key, current_node.value)
            current_node = current_node.next
          end
        end
      end
    end
  
    def print_hash
      puts "Current load factor: #{load_factor}"
      puts "Current hash state:\n"
      puts "{"
      @items.each do |i|
        puts "\t{"
        if i == nil
          puts "\t-:Nil"
        else
          current_node = i.head
          while current_node != nil
            puts "\t-Key: #{current_node.key} -- Value: #{current_node.value}"
            current_node = current_node.next
          end
        end
        puts "\t}"
      end
      puts "}"
    end
  
    private
  
    def index_from_key(key)
      return key.sum % @items.length
    end
  
  end