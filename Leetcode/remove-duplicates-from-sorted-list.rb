# Remove Duplicates from Sorted List
# Given the head of a sorted linked list, delete all duplicates
#  such that each element appears only once. Return the linked list sorted as well.

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @return {ListNode}
def delete_duplicates(head)
  curr = head.nil? ? head : head.next
  prev = head
  while curr
    if curr.val == prev.val
      prev.next = curr.next
    else
      prev = curr
    end
    curr = curr.next
  end
  head
end

def delete_duplicates(head)
  curr = head
  while curr != nil && curr.next != nil
    if curr.val == curr.next.val
      curr.next = curr.next.next
    else
      curr = curr.next
    end
  end
  head
end
