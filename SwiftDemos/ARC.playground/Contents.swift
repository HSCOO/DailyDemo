import UIKit

var str = "Hello, playground"

// 默认强引用
// 解决循环引用,两种方式，weak、unowned

// 会置为nil的使用弱引用weak
// 初始化后不会被赋值为nil的实例，使用无主引用unowned

// 无主引用和隐式展开
// 一旦初始化完成，两个属性都能被直接访问，同时避免了循环引用
class Country{
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City.init(name: capitalName, country: self)
    }
}

class City{
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country.init(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")

//MARK: 闭包的循环强引用
class HTMLELement{
    let name: String
    let text: String?
    // 闭包作为属性，同时内部引用了self。
    // self 持有闭包属性，闭包 又持有self，循环引用
    lazy var asHTML: () -> String = {
        
        // 捕获列表
        [unowned self] in
        
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else{
            return "<\(self.name)/>"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("deinitialized")
    }
}

var paragraph:HTMLELement? = HTMLELement.init(name: "p", text: "hello,world")
print(paragraph?.asHTML() ?? "none")
paragraph = nil


// 解决闭包的循环引用需要用到捕获列表
//lazy var someClosure: (Int, String) -> String = {
//    [unowned self, weak delegate = self.delegate!] (index: Int, str: String) -> String in
//    //
//}

