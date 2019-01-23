import UIKit

var str = "Hello, playground"

// 定义语句
struct SomeStructure{
    
}
class SomeClass{
    
}

struct Resolution{
    var width = 0
    var height = 0
    var len = 0
}
class VideoMode{
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// 实例化
let someResolution = Resolution()
let someVideMode = VideoMode()
// 访问属性
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideMode.resolution.width)")

// 结构体自带有初始化方法
let vga = Resolution.init(width: 10, height: 20, len: 30)

// 结构体、枚举都是值类型
let hd = Resolution.init(width: 1920, height: 1080, len: 10)
var cinema = hd

cinema.width = 2080

print("cinema is now \(cinema.width) pixels wide")
print("hd is now \(hd.width) pixels wide")

// 类是引用类型的
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

// 恒等运算符，因为引用类型可能会引用相同实例，所以可以通过恒等来检查
if tenEighty === alsoTenEighty{
    print("same")
}

// 恒等只能说明，两个变量/常量引用的是同一个实例
// 而相等，是指两个变量/常量所有的属性值都相等







