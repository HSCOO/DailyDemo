
public class ListNode{
    public var val: Int
    public var next: ListNode?
    public init(val: Int){
        self.val = val
        self.next = nil
    }
    
    func insert(loc: Int, val: Int) -> ListNode {
        
        var i = 1
        var currentNode: ListNode?
        currentNode = self
        while ((currentNode != nil) && i < loc - 1) {
            currentNode = currentNode?.next
            i = i + 1
        }
    }
}



