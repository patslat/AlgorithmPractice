#  invariants
#  1) each node red or black, new journal printing tech allowed printing red or black
#     but then it wasn't available, but the name still stuck
#
#  2) root is black
#
#  3) no 2 reds in a row (red node has only black children
#
#  4) every ROOT-NULL path has same number of black nodes, every unsuccessful path
#     traverses the same number of black nodes
#
#  ex1) a chain of length 3 cannot be a red-black tree
#  ex2)       5blk                              5blk
#        3blk/    \7blk         OR         3blk/    \7red
#             6red/    \8red                      6blk/   \8blk
#
#  Height Guarantee: every red-black tree with n nodes has height <= 2log2(n+1)

class RedBlackTree
  attr_accessor :sentinel, :root

  def initialize
    @sentinel = RedBlackNode.new(nil, nil, nil, nil)
    @root = @sentinel
  end

  def to_s
    q = [@root]
    while current = q.shift
      print "black-leaf" and next if current == @sentinel
      print "#{current.color}-#{current.key.to_s}  "
      q << current.left
      q << current.right
    end
  end

  def insert(key)
    p "insert called with key: #{key}, root: #{root}"
    node = RedBlackNode.new(key, @sentinel, @sentinel, @sentinel)
    y = @sentinel
    x = @root
    insert_point = find_insert_point(node)
    while x != @sentinel
      y = x
      x = node.key < x.key ? x.left : x.right
    end

    node.parent = y

    if y == @sentinel
      p "setting root to #{node.key}"
      @root = node
    elsif node.key < y.key
      p "setting #{y.key}'s left to #{node.key}"
      y.left = node
    else
      p "setting #{y.key}'s right to #{node.key}"
      y.right = node
    end

    node.left = @sentinel
    node.right = @sentinel
    node.color = :red

    insert_fixup(node)
  end

  def insert_fixup(node)
    if node.parent == @sentinel # 1) node is root
      case_one(node)
    elsif node.parent.color == :black
      case_two(node) # 2) tree is valid
    elsif node.uncle && node.uncle.color == :red
      case_three(node)
    else
      case_four(node)
      case_five(node)
    end
    p "fixup done, here's what the tree looks like after adding #{node.key}"
    p self.to_s
  end

  def case_one(node)
    node.color = :black
  end

  def case_two(node)
    true
  end

  def case_three(node)
    node.parent.color = :black
    node.uncle.color = :black
    node.grandparent.color = :red
    case_one(node.grandparent)
  end

  def case_four(node)
    if (
      node == node.parent.right &&
      node.grandparent &&
      node.parent == node.grandparent.left
    )
      rotate_left(node.parent)
    elsif (
      node == node.parent.left &&
      node.grandparent &&
      node.parent == node.grandparent.right
    )
      rotate_right(node)
    end
  end

  def case_five(node)
    node.parent.color = :black
    node.grandparent.color = :red if node.grandparent
    if node == node.parent.left
      rotate_right(node.grandparent)
    else
      rotate_left(node.grandparent)
    end
  end

#  def insert_fixup(node)
#    while node.color == :red
#      if node.parent == node.parent.parent.left
#        y = node.parent.parent.left
#
#        if y.color = :red
#          node.parent.color = :black
#          y.color = :black
#          node.parent.parent.color = :red
#          node = node.parent.parent
#
#        elsif node == node.parent.right
#          node = node.parent
#          left_rotate(node)
#        end
#
#        node.parent.color = :black
#        node.parent.parent.color = :red
#        right_rotate(node.parent.parent)
#      else
#
#        y = node.parent.parent.right
#
#        if y.color = :red
#          node.parent.color = :black
#          y.color = :black
#          node.parent.parent.color = :red
#          node = node.parent.parent
#
#        elsif node == node.parent.left
#          node = node.parent
#          right_rotate(node)
#        end
#
#        node.parent.color = :black
#        node.parent.parent.color = :red
#        left_rotate(node.parent.parent)
#      end
#    end
#  end

  def rotate_left(node)
    y = node.right
    node.right = y.left

    y.left.parent = node if y.left.parent != @sentinel
    y.parent = node.parent
    if node.parent == @sentinel
      node.parent.left = y
    else
      node.parent.right = y
    end

    y.left = node
    node.parent = y
  end

  def rotate_right(node)
    y = node.left
    node.left = y.right

    y.right.parent = node if y.right.parent != @sentinel
    y.parent = node.parent
    if node.parent == @sentinel
      node.parent.right = y
    else
      node.parent.left = y
    end

    y.right = node
    node.parent = y
  end
end

class RedBlackNode
  attr_accessor :key, :color, :parent, :right, :left
  def initialize(key, parent, left, right)
    @key = key
    @parent = parent
    @left = left
    @right = right
  end

  def grandparent
    @parent.parent if @parent
  end

  def uncle
    return nil unless grandparent
    @parent == grandparent.left ? grandparent.right : grandparent.left
  end
end

t = RedBlackTree.new
[5, 3, 8, 1, 20, 50, 30, 2].each do |n|
  t.insert(n)
end

t.to_s
