# insertion sor
# at the start of each iteration of the each loop, the subarray[1..j - 1]
# consists of the elements originally in arr[1..j - 1], but in sorted order.
# Theta of n^2

def insertion_sort(arr)
  sorter = arr.dup
  (1...sorter.count).each do |j|
    key = sorter[j]

    i = j - 1
    while (i > -1) && sorter[i] > key
      sorter[i + 1] = sorter[i]
      i -= 1
    end

    sorter[i + 1] = key
  end
  sorter
end
#
#  a = [3, 2, 1]
#  p insertion_sort(a)
# 
#  test = (1..5000).to_a.shuffle!
# 
#  p insertion_sort(test)
#  p insertion_sort(test) == (1..5000).to_a

def merge(left, right)
  merged = []

  until left.empty? || right.empty?
    left[0] < right[0] ? merged << left.shift : merged << right.shift
  end
  return merged + left + right
end



def merge_sort(arr)
  return arr if arr.count == 1
  left = merge_sort(arr[0...(arr.count / 2)])
  right = merge_sort(arr[(arr.count / 2)...arr.count])
  return merge(left, right)
end

#  a = [3, 2, 1]
#  p merge_sort(a)
#
#  test = (1..5000).to_a.shuffle!
#  p merge_sort(test)
#  p merge_sort(test) == (1..5000).to_a
