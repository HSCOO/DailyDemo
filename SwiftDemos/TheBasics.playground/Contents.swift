import UIKit

var str = "Hello, playground"

// 多个变量
if let firstNumber = Int("4"),let secondNumber = Int("42"),firstNumber < secondNumber && secondNumber < 100{
    print("\(firstNumber) < \(secondNumber) < 100")
}

// ？修饰的optional值，在使用时，必须用！解包
// 解包和不解包的区别，就是包裹了一层Optional修饰语
let possibleString: String? = "An optional string."
let forcedString:String = possibleString!
print(possibleString as Any)
print(forcedString)

// ！修饰的optional值，在使用时不需要用！解包，已经隐式地解包完成
let assuemedString: String! = "must has string"
let implictString: String = assuemedString
print(assuemedString)
print(implictString)
// 也可以直接按照普通值进行解包
if assuemedString != nil {
    print(assuemedString!)
}

// 也可以直接赋值给一个非Optional的值进行解包
if let definiteString = assuemedString{
    print(definiteString)
}

// 捕获异常
//func canThrowAnError() throws{
//    let assuemedString: String! = nil
//    let implictString: String = assuemedString
//    print(implictString)
//
//}

//do {
//    try canThrowAnError()
//    print("no")
//} catch {
//    print(error)
//}

// 断言
let age = 3
//assert(age > 0, "A person`s age can`t be less than zero.")
//assert(age > 0)

// 断言失败

if age > 10 {
    print("than 10")
}else if age >= 0{
    print("than 0")
}else{
    assertionFailure("A person`s age can`t be less than zero.")
}

// 前置条件
let index = 10
precondition(index > 0, "Index must be greater than zero.")

print("123")









