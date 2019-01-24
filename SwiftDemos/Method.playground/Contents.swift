import UIKit

var str = "Hello, playground"

class Counter {
    var count = 0
    func increment(){
        self.count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset(){
        count = 0
    }
}

let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()
print(counter.count)

//  隐含self属性
//func increment(){
//    self.count += 1
//}

// 自身属性值、参数值一致时，可以用self区分一下，其余可以不用写
struct Point{
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double){
        x += deltaX
        y += deltaY
    }
    
    mutating func moveByTo(x deltaX: Double, y deltaY: Double){
        self = Point.init(x: x + deltaX, y: y + deltaY)
    }
}

var somePoint = Point.init(x: 4, y: 5)
if somePoint.isToTheRightOf(x: 1.0){
    print("this point is to right of the line where x == 1.0")
}

// 值类型的属性值，不能在方法中更改
// 结构体、枚举都属于值类型
// 如果一定要修改，一定要加上mutating
somePoint.moveBy(x: 2.0, y: 3.0)
print("Point now at \(somePoint.x)")

// 枚举中的应用
// 不能走向下一个
enum TristateSwitch{
    case off, low, high
    mutating func next(){
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TristateSwitch.low
ovenLight.next()
print(ovenLight)
ovenLight.next()
print(ovenLight)

// 类方法
class SomeClass{
    class func someTypeMethod() {
        print("some type method")
    }
}

SomeClass.someTypeMethod()

struct LevelTracker{
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    // 静态方法里面可以使用静态属性，不然会报错
    static func unlock(_ level: Int){
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool{
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool{
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }else{
            return false
        }
    }
}

//var tracker = LevelTracker()
//print(tracker.advance(to: 5))
//LevelTracker.unlock(5)
//print(tracker.advance(to: 5))

class Player2{
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}

var player = Player2.init(name: "Ayud")
player.complete(level: 1)
print("hightest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

