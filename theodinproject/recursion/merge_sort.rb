def merge_sort(arr)
  return arr if arr.length <= 1

  middle_index = arr.length / 2
  left_part = arr[0...middle_index]
  right_part = arr[middle_index..-1]
  left_sorted_arr = merge_sort(left_part)
  right_sorted_arr = merge_sort(right_part)

  sort_arrs(left_sorted_arr, right_sorted_arr)
end

def sort_arrs(left_arr, right_arr)
  result = []
  left_arr_index = 0
  right_arr_index = 0
  
  while left_arr_index < left_arr.length && right_arr_index < right_arr.length
    if left_arr[left_arr_index] < right_arr[right_arr_index]
      result << left_arr[left_arr_index]
      left_arr_index += 1
    else
      result << right_arr[right_arr_index]
      right_arr_index += 1
    end
  end

  if left_arr[left_arr_index]
    result.concat(left_arr[left_arr_index..-1])
  else
    result.concat(right_arr[right_arr_index..-1])
  end
  result
end

p merge_sort([3, 7, 1, 0, 7, 2, 6])
