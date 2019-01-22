import UIKit

var str = "Hello, playground"

var names = ["Chris","Alex","Ewa","Barry","Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool{
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)

reversedNames = names.sorted(by: {(s1:String, s2:String) -> Bool in
    return s1 < s2
})
print(reversedNames)

// 根据上下文推断数据类型
reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})
// 省略return
reversedNames = names.sorted(by: {s1, s2 in s1 > s2})
//
reversedNames = names.sorted(by: { $0 > $1})
print(reversedNames)
// 只用比较符号即可
reversedNames = names.sorted(by: >)


// 尾随闭包·
func someFunctionThatTakesAClosure(closure: () -> Void) {
    
}
// 可以这样调用
someFunctionThatTakesAClosure(closure: {
    
})
// 简写
someFunctionThatTakesAClosure {
    
}

var reversedNamesJ = names.sorted(){ $0 > $1}
print(reversedNamesJ)
reversedNamesJ = names.sorted{$0 > $1}
print(reversedNamesJ)

// 尾随闭包的map用法
let digitNames = [
    0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",
    5:"Five",6:"Six",7:"Seven",8:"Six",9:"Nine"
]
let numbers = [16,58,510]

// 转化成字符串
let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat{
        // 取余对应的字符串
        output = digitNames[number % 10]! + output
        // 取每一位数
        number /= 10
    }while number > 0
    
    return output
}

print(strings)


// 函数变量可以储存内部结果
func makeIncrementer(forIncrement amount: Int) -> () -> Int{
    var runningTotal = 0
    func incrementer() -> Int{
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let newIncrementer = makeIncrementer(forIncrement: 5)
// 运行多次就会叠加多次结果
print(newIncrementer())
print(newIncrementer())
print(newIncrementer())

let incrementer7 = makeIncrementer(forIncrement: 7)
print(incrementer7())
print(newIncrementer())

// 闭包需要注意循环引用
// 闭包是引用类型，所以才可以一直保存有runningTotal的值
let xxIncrement = makeIncrementer(forIncrement: 10)
let yyIncrement = xxIncrement
print(xxIncrement())
print(yyIncrement())
// 两个变量可以同时影响一个结果

// 逃逸闭包
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping ()-> Void){
    completionHandlers.append(completionHandler)
}

func someFuncWithNonescapingClosure(closure: () -> Void){
    closure()
}

class SomeClass{
    var x = 10
    func doSomething() {
        // 逃逸闭包可以控制执行时机
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        // 非逃逸闭包就直接执行
        someFuncWithNonescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print("x -- \(instance.x)")

completionHandlers.first?()
print("x after -- \(instance.x)")

// 自动闭包

var customersIntLine = ["Chris","Alex","Ewa","Barry","Daniella"]
print("customersIntLine.count  -- \(customersIntLine.count)")
// customersRemove是一个闭包，()->String
let customersRemove = { customersIntLine.remove(at: 0) }
print("customersIntLine remove -- \(customersRemove())")

print("customersIntLine.count  -- \(customersIntLine.count)")

func serve(customer customerProvider: ()->String){
    print("Now serving \(customerProvider())")
}

serve(customer: {customersIntLine.remove(at: 0)})


// 可以添加关键字，效果一致@autoclosure

// @autoclosure 和  @escaping同时使用
var csProviders:[() -> String] = []
func collectCsProviders(_ csProvider: @autoclosure @escaping () -> String){
    csProviders.append(csProvider)
}

collectCsProviders(customersIntLine.remove(at: 0))
collectCsProviders(customersIntLine.remove(at: 0))

for csProvider in csProviders {
    print("Now serving ne \(csProvider())")
}












