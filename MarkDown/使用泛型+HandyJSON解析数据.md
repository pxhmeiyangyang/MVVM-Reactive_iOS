# MVVM+ReactiveCocoa+Swift4.0 iOS项目学习实践(3)

##使用泛型+HandyJSON便捷解析数据模型
##一、swift json数据解析
1、将网络数据转化为json，推荐使用[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
官网使用示例如下：
示例1：
```
let json = JSON(data: dataFromNetworking)
if let userName = json[0]["user"]["name"].string {
  //Now you got your value
}
```
示例2：
```
let json = JSON(data: dataFromNetworking)
if let userName = json[999999]["wrong_key"]["wrong_name"].string {
    //Calm down, take it easy, the ".string" property still produces the correct Optional String type with safety
} else {
    //Print the error
    print(json[999999]["wrong_key"]["wrong_name"])
}
```
2、json到数据模型的解析，推荐使用[HandyJSON](https://github.com/alibaba/HandyJSON)和[ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
2.1、HandyJSON官方使用示例：
```
class BasicTypes: HandyJSON {
    var int: Int = 2
    var doubleOptional: Double?
    var stringImplicitlyUnwrapped: String!

    required init() {}
}

let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
if let object = BasicTypes.deserialize(from: jsonString) {
    // …
}
```
2.2、ObjectMapper官方使用示例：
```
class User: Mappable {
    var username: String?
    var age: Int?
    var weight: Double!
    var array: [Any]?
    var dictionary: [String : Any] = [:]
    var bestFriend: User?                       // Nested User object
    var friends: [User]?                        // Array of Users
    var birthday: Date?

    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        array       <- map["arr"]
        dictionary  <- map["dict"]
        bestFriend  <- map["best_friend"]
        friends     <- map["friends"]
        birthday    <- (map["birthday"], DateTransform())
    }
}

struct Temperature: Mappable {
    var celsius: Double?
    var fahrenheit: Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        celsius 	<- map["celsius"]
        fahrenheit 	<- map["fahrenheit"]
    }
}
```
两个库本身都是十分便捷的库，本身无优劣之分，但针对我们的工程推荐使用HandyJSON，理由如下：
1、两个解析库都需要继承对应的协议，但HandyJSON不需要以固定的类型初始化对象，对代码的侵入性更少，解析过程简便代码量也有减少。
2、在ReactiveCocoa中所有的数据模型都要声明为@objc类型，所以要集成与NSObject，而ObjectMapper要继承于Mappable
##二、使用泛型便捷解析网络数据