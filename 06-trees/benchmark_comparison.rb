require 'benchmark'
require_relative 'min_binary_heap/min_binary_heap.rb'
require_relative 'binary_tree/binary_search_tree.rb'
require_relative 'binary_tree/node.rb'

base_node = Node.new("1", 1)
bst = BinarySearchTree.new(base_node)
mbh = MinBinaryHeap.new(base_node)

Benchmark.bm do |x|
  x.report("Binary Search Tree insert 10k:   ") { n = 2; 9999.times do; node = Node.new("#{n}", n); n += 1; bst.insert(base_node, node); end; }
  x.report("Min Binary Heap insert 10k:      ") { n = 2; 9999.times do; node = Node.new("#{n}", n); n += 1; mbh.insert(node); end; }
  x.report("Binary Search Tree find node 5k:   ") { bst.find(base_node, "5000") }
  x.report("Min Binary Heap find node 5k:      ") { mbh.find("5000") }
  x.report("Binary Search Tree delete node 5k:   ") { bst.delete(base_node, "5000") }
  x.report("Min Binary Heap delete node 5k:      ") { mbh.delete("5000") }
  x.report("Binary Search Tree:   ") { bst.printf }
  x.report("Min Binary Heap:      ") { mbh.print }
end
