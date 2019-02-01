import UIKit

var str = "Hello, playground"
// 类型嵌套
struct BlackjackCard{
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values{
            let first: Int, second: Int?
        }
        
        var values: Values{
            switch self {
            case .ace:
                return Values.init(first: 1, second: 1)
            case .jack, .queen, .king:
                return Values.init(first: 10, second: nil)
            default:
                return Values.init(first: self.rawValue, second: nil)
            }
        }
    }
    let rank: Rank, suit: Suit
    var description: String{
        var output = "suit is \(suit.rawValue)"
        output += "value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAce = BlackjackCard.init(rank: .ace, suit: .spades)
print("theAce: \(theAce.description)")


// 扩展
// 1、可以为已有类添加方法
//extension SomeType{
//    // func
//}
// 2、也可以隔离协议
//extension Sometype: SomeProtocol{
//
//}
// 3、为系统类添加计算属性
extension Double{
    var km:Double { return self * 1_000.0 }
    var ft:Double { return self / 3.28084 }
}
let oneInch = 25.4.km
print("One inch is \(oneInch) km")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

extension String{
    var xxStr: String { return self + "xx" }
}
let xx = "yy".xxStr
print(xx)


// 4、添加初始化方法
extension CGRect{
    init(center: CGPoint, size: CGSize) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        self.init(origin: CGPoint.init(x: originX, y: originY), size: size)
        
        
    }
}

// 5、添加方法
extension Int{
    func repetions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
4.repetions {
    print("0sdj")
}

// 6、改变实例对象本身，需要加mutating
extension Int{
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
print(someInt)

// 6、新增下标方法
extension Int{
    subscript(dig: Int) -> Int{
        var decimalBase = 1
        for _ in 0..<dig{
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
// 找到某一位数
89[0]

//MARK 协议

protocol FullNamed{
    var fullName: String { get }
}

struct Person: FullNamed{
    var fullName: String
}

var john = Person(fullName: "John Aplle")
john.fullName = "hello world"
print(john)
print(john.fullName)


