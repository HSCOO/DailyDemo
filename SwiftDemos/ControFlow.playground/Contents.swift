import UIKit

var str = "Hello, playground"

// switch允许判断元组
let somePoint = (1,1)
switch somePoint {
case (0,0):
    print("\(somePoint)")
case (_,0):
    print("\(somePoint)")
case (0,_):
    print("\(somePoint)")
case (-2...2,-2...2):
    print("\(somePoint)")
default:
    print("\(somePoint)")
}

let anotherPoint = (2,0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with an y value of \(y)")
case let(x,y):
    print("somewhere else at (\(x),\(y))")
}

// switch 可以加入条件
let yetAnotherPoint = (1,-1)
switch yetAnotherPoint {
case let(x,y) where x == y:
    print("(\(x),\(y)) is on the line x == y")

case let(x,y) where x == -y:
    print("(\(x),\(y)) is on the line x == -y")
    
case let(x,y):
    print("(\(x),\(y)) is just some arbitrary point")
}


// 多个条件，相同的处理
let stillAnotherPoint = (9,0)
switch stillAnotherPoint {
case (let distance, 0),(0, let distance):
    print("On an axis, \(distance) from ther origin")
default:
    print("Not on an axis")
}

// 控制语句的关键词fallthrough，会直接到下一个匹配项

let integerToDesc = 5
var des = "the number \(integerToDesc) is"

switch integerToDesc {
case 2,3,5,7,9:
    des += " a prime number,  and also"
    fallthrough
case 10,11:
    des += " > 9"
case let x where x > 12:
    des += " \(x) > 12"
default:
    des += "an int"
}
print(des)

// 可以单独标记一个循环，然后直接操作标记即可，相当于把循环赋值给这个变量

var square = 0
var diceRoll = 0
gameLoop: while square != 9{
    diceRoll += 1
    if diceRoll == 7 {
        diceRoll = 1
    }
    // 检查是否匹配上9，如果匹配上，关闭循环
    switch square + diceRoll {
    case 9:
        break gameLoop
    
    // 如果大于9，就继续执行
    case let newSq where newSq > 9:
        continue gameLoop
        
        // 其他情况就叠加
    default:
        square += diceRoll
    }
}

print("Game over!")

// 提前判断，可以用来提前判断参数，只有满足条件的才能继续执行
func greent(x:Int){
    guard x > 5 else{
        return
    }
    
    print("x > 5")
    
    guard x < 10 else {
        return
    }
    
    print("5< x < 10")
}

//greent(x: 6)
greent(x: 2)

// 系统判断
if #available(iOS 10,iOSMac 10.12, *){
   print("iOS 10,iOSMac 10.12")
}else{
   print("other iOS 10,iOSMac 10.12")
}



