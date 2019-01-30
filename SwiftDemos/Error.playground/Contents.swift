import UIKit

var str = "Hello, playground"

enum VendingMachineError: Error{
    case invalidSelection
    case insufficientFunds(coninsNeeded: Int)
    case outOfStock
}

struct Item{
    var price: Int
    var count: Int
}

class VendingMachine{
    var inventory = [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips" : Item(price: 10, count: 4),
        "Pretzels" : Item(price: 7, count: 11),
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coninsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice" : "Chips",
    "Bob" : "Licorice",
    "Eve" : "Pretzels",
]

// try会继续传播错误
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws{
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack{
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
}catch VendingMachineError.outOfStock {
    print("Out of Stock.")
}catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}catch{
    print("Unexpected error: \(error).")
}

func nourish(with item: String) throws{
    // 如果是VendingMachineError错误就在打印处理，如果是其他错误，就抛到下一层
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("xx")
    }
}

do {
    try nourish(with: "Brr")
} catch {
    print("unexpected xx")
}

// 错误可选类型
func someThrowingFunction() throws -> Int {
    return 1
}
// 如果有值就返回
let x = try? someThrowingFunction()

// 等价于
var y: Int?
do {
   y = try someThrowingFunction()
} catch {
   y = nil
}

// try! 在确定不会有错误产生时使用

// defer调整代码执行顺序,所有代码执行完之后再执行
// 第一个defer最后执行，第二个defer倒数第二执行

// 疑问，异步代码执行完成之后，是不是也可以？
func processFile(filename: String) throws{
    defer {
        print("defer")
    }
    print("123")
}
try processFile(filename: "1")


// MARK 类型检查
class MediaItem{
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem{
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem{
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie.init(name: "Cas", director: "MC"),
    Song.init(name: "BSS", artist: "EP"),
    Movie.init(name: "CK", director: "OW"),
    Song.init(name: "TOAO", artist: "CH"),
    Song.init(name: "NGGYU", artist: "RA")
]
// is 检查类型
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    }else{
        songCount += 1
    }
}

print("movie \(movieCount) song \(songCount)")

// 类型转换，转换结果是optional

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    }else if let song = item as? Song{
        print("Song: \(song.name), by \(song.artist)")
    }
}

// Any 表示任何类型的实例，包括函数类型
// AnyObject 可以表示任何类类型的实例

var things = [Any]()
things.append(0)
things.append("hello")
things.append((2,3))
things.append(Movie.init(name: "HX", director: "xx"))
things.append({(name: String) -> String in "hello, \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an int")
    case 0 as Double:
        print("zero as an int")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I dont want")
    case let somtSr as String:
        print("sting \(somtSr)")
    case let (x, y) as (Int, Int):
        print("an (x, y) point at \(x),\(y)")
    case let movie as Movie:
        print("movie \(movie.name)")
    case let stringFun as (String) -> String:
        print(stringFun("MC"))
    default:
        print("something else")
    }
}

let optionalNumber: Int? = 3
things.append(optionalNumber as Any)
things.append(optionalNumber as Any)






