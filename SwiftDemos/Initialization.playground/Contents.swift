import UIKit

var str = "Hello, playground"

// 有标签参数的初始化
struct Color{
    let red, green, blue: Double
    init(red: Double, green: Double,blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color.init(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color.init(white: 0.5)

let vertGreen = Color.init(red: 0.0, green: 1.0, blue: 0.0)

// 没有标签参数的初始化
struct Celsius{
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = Celsius.init(37.0)

// optional属性的值，初始化的时候，可以不用赋值
class SuryQuestion{
    
    // let text: String
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask(){
        print(text)
    }
}

let cheeseQuestion = SuryQuestion.init(text: "Do you like cheese.")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."

// 默认值
class ShoppingListItem{
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()


// 结构体自带有初始化方法
struct Size{
    var width = 0.0, height = 0.0
}
let twoByTwo = Size.init(width: 2.0, height: 2.0)

class Vehicle{
    var numberOfWheels = 0
    var description: String{
        return "\(numberOfWheels) wheels"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle{
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard2: Vehicle{
    var color: String
    // 隐式调用super.init()
    init(color: String) {
        self.color = color
    }
    // 重写description
    override var description: String{
        return "\(super.description) in a beautiful \(color)"
    }
}

let hoverboard = Hoverboard2.init(color: "silver")
print("Hoverboard: \(hoverboard.description)")

class Food{
    var name: String
    init(name: String) {
        self.name = name
    }
    //便利初始化方法，重写便利初始化方法需要添加convenience前缀
    convenience init(){
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food.init(name: "Bacon")
let mysteryMeat = Food()

// 重写父类的初始化方法
class RecipeIngredient: Food{
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
//    override convenience init(name: String) {
//        self.init(name: name, quantity: 1)
//    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
//let oneBacon = RecipeIngredient.init(name: "Bacon")
let sixEggs = RecipeIngredient.init(name: "Eggs", quantity: 6)

// 初始化方法全部继承自父类
class ShoppingListItem2: RecipeIngredient{
    var purchased = false
    var description: String{
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem2(),
    ShoppingListItem2.init(name: "Bacon"),
    ShoppingListItem2.init(name: "Eggs", quantity: 6)
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

// 初始化失败
let wholeNumber: Double = 12345.0
let pi = 3.14159
// 转换类型
if let valueMaintained = Int(exactly: wholeNumber){
    print("\(wholeNumber) conversion to Int \(valueMaintained)")
}

let valueChanged = Int(exactly: pi)
if valueChanged == nil{
    print("\(pi) conversion to Int does not maintain value")
}


// 初始化optional，可能会失败
struct Animal{
    let species: String
    init?(species: String) {
        if species.isEmpty {return nil}
        self.species = species
    }
}

let someCreature = Animal.init(species: "Giraffe")
if let giraffe = someCreature{
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal.init(species: "")
if anonymousCreature == nil{
    print("The anonymous creature could not be initialized")
}

enum TemperatureUnit{
    case kelvin, celsius, fahrenheit
    init?(symbol: Character){
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit.init(symbol: "F")
if fahrenheitUnit != nil{
    print("This is a defined temperature unit, so ini")
}

// 也可以利用枚举本身的值来判断是否初始化成功
enum TemperatureUnit2: Character{
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}
let fahrenheitUnit2 = TemperatureUnit2.init(rawValue: "F")
if fahrenheitUnit2 != nil{
    print("This is a defined temperature unit, so succeeded.")
}

let unknowUnit2 = TemperatureUnit2.init(rawValue: "X")
if unknowUnit2 == nil{
    print("This is not a defined temperature unit, so failed")
}

class Product{
    let name: String
    init?(name: String) {
        if name.isEmpty{ return nil}
        self.name = name
    }
}

class CartItem: Product{
    let quantity: Int
    init?(name: String, quantity: Int){
        if quantity < 1 { return nil}
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem.init(name: "sock", quantity: 2){
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// 初始化失败
if let zeroShirts = CartItem.init(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
}else{
    print("Unable to init zero shirts")
}
// 父类初始化方法失败
if let oneUnnamed = CartItem.init(name: "", quantity: 1){
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
}else{
    print("Unable to initialize one unnamed product")
}

class Document{
    var name: String?
    init() {}
    init?(name: String) {
        if name.isEmpty {return nil}
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document{
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty{
            self.name = "[Untitled]"
        }else{
            self.name = name
        }
    }
}

let aut0 = AutomaticallyNamedDocument.init(name: "")

class SomeClass{
    required init(){
        
    }
}

class SomeSubclass: SomeClass{
    required init() {
        
    }
}

// 使用闭包或函数设置默认属性值
struct Chessboard{
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8{
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))

// 释放
class Bank{
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int{
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receive(coins: Int){
        coinsInBank += coins
    }
}

class Player{
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int){
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse)")

print("left \(Bank.coinsInBank)")

playerOne = nil
print("The bank now has \(Bank.coinsInBank) coins")



