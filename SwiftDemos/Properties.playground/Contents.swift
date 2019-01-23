import UIKit

var str = "Hello, playground"

// 属性

struct FixedLengthRange{
    var firstValue:Int
    let length:Int
}

var rangeOfThreeItems = FixedLengthRange.init(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

// 常量实例，不能修改里面的属性值
//let rangeOfFourItems = FixedLengthRange.init(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 9

// 懒加载
class DataImporter{
    var filename = "data.txt"
}

class DataManager{
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// 只有在用到的地方才会初始化
print(manager.importer.filename)

// get&set方法
struct Point{
    var x = 0.0, y = 0.0
}

struct Size{
    var width = 0.0, height = 0.0
}

struct Rect{
    var origin = Point()
    var size = Size()
    var center: Point{
        get{
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point.init(x: centerX, y: centerY)
        }
        
        set(newCenter){
            origin.x = newCenter.x - size.width / 2
            origin.y = newCenter.y - size.height / 2
        }
    }
}

var square = Rect.init(origin: Point.init(x: 0.0, y: 0.0), size: Size.init(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point.init(x: 15.0, y: 15.0)
print("square.origin is now at \(square.origin.x), \(square.origin.y)")

// 一般set方法都可以使用newValue获取到值
struct AlternativeRect{
    var origin = Point()
    var size = Size()
    var center: Point{
        get{
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point.init(x: centerX, y: centerY)
        }
        
        set{
            origin.x = newValue.x - size.width / 2
            origin.y = newValue.y - size.height / 2
        }
    }
}

// read-only值
struct Cuboid{
    var width = 0.0, height = 0.0, depth = 0.0
    var volume:Double{
        return width * height * depth
    }
}

var fourByFiveByTwo = Cuboid.init(width: 4, height: 5, depth: 2)
// 只有get方法，不能使用set赋值
print("volume \(fourByFiveByTwo.volume)")
//fourByFiveByTwo.volume = 14
fourByFiveByTwo.width = 19
print("volume \(fourByFiveByTwo.volume)")

// 属性监听
class StepCounter{
    var totalSteps:Int = 0{
        willSet{
            print("About to set totalSteps to \(newValue)")
        }
        
        didSet{
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 996

//各种数据类型的静态变量
struct SomeStructure{
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int{
        return 1
    }
}

enum SomeEnumeration{
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty:Int{
        return 6
    }
}

class SomeClass{
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int{
        return 27
    }
    class var overrideableComputedTypeProperty: Int{
        return 107
    }
}

print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)


struct AudioChannel{
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0{
        didSet{
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            
            if currentLevel > AudioChannel.maxInputLevelForAllChannels{
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)

print(AudioChannel.maxInputLevelForAllChannels)
