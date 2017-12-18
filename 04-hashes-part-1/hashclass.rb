class HashClass
    
      require_relative 'hash_item'
    
      def initialize(size)
        @items = Array.new(size)
      end
    
      def []=(key, value)
        hash_item = HashItem.new(key, value)
        hash_index = index_from_key(key)
    
        if @items[hash_index] == nil
          @items[hash_index] = hash_item
        elsif @items[hash_index].key != key
          self.resize
          self.[]=(key, value)
        elsif @items[hash_index].key == key && @items[hash_index].value != value
          self.resize
        end
      end
    
    
      def [](key)
        hash_index = index_from_key(key)
        @items[hash_index].value
      end
    
      def resize
        old_items_array = @items
        @items = Array.new((old_items_array.length * 2))
        old_items_array.each do |i|
          if i != nil
            new_hash_index = index_from_key(i.key)
            @items[new_hash_index] = i
          end
        end
      end
    
      # Returns a unique, deterministically reproducible index into an array
      # We are hashing based on strings, let's use the ascii value of each string as
      # a starting point.
      def index(key, size)
        index = key.sum(64) % size
        index
      end
    
      # Simple method to return the number of items in the hash
      def size
        @items.length
      end
    
      private
    
      def index_from_key(key)
        return key.sum % @items.length
      end
    
    end