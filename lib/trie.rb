class Trie
  def initialize
    @root = {}
  end

  def build(str)
    node = @root
    str.chars do |char|
      node[char] ||= {}
      node = node[char]
    end
    node[:eow] = true
  end

  def find(str)
    node = @root
    str.chars do |char|
      return false unless node = node[char]
    end
    !!node[:eow]
  end

  def delete(str)
    node, last_branch, first_unique  = @root, @root, str[0]
    str.chars do |char|
      first_unique = char if node == last_branch
      return false unless node = node[char]
      last_branch = node if node.length > 1
    end

    if node.length > 1
      node[:eow] = false
    else
      last_branch.delete(first_unique)
    end
  end
end
