# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
def merge_two_lists(l1, l2)
  new_head = ListNode.new(-1)
  prev = new_head

  while l1 || l2
    if l1.val <= l2.val
      prev.next = l1
      prev = l1 # prev = prev.next   
      l1 = l1.next
    else 
      prev.next = l2
      prev = l2 # prev = prev.next
      l2 = l2.next
    end
    # prev = prev.next
  end
  prev.next = l1 || l2
  # prev.next = l1 if l1
  # prev.next = l2 if l2
  new_head.next
end

# Input: l1 = [1,2,4], l2 = [1,3,4,5]
# Output: [1,1,2,3,4,4,5]

# Time complexity O(n + m)
# Space complexity O(1)