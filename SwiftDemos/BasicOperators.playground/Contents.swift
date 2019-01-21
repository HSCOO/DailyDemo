import UIKit

var str = "Hello, playground"

// 元组比较，是依次按照元素比较，字符串是按照一个个字符来比较的
(1,"zebra") < (2,"apple")
(3,"apple") > (3, "bird")

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 3 : 4)

// 字符串初始化
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("Nothing to see here")
}

// 字符串拼接
var variableString = "Horse"
variableString += " add carriage"

// 初始化字符数组
let catCharacters: [Character] = ["C","a","t","!","🐱"]
let catString = String(catCharacters)
print(catString)

let greeting = "Guten Tag!"
// 获取第一个字符
greeting[greeting.startIndex]
greeting[greeting.index(before:greeting.endIndex)]

let index = greeting.index(after: greeting.startIndex)
greeting[index]
print(index)

// 从第一个字符开始，第7个
let eIndex = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[eIndex]

// aBeginning 是aGreeting的子字符串，依然占用的是aGreeting的内存
let aGreeting = "Hello,world!"
let aIndex = aGreeting.firstIndex(of: ",") ?? aGreeting.endIndex
let aBeginning = aGreeting[..<aIndex]
print(aGreeting)
print(aBeginning)

// 数组的创建
var threeDoubles = Array.init(repeating: 0.0, count: 3)
var anotherThreeDoubles = Array.init(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles

// 集合的创建
var favoriteGenres: Set<String> = ["Rock","Classical","Hip hop"]
for genre in favoriteGenres.sorted() {
    print(genre)
}

// 字典的创建
var nameOfIntegers = [Int: String]()
nameOfIntegers[16] = "sixteen"

var square = 0

while square < 5 {
    print(square)
    square += 1
}
print("over \(square)")

var ee = 0
repeat{
    print(ee)
    ee += 1
}while ee < 5

print("over \(ee)")

// 多个值匹配
let anotherCharacter:Character = "a"
switch anotherCharacter {
case "a","A":
    print("The letter A")
default:
    print("Not the letter A")
}

// 区间匹配

let approximateCount = 62
let countedTings = "moons orbiting Saturn"
var natualCount:String = ""
switch approximateCount {
case 0:
    natualCount = "no"
case 1..<5:
    natualCount = "a few"
case 5..<12:
    natualCount = "several"
case 12..<100:
    natualCount = "dozens of"
default:
    natualCount = "many"
}
print("\(natualCount)")




























