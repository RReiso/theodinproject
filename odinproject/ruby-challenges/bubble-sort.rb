#Build a method bubble_sort that takes an array and returns
#a sorted array. It must use the bubble sort methodology 
 
def bubble_sort(nums)
  # nums.each_index do |i|
    # p nums[i], nums[i+1]
    i=0
    until nums[i+1] == nil
      if nums[i] > nums[i+1]
        nums[i],nums[i+1] = nums[i+1], nums[i]
      end
      i+=1
    end
    p nums
  # end
end
 
bubble_sort([4,3,78,2,0,2])
# => [0,2,2,3,4,78]