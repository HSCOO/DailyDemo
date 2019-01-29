import UIKit

var str = "Hello, playground"

// 可选链
//class Residence{
//    var numberOfRooms = 1
//
//}

//if let roomCount = john.residence?.numberOfRooms {
//    print("John's residence has \(roomCount) rooms.")
//}else{
//    print("Unable to retrieve the number of rooms")
//}
//john.residence = Residence()
//if let roomCount = john.residence?.numberOfRooms {
//    print("John's residence has \(roomCount) rooms.")
//}else{
//    print("Unable to retrieve the number of rooms")
//}

class Residence{
    var rooms = [Room]()
    var numberOfRooms: Int{
        return rooms.count
    }
    subscript(i: Int) -> Room{
        get{
            return rooms[i]
        }
        set{
            rooms[i] = newValue
        }
    }
    func printNumbersOfRooms() {
        print("The number of room is \(numberOfRooms)")
    }
    var address: Address?
    
}

class Room{
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber,let street = street {
            return "\(buildingNumber) \(street)"
        }else if buildingName != nil{
            return buildingName
        }else{
            return nil
        }
    }
}

class Person{
    var residence: Residence?
}

let john = Person()

//if let roomCount = john.residence?.numberOfRooms {
//    print("John's residence has \(roomCount) rooms.")
//}else{
//    print("Unable to retrieve the number of rooms")
//}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) rooms.")
}else{
    print("Unable to retrieve the number of rooms")
}

func createAddress() -> Address{
    print("Func was called")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
// 因为residence可选值为空，所以后续方法不会调用
john.residence?.address = createAddress()
print(john.residence ?? "nil")

// 判断方法是否调用成功，printNumbersOfRooms返回值则是 void？
if john.residence?.printNumbersOfRooms() != nil {
    print("It was possible to print the number of rooms.")
}else{
    print("It was not possible to print the number of rooms.")
}

// 比较两个对象
if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
}else{
    print("It was not possible to set the address.")
}

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
}else{
    print("Unable to retrieve the first room name.")
}
john.residence?[0] = Room(name:"Bathroom")

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name:"Living Room"))
johnsHouse.rooms.append(Room(name:"Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName)")
}else{
    print("Unable to retrieve the first room name.")
}

var testScores = ["Dave":[86,82,84], "Bev": [79,94,81]]
testScores["Dave"]?[0] = 90
testScores["Dave"]?[0] += 1
testScores["Brian"]?[0] = 72
print(testScores)

