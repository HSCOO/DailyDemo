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
