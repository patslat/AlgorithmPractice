def mm(arr1, arr2)
  c = [[] * arr1.length]
  arr1.count.times do |i|
    arr1.count.times do |j|
      c[i][j] = 0
      arr1.count.times do |k|
        c[i][j] += arr1[i][k] * arr2[k][i]
      end
    end
  end
  c
end

mm(
   [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
   [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
  )
