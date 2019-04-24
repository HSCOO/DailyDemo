
//Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
  }
}
 
class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummpHead = ListNode(0)
        var carry = 0//进位
        var p = l1
        var q = l2
        var curr = dummpHead
        
        // 只要任意一个值没有遍历到链表尾部
        while (p != nil || q != nil) {
            let x = p?.val ?? 0
            let y = q?.val ?? 0
            let sum = carry + x + y
            // 进位只保留整数
            carry = sum / 10
            curr.next = ListNode(sum % 10)
            curr = curr.next!
            
            if (p != nil) {
                p = p?.next
            }
            
            if (q != nil) {
                q = q?.next
            }
        }
        // 遍历结束后，保留的进位
        if (carry > 0) {
            curr.next = ListNode(carry)
        }
        return dummpHead.next
    }
}

let so = Solution()
let l1 = ListNode(2)
l1.next = ListNode(10)
l1.next?.next = ListNode(10)

let l2 = ListNode(5)
l2.next = ListNode(6)
l2.next?.next = ListNode(4)

let re = so.addTwoNumbers(l1, l2)
print(re?.val ?? "")
print(re?.next?.val ?? "")
print(re?.next?.next?.val ?? "")


