require_relative 'node'

class MinBinaryHeap
  attr_reader :items

  def initialize(node=nil)
    node ? @items = [node] : @items = []
    @size = @items.size
  end

  def insert(node)
    @size += 1
    @items[@size - 1] = node
    sort(@size - 1)
  end

  def sort(node_index)
    return if node_index == 0

    parent_index = parent(node_index)

    if @items[node_index].rating < @items[parent_index].rating
      swap(node_index, parent_index)
      sort(parent_index)
    end
  end

  def find(data)
    node = nil

    @items.each do |item|
      if item.title == data
        node = item
        break
      end
    end
    node
  end

  def find_index(data)
    index = 0

    @items.each do |item|
      break if item.title == data
      index += 1
    end
    index
  end

  def delete(data)
    index = find_index(data)
    swap(@size - 1, index)
    @items.delete_at(@size - 1)
    @size -= 1

    check_down(index)
  end

  def print
    str = ""
    @items.each { |item| str << "#{item.title}: #{item.rating}\n" }
    puts str
  end

  def swap(first, second)
    temp = @items[first]
    @items[first] = @items[second]
    @items[second] = temp
  end

  def check_down(node_index)
    left = left_or_right_index(node_index, "left")
    right = left_or_right_index(node_index, "right")
    return if !left && !right

    lowest = left
    lowest = right if left && right && @items[left].rating > @items[right].rating

    if lowest && @items[node_index].rating > @items[lowest].rating
      swap(lowest, node_index)
      check_down(lowest)
    end
  end

  def parent(node_index)
    (node_index.to_f / 2).round - 1
  end

  def left_or_right_index(node_index, side)
    case
    when side == "right"
      index = (node_index * 2) + 2
    when side == "left"
      index = (node_index * 2) + 1
    end
    index < @size ? index : nil
  end

  # def left(node_index)
  #   left_index = (node_index * 2) + 1
  #   left_index < @size ? left_index : nil
  # end
  #
  # def right(node_index)
  #   right_index = (node_index * 2) + 2
  #   right_index < @size ? right_index : nil
  # end
end
