# Palindrome Linked List
# Given the head of a singly linked list, return true if it is a palindrome.
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @return {Boolean}
def is_palindrome(head)
    array_of_values = []
     while head
      array_of_values << head.val
      head = head.next
     end
    array_of_values == array_of_values.reverse
end
