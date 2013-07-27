# CLRS CH10.1
class Stack
  def initialize
    @stack = []
    @top = 0
  end

  def push(element)
    @stack[@top] = element
    @top += 1
    self
  end

  def pop
    raise "stack underflow" if empty?
    element = @stack[@top - 1]
    @top -= 1
    @stack = @stack[0...@top]
    return element
  end

  def empty?
    @top < 1
  end
end
#  stack = Stack.new
#  stack.push(5)
#  stack.push(4)
#  stack.push(3)
#  stack.pop
#  stack.pop
#  p stack.pop

class Queue
  def initialize
    @queue = []
    @head = 0
    @tail = 0
  end

  def enqueue

  end

  def empty?
  end
end
