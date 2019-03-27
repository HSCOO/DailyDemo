import UIKit


class MyCircularQueue {
    
    /** Initialize your data structure here. Set the size of the queue to be k. */
    var arr: [Int]
    var start: Int
    var end: Int
    let size: Int
    
    
    init(_ k: Int) {
        arr = Array.init(repeating: 0, count: k)
        start = -1
        end = -1
        size = k
    }
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    
    func enQueue(_ value: Int) -> Bool {
        // 如果满了，就false
        if isFull() == true {
            return false
        }
        // 如果空的，就设置开始位置
        if isEmpty() == true {
            start = 0
        }
        // 取模的好处，溢出值继续利用前面的值
        end = (end + 1) % size;
        // 从尾部添加数据
        arr[end] = value
        return true
    }
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    
    func deQueue() -> Bool {
        if isEmpty() == true{
            return false
        }
        // 队列先进先出，所以移动开始位置
        if start == end{
            start = -1
            end = -1
            return true
        }
        // 取模的好处，溢出值继续利用
        start = (start + 1) % size
        return true
    }
    /** Get the front item from the queue. */
    
    func Front() -> Int {
        if isEmpty() == true{
            return -1
        }
        
        return arr[start]
    }
    /** Get the last item from the queue. */
    
    func Rear() -> Int {
        if isEmpty() == true{
            return -1
        }
        
        return arr[end]
    }
    /** Checks whether the circular queue is empty or not. */
    
    func isEmpty() -> Bool {
        // 开始位置还是默认值
        return start == -1
    }
    /** Checks whether the circular queue is full or not. */
    
    func isFull() -> Bool {
        // 尾部位置和首部位置重合，就代表满了
        return ((end + 1) % size) == start
    }
}

/**
 * Your MyCircularQueue object will be instantiated and called as such:
 
 */

let obj = MyCircularQueue(3)
let ret_1: Bool = obj.enQueue(2)
//let ret_2: Bool = obj.deQueue()
let ret_3: Int = obj.Front()
let ret_4: Int = obj.Rear()
let ret_5: Bool = obj.isEmpty()
let ret_6: Bool = obj.isFull()

