import UIKit

var str = "Hello, playground"
enum CompassPoint{
    case north
    case south
    case east
    case west
}

enum Planet{
    case mercury, venus, earth,mars,jupiter,saturn,uranus,neptune
}

var directionToHead = CompassPoint.west
// 可以使用简写
directionToHead = .south

switch directionToHead {
case .north:
    print("north")
case .south:
    print("south")
case .east:
    print("east")
case .west:
    print("west")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("earth")
default:
    print("Not a safe humans")
}

enum Beverage: CaseIterable{
    case coffee,tea,juice
}
let numberOfChoice = Beverage.allCases.count
print("count \(numberOfChoice)")
// 遍历枚举
for beverage in Beverage.allCases {
    print(beverage)
}

// 关联值
enum Barcode{
    case upc(Int,Int,Int,Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(9, 100, 89, 3)
//productBarcode = .qrCode("ABDDKJDKSJKDHSKDH")

// 打印关联值
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC:\(numberSystem),\(manufacturer),\(product),\(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// 简写
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}

// 枚举声明值
enum ASCIIControlCharacter: Character{
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
// 隐式声明值
enum PlanetIn:Int{
    case mercury = 1,venus,earth,mars,jupiter,saturn,uranus,neptune
}

enum CompassPointNew: String{
    case north,south,east,west
}
let earthsOrder = PlanetIn.earth.rawValue

let sunsetDirection = CompassPointNew.west.rawValue

// c初始化
let possiblePlanet = PlanetIn(rawValue:7)

let positionToFind = 11
if let somePlanet = PlanetIn.init(rawValue: positionToFind) {
    
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
    
}else{
    print("There isn't a planet at position \(positionToFind)")
}

// 递归调用
indirect enum ArithmeticExpression{
    case number(Int)
    case add(ArithmeticExpression,ArithmeticExpression)
    case multi(ArithmeticExpression,ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
print(five)
let product = ArithmeticExpression.multi(five, ArithmeticExpression.number(2))
print(product)

func evaluate(_ expression: ArithmeticExpression) -> Int{
    switch expression {
    case let .number(value):
        return value
    case let .add(left, right):
        return evaluate(left) + evaluate(right)
    case let .multi(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))


