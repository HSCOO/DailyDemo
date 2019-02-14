import UIKit

var str = "Hello, playground"

// 范型

func swapTwoValues<T>(_ a: inout  T, _ b: inout T){
    let tmpA = a
    a = b
    b = tmpA
}

var someInt = 3
var anotherInt = 109
swap(&someInt, &anotherInt)
print("some\(someInt) another\(anotherInt)")

var someStr = "hello"
var anotherStr = "world"
swap(&someStr, &anotherStr)
print("someStr \(someStr), anotherStr \(anotherStr)")

// 普通版本
struct IntStack{
    var items = [Int]()
    mutating func push(_ item:Int){
        items.append(item)
    }
    mutating func pop() -> Int{
        return items.removeLast()
    }
}

// 范型版本
struct Stack<Element>{
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

extension Stack {
    var topItem: Element?{
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// 范型可以添加继承、协议

// 普通版本，查找数组中是否存在某一个元素，有就返回序号，没有就返回nil
func findIndex(ofString valueToFind: String, in array: [String]) -> Int?{
    for (index, value) in array.enumerated() {
        if value == valueToFind{
            return index
        }
    }
    return nil
}

// 范型版本
func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int?{
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubelIndex = findIndex(of: 9.0, in: [3.14,0.1,0.25])

// 协议
protocol Container{
    // 关联类型
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int {get}
    subscript(i: Int) -> Item {get}
}

struct IntStack2: Container{
    // 指定类型
    typealias Item = Int
    
    var count: Int
    
    subscript(i: Int) -> Int {
        return items[i]
    }
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    // 栈操作方法
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    mutating func pop() -> Int{
        return items.removeLast()
    }
}

struct Stack2<Element>: Container{
    
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
    
    // 协议
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int{
        return items.count
    }
    subscript(i: Int) -> Element{
        return items[i]
    }
}

protocol Container2{
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int {get}
    subscript(i: Int) -> Item {get}
}

protocol  SuffixbaleContainer: Container2{
    associatedtype Suffix: SuffixbaleContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

//extension Stack2: SuffixbaleContainer{
//
//    func suffix(_ size: Int) -> Stack2<Int> {
//        var result = Stack2<Int>()
//        for index in (count - size)..<count {
//            result.append(self[index] as! Int)
//        }
//        return result
//    }
//}

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable{
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    return true
}

//var stackOfStrs = Stack<String>()
//stackOfStrs.push("uno")
//stackOfStrs.push("dos")
//stackOfStrs.push("tres")
//
//var arrOfStrs = ["uno","dos","tres"]
//if allItemsMatch(stackOfStrs, stackOfStrs) {
//    print("all")
//}else{
//    print("not all")
//}
