// binary search tree
// inorder tree walk = in order
// preeorder prints the root before the subtree
// postorder prints the root after the subtree values

function Tree () {
  this.sentinel = new TreeNode(null)
  this.head = this.sentinel;
}

Tree.prototype.search = function (key) {}
Tree.prototype.min = function () {}
Tree.prototype.max = function () {}
Tree.prototype.predecessor = function () {}
Tree.prototype.successor = function () {}
Tree.prototype.remove = function (key) {
  node = self.search(key)
}

Tree.prototype.insert = function (key) {
  var node = new TreeNode(key);
  node.left = this.sentinel;
  node.right = this.sentinel;

  var insertPoint = this.findInsertPoint(node);

  if (insertPoint === null) {
    this.head = node;
    this.head.left = this.sentinel;
    this.head.right = this.sentinel;
  } else if (node.key <= insertPoint.key) {
    insertPoint.left = node;
  } else {
    insertPoint.right = node;
  }
  return node;
}

Tree.prototype.findInsertPoint = function (node) {
  var current = this.head;
  var insertPoint = null

  if (current === null) return null;

  while (current != this.sentinel) {
    insertPoint = current
    if (node.key < current.key) {
      current = current.left;
    } else {
      current = current.right;
    }
  }
  return insertPoint;
}

function TreeNode (key) {
  this.key = key;
  this.parent = null;
  this.left = null;
  this.right = null;
}

var t = new Tree
t.insert(10)
t.insert(4)
t.insert(6)

t.insert(2)
t.insert(5)
console.log(t)
console.log(t.head.left.right)
