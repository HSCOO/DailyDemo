import UIKit

var str = "Hello, playground"

// 参数标签，参数名称
func someFunction(one firstParameterName: Int, two secondParameterName: Int){
    print("\(firstParameterName) + \(secondParameterName)")
}

someFunction(one: 1, two: 2)

// 不带参数标签
func otherFunction(firstParameterName: Int,secondParameterName: Int){
    print("1223")
}
otherFunction(firstParameterName: 2, secondParameterName: 3)

// 默认参数
func xxFunction(one:Int,second:Int = 12) -> Int{
    return one + second
}

print(xxFunction(one: 10))
print(xxFunction(one: 10, second: 10))

// 可变参数
func arithmeticMean(_ numbers:Double...) -> Double{
    var total:Double = 0
    for number in numbers {
        total += number
    }
    return total
}
print(arithmeticMean(1,2,3))

// inout参数修饰，可以改变参数变量
func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let tmpA = a
    a = b
    b = tmpA
}

var sInt = 3
var bInt = 7
swapTwoInts(&sInt, &bInt)
print("\(sInt) \(bInt)")

// function type

func addTwoInts(_ a:Int, _ b:Int) -> Int{
    return a + b
}

func multiplyTwoInts(_ a:Int, _ b:Int) -> Int{
    return a * b
}
// 函数类型都是(Int, Int) -> Int
var mathFunc: (Int, Int) -> Int = addTwoInts
print(mathFunc(2,3))

// 还可以继续赋值给相同类型的函数
mathFunc = multiplyTwoInts
print(mathFunc(2,3))

// 函数类型可以作为一个方法的参数

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a:Int, _ b:Int){
    print("Result: \(mathFunction(a,b))")
}

printMathResult(addTwoInts, 2, 5)

// 函数类型作为返回值
func stepForward(_ input: Int) -> Int{
    return input + 1
}

func stepBackward(_ input: Int) -> Int{
    return input - 1
}

func chooseStepFunc(backward: Bool) -> (Int) -> Int{
    return backward ? stepBackward : stepForward
}

var moveNearToZero = chooseStepFunc(backward: true)
print(moveNearToZero(2))

// 函数嵌套
func yyChooseStepFunc(backward: Bool) -> (Int) -> Int{
    func yyStepForward(_ input: Int) -> Int{
        return input + 1
    }
    
    func yyStepBackward(_ input: Int) -> Int{
        return input - 1
    }
    
    return backward ? yyStepBackward : yyStepForward
}

var currentValue = -4
let yyMoveNearerToZero = chooseStepFunc(backward: currentValue > 0)
while currentValue != 0{
    print("\(currentValue)...")
    currentValue = yyMoveNearerToZero(currentValue)
}




