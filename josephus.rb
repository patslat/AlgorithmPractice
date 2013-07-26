class LinkedList
  attr_reader :head
  def initialize
    @head = nil
  end

  def insert(key)
    node = LinkedListNode.new(key)
    insert_point = find_insert_point
    insert_point ? (insert_point.next = node) : (@head = node)
  end

  def delete(key)
    if @head.key == key
      @head = @head.next
    else
      parent, node_to_delete = find_parent_and_key(key)
      parent.next = node_to_delete.next
    end
  end

  def find_parent_and_key(key)
    return nil unless parent = @head
    while (current = parent.next) && current.key != key
      parent = current
      current = current.next
    end
    [parent, current]
  end

  private
  def find_insert_point
    return nil if @head.nil?
    insert_point = @head
    until insert_point.next.nil?
      insert_point = insert_point.next
    end

    insert_point
  end
end

class LinkedListNode
  attr_accessor :next
  attr_reader :key
  def initialize(key)
    @key = key
    @next = nil
  end

  def set_next(key)
    @next = LinkedListNode.new(key)
  end
end

def josephus_circle(n, k)
  josephus_circle = LinkedList.new
  (1..n).each { |i| josephus_circle.insert(i) }
  head = josephus_circle.head
  (n - 1).times do |death_counter|
    (k - 1).times do
      if head.next
        head = head.next
      else
        head = josephus_circle.head
      end
    end
    head = josephus_circle.delete(head.key)
    head = josephus_circle.head if head.nil?
  end

  puts "If there are #{n} people in the circle, you would want to stand
        in the #{josephus_circle.head.key} position."
end
