import UIKit

var str = "Hello, playground"
// 下标语法
struct TimesTable{
    let multiplier: Int
    subscript(index: Int) -> Int{
        return multiplier * index
    }
}

let threeTimesTable = TimesTable.init(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

struct Matrix{
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array.init(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double{
        get{
            assert(indexIsValid(row: row, column: column),"Index out of range")
            return grid[row * columns + column]
        }
        
        set{
            assert(indexIsValid(row: row, column: column),"Index out of range")
            grid[row * columns + column] = newValue
        }
    }
}

var matrix = Matrix.init(rows: 2, columns: 2)
matrix[0,1] = 1.5
matrix[1,0] = 3.2
let someValue = matrix[1,1]
print(someValue)


// 继承
class Vehicle{
    var currentSpeed = 0.0
    var description: String{
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someValue.description)")

class Bicycle: Vehicle{
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

// 重写
class Train: Vehicle{
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()

class Car: Vehicle{
    var gear = 1
    override var description: String{
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

// 重写属性的监听方法
class AutomaticCar: Car{
    override var currentSpeed: Double{
        didSet{
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")

// 防止重写，可以使用 final关键字修饰

// 初始化

struct Fahrenheit{
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature)ø Fahrenheit")

// 初始化属性值
struct Celsius{
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
// 两个自定义初始化方法
let boilingPointOfWater = Celsius.init(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius.init(fromKelvin: 273.15)





