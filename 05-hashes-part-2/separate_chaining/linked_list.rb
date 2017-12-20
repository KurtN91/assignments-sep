require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

    # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(key, value)
    node = Node.new(key, value)
    if @tail == nil
      @tail = node
      @head = node
    else
      @tail.next = node
      @tail = node
    end
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if @head != @tail
      current_node = @head
      while current_node.next != @tail
        current_node = current_node.next
      end
      current_node.next = nil
      @tail = current_node
    else
      @tail = nil
      @head = @tail
      @tail
    end
  end

  # This method prints out a representation of the list.
  def print
    current_node = @head
    begin
      puts current_node.data
      current_node = current_node.next
    end until current_node == nil
  end

  # This method returns the amount of items (size) in the linked list
  def size
    current_node = @head
    count = @head == nil ? 1 : 0

    while current_node.next != nil
      current_node = current_node.next
      count += 1
    end
    count
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(key, value)
    node = Node.new(key, value)
    current_node = @head
    previous_node = nil

    if node == @head
      @head = current_node.next
    elsif node == @tail
      @tail = current_node.next
    else
      while current_node != node
        previous_node = current_node
        current_node = current_node.next
      end
      previous_node.next = current_node.next
    end
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(key, value)
    node = Node.new(key, value)
    if @head == nil
      @head = node
    else
      old_head_node = @head
      @head = node
      @head.next = old_head_node
    end
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    if @head.next != nil
      old_head_node = @head
      @head = @head.next
    else
      @head = nil
      @tail = @head
    end
    old_head_node
  end
end