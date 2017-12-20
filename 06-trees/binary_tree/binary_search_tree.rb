require_relative 'node'

class BinarySearchTree

  attr_reader :root

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    temp = root

    while temp
      if node.rating < temp.rating
        if temp.left
          temp = temp.left
        else
          temp.left = node
          break
        end
      end

      if node.rating > temp.rating
        if temp.right
          temp = temp.right
        else
          temp.right = node
          break
        end
      end
    end
  end

  # Recursive Depth First Search
  def find(root, data)
    case
    when root && root.title == data
      return root
    when root.left
      root.left.title != data ? find(root.left, data) : root.left
    when root.right
      root.right.title != data ? find(root.right, data) : root.right
    else
      return nil
    end
  end

  def delete(root, data)
    return nil if !data || !root
    node_to_delete = find(root, data)
    parent_of_node_to_delete = find_parent(root, data)

    if node_to_delete
      delete_node(node_to_delete, parent_of_node_to_delete)
    end
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    tree = [@root]

    tree.each do |node|
      tree << node.left if node.left
      tree << node.right if node.right
    end
    puts tree.map{ |node| "#{node.title}: #{node.rating}"  }.join "\n"
  end

  private

  def delete_node(node, parent_node)
    if parent_node.left && parent_node.left.title == node.title
      if !has_child_nodes(parent_node.left)
        parent_node.left = nil
      end
    elsif parent_node.right && parent_node.right.title == node.title
      if !has_child_nodes(parent_node.right)
        parent_node.right = nil
      end
    end
  end

  def find_parent(root, data)
    case
    when root.left && !root.right
      root.left.title == data ? root : find_parent(root.left, data)
    when root.right && !root.left
      root.right.title == data ? root : find_parent(root.right, data)
    when root.right && root.left
      return root if root.left.title == data
      return root if root.right.title == data
    else
      find_parent(root.left, data)
      find_parent(root.right, data)
    end
  end

  def has_child_nodes(node)
    if node.left || node.right
      return true
    else
      return false
    end
  end
end
