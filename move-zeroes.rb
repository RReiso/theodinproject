# Given an integer array nums, move all 0's to the end of it 
# while maintaining the relative order of the non-zero elements.
# Note that you must do this in-place without making a copy of the array.

def move_zeroes(nums)
  nums.size.times do |num|
    if nums[num]==0
      nums[num]=nil
      nums.push(0)
    end
  end
  nums.compact!
end

move_zeroes([0,1,0,3,12])
# Output: [1,3,12,0,0]
# Example 2:

move_zeroes([0])
# Output: [0]