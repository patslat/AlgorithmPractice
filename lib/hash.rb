class DirectAddressHash
  def initialize(size, acceptable_collision_count = 3)
    @table = Array.new(size)
    @slots = size
    @keys = 0
  end

  def load_factor
    @keys / @slots
  end

  def [](key)
    hash_value = hash(key)
    possible_slot = @table[hash_value]
    until possible_slot.nil? || possible_slot.key == key
      possible_slot = possible_slot.next
    end
    possible_slot
  end

  def []=(key, val)
    hash_value = hash(key)
    entry = DirectAddressTableEntry.new(key, val)
    possible_slot = @table[hash_value]
    until possible_slot.nil? || possible_slot.key == key || possible_slot.next.nil?
      possible_slot = possible_slot.next
    end
    if possible_slot.nil?
      @table[hash_value] = entry
      @keys += 1
    elsif possible_slot.next.nil?
      possible_slot.next = entry
      entry.parent = possible_slot
      @keys += 1
    end
  end

  def delete(key)
  end

  def hash(key)
    (key.to_s.split('').map(&:ord).join.to_i) % @slots
  end

  private

  def find_nearest_prime(num)
    i = 0
    until i == num
      return (num - i) if is_prime?(num - i)
      return (num + i) if is_prime?(num + i)
      i += 1
    end
    num
  end

  def is_prime?(num)
    (2..num / 2).none? do |n|
      num % 2 == 0
    end
  end
end

class DirectAddressTableEntry
  attr_accessor :key, :val, :next, :parent
  def initialize(key, val)
    @key, @val = key, val
  end
end

h = DirectAddressHash.new(1)
p h
h["a"] = "a"
h["b"] = "b"


p h
p h["b"]
