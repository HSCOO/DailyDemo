import UIKit

var str = "Hello, playground"

var names = ["Chris","Alex","Ewa","Barry","Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool{
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)

reversedNames = names.sorted(by: {(s1:String, s2:String) -> Bool in
    return s1 < s2
})
print(reversedNames)

// 根据上下文推断数据类型
reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})
// 省略return
reversedNames = names.sorted(by: {s1, s2 in s1 > s2})
//
reversedNames = names.sorted(by: { $0 > $1})
print(reversedNames)
// 只用比较符号即可
reversedNames = names.sorted(by: >)


// 尾随闭包·
func someFunctionThatTakesAClosure(closure: () -> Void) {
    
}
// 可以这样调用
someFunctionThatTakesAClosure(closure: {
    
})
// 简写
someFunctionThatTakesAClosure {
    
}

var reversedNamesJ = names.sorted(){ $0 > $1}
print(reversedNamesJ)
reversedNamesJ = names.sorted{$0 > $1}
print(reversedNamesJ)

// 尾随闭包的map用法
let digitNames = [
    0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",
    5:"Five",6:"Six",7:"Seven",8:"Six",9:"Nine"
]
let numbers = [16,58,510]





