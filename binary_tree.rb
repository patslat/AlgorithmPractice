class BinaryTree
  def initialize
    @root = nil
  end

  def to_s
    q = [@root]
    while !q.compact.empty?
      current_node = q.shift
      if current_node.nil?
        print "nil "
        next
      end
      print "#{current_node.key} "
      q << current_node.left
      q << current_node.right
    end
  end

  def insert(key)
    node = BinaryTreeNode.new(key)

    insert_point = find_insert_point(key)

    if insert_point.nil?
      @root = node
      node.set_parent(nil)
    else
      insert_point.set_child(node)
    end
  end


  private
  def find_insert_point(key)
    insert_point = nil
    x = @root

    while !x.nil?
      insert_point = x
      x = key < x.key ? x.left : x.right
    end

    insert_point
  end
end

class BinaryTreeNode
  attr_reader :key, :parent, :left, :right
  def initialize(key)
    @key = key
    @parent = nil
    @left = nil
    @right = nil
  end

  def set_child(child)
    if child.key < key
      @left = child
    else
      @right = child
    end

    child.set_parent(self)
  end

  def set_parent(parent)
    @parent = parent
  end
end
t = BinaryTree.new
(1..4).to_a.shuffle.each do |n|
  t.insert(n)
end

p t
