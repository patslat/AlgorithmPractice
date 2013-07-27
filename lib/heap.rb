class Heap
  attr_accessor :property

  def initialize(data, property)
    @heap = data
    @property = property
    build
  end

  def build
    ((@heap.length) / 2).downto(0) { |i| heapify(i) }
  end

  def peek
    @heap[0]
  end

  def extract
    return "heap underflow" if @heap.empty?
    item = @heap.shift
    heapify(0)
    item
  end

  def heapify(i)
    if left(i) < @heap.length && compare(@heap[left(i)], @heap[i])
      root = left(i)
    end
    root ||= i
    if right(i) < @heap.length && compare(@heap[right(i)], @heap[root])
      root = right(i)
    end
    if root != i
      @heap[i], @heap[root] = @heap[root], @heap[i]
      heapify(root)
    end
  end

  def compare(item1, item2)
    return (property == "max" ? item1 > item2 : item1 < item2)
  end

  def parent(i)
    (i - 1) / 2
  end

  def left(i)
    i * 2 + 1
  end

  def right(i)
    (i * 2) + 2
  end

  def length
    @heap.length
  end
end

class Array
  def heapsort
    heap = Heap.new(self, "min")
    (0...self.count).to_a.map { |_| heap.extract }
  end
end

a = [5, 3, 8, 10, 1, 2, 9].heapsort
p a

p heap = Heap.new([9, 10, 13, 15, 18], "max")
heap.length.times do
  p heap.extract
end

p heap = Heap.new([18, 15, 13, 10, 9], "min")
heap.length.times do
  p heap.extract
end
