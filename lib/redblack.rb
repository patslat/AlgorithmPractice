# 1) all nodes either red / black
# 2) every leaf (nil) is black
# 3) If a node is red, both children are black
# 4) every simple path from a node to a descendant leaf contains the same number of black nodes

class RBTree
  attr_reader :root
  def initialize
    @sentinel = RBNode.new(nil)
    @root = @sentinel
  end

  def each(&blk)
    @root.each(&blk)
  end

  def to_a
    q = [@root]
    vals = []
    until q.empty?
      item = q.shift
      if item == @sentinel
        vals << [nil, item.color]
        next
      else
        vals << [item.key, item.color]
        q << item.left
        q << item.right
      end

    end

    vals
  end

  def insert(key)
    node = RBNode.new(key, @sentinel, @sentinel)
    node.color = :red
    insert_point = find_insert_point(node)
    if insert_point == @sentinel
      @root = node
      node.parent = @sentinel
    elsif node.key <= insert_point.key #abstract adoption further
      node.parent = insert_point
      insert_point.left = node
    else
      node.parent = insert_point
      insert_point.right = node
    end

    insert_case1(node)
  end

  def search(key)
    current = @root
    until current == @sentinel || current.key == key
      current = key <= current.key ? current.left : current.right
    end
    current
  end

  def delete(key)
    node = search(key)
    delete_no_child(node) if node.left == @sentinel && node.right == @sentinel
    if (node.left != @sentinel) && (node.right != @sentinel)
      delete_two_child(node)
    else
      delete_one_child(node)
    end
  end

  private

  def transplant(old, new)
    if old.parent == @sentinel
      @root = new
    elsif old.is_left_child?
      old.parent.left = new
    else
      old.parent.right = new
    end
    new.parent = old.parent unless new == @sentinel
    new.left = old.left unless new == @sentinel || old == @sentinel
    new.right = old.right unless new == @sentinel || old == @sentinel
  end

  def delete_no_child(node)
    node.parent.left = @sentinel if node.is_left_child?
    node.parent.right = @sentinel if node.is_right_child?
  end

  def delete_two_child(node)
    p "inorder succ is #{node.inorder_successor}"
    p node.inorder_successor.key
    new_node = node.inorder_successor
    node.key = new_node.key
    transplant(node, @sentinel)
  end

  def delete_one_child(node)
    child = node.left == @sentinel ? node.right : node.left
    transplant(node, child)
    if node.black? && child.red?
      child.color = :black
    else
      delete_case1(child)
    end
    #can delete node
  end

  def delete_case1(node)
    delete_case2(node) unless @root == node
  end

  def delete_case2(node)
    if node.sibling && node.sibling.red?
      node.parent.color = :red
      node.sibling.color = :black
      rotate_left(node) if node.is_left_child?
      rotate_right(node) if node.is_right_child?
    end
    delete_case3(node)
  end

  def delete_case3(node)
    if (
      node.parent.black? &&
      node.sibling.black? &&
      node.sibling.left.black? &&
      node.sibling.right.black?
    )
      node.sibling.color = :red
      delete_case1(node.parent)
    else
      delete_case4(node)
    end
  end

  def delete_case4(node)
    if (
      node.parent.red? &&
      node.sibling.black? &&
      node.sibling.left.black? &&
      node.sibling.right.black?
    )
      node.sibling.color = :red
      node.parent.color = :black
    else
      delete_case5(node)
    end
  end

  def delete_case5(node)
    if node.sibling.black?
      if (
        node.is_left_child? &&
        node.sibling.right.black? &&
        node.sibling.left.red?
      )
        node.sibling.color = :red
        sibling.left.color = :black
        rotate_right(node.sibling)
      elsif (
        node.is_right_child? &&
        node.sibling.left.black? &&
        node.sibling.right.red?
      )
        node.sibling.color = :red
        node.sibling.right.color = :black
        rotate_left(node.sibling)
      end
    end
    delete_case6(node)
  end

  def delete_case6(node)
    node.sibling.color = node.parent.color
    node.parent.color = :black

    if node.is_left_child?
      node.sibling.right.color = :black
      rotate_left(node.parent)
    else
      node.sibling.left.color = :black
      rotate_right(node.parent)
    end
  end

  def insert_case1(node)
    if node.parent == @sentinel
      node.color = :black
    else
      insert_case2(node)
    end
  end

  def insert_case2(node)
    insert_case3(node) unless node.parent.color == :black
  end

  # parent is red if it reaches this case
  def insert_case3(node)
    if node.uncle && node.uncle.red?
      node.parent.color = :black
      node.uncle.color = :black
      node.grandparent.color = :red

      insert_case1(node.grandparent)
    else
      insert_case4(node)
    end
  end

  def insert_case4(node)
    if node.is_left_child? && node.parent.is_right_child?
      rotate_right(node.parent)
      node = node.right
    elsif node.is_right_child? && node.parent.is_left_child?
      rotate_left(node.parent)
      node = node.left
    end
    insert_case5(node)
  end

  def insert_case5(node)
    node.parent.color = :black
    node.grandparent.color = :red

    if node.is_left_child?
      rotate_right(node.grandparent)
    else
      rotate_left(node.grandparent)
    end
  end

  def rotate_left(node)
    new_parent = node.right
    new_parent.parent = node.parent
    if node.is_left_child?
      node.parent.left = new_parent
    elsif node.is_right_child?
      node.parent.right = new_parent
    else
      @root = new_parent
    end
    node.parent = new_parent
    node.right = new_parent.left
    new_parent.left = node
  end

  def rotate_right(node)
    new_parent = node.left
    new_parent.parent = node.parent
    if node.is_left_child?
      node.parent.left = new_parent
    elsif node.is_right_child?
      node.parent.right = new_parent
    else
      @root = new_parent
    end
    node.parent = new_parent
    node.left = new_parent.right
    new_parent.right = node
  end

  def find_insert_point(node)
    current, insert_point  = @root, @sentinel
    until current == @sentinel
      insert_point = current
      current = node.key < current.key ? current.left : current.right
    end
    insert_point
  end
end

class RBNode
  attr_accessor :key, :color, :left, :right, :parent
  def initialize(key, left = nil, right = nil, parent = nil)
    @key = key
    @left = left
    @right = right
    @parent = parent
    @color = :black
  end

  def each(&blk)
    @left.each(&blk) unless @left.key == nil
    blk.call(self)
    @right.each(&blk) unless @right.key == nil
  end

#  def inorder_predecessor
#  end
#
  def inorder_successor
    current = self.left
    next_node = self.left
    until next_node == @sentinel
      current = next_node
      next_node = current.right
    end
    return current
  end

  def is_left_child?
    self == parent.left
  end

  def is_right_child?
    self == parent.right
  end

  def red?
    @color == :red
  end

  def black?
    @color == :black
  end

  def grandparent
    parent.parent if parent
  end

  def uncle
    if grandparent
      return grandparent.right if parent.is_left_child?
      return grandparent.left if parent.is_right_child?
    end
  end

  def sibling
    self == parent.left ? parent.right : parent.left
  end
end

t = RBTree.new
10.times do |n|
  t.insert n
end
p t.to_a
t.delete(3)
p t.to_a
