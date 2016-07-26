#!/usr/bin/env xcrun swift
//swift2.2

print("hello swift!")

print("----------------------- base")
// 变量
var myInt = 20
// let 常量
let myConst = 30
let explicitDouble: Double = 70
print(myInt)
print(myConst)


let label = "The width is "
let width = 94
let widthLabel = label + String(width)
print(widthLabel)


let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
print(appleSummary)
print(fruitSummary)

// 数组
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
print(shoppingList)

// 清空
shoppingList = []
//字典
var occupations = [
	"Malcolm": "Captain",
	"Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
print(occupations)
occupations = [:]
print(shoppingList)

print("----------------------- if let")
// 在类型后加个问号来标记这个变量的值是可选的(加？后初始化为nil)
var optionalString: String? = "Hello"
print(optionalString == nil)
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
	greeting = "Hello, \(name)"
}
print(greeting)


print("----------------------- switch")
let vegetable = "watercress"
var vegetableComment: String?
print(vegetableComment)
switch vegetable {
	case "celery":
		vegetableComment = "Add some raisins and make ants on a log."
	case "cucumber", "watercress":
		vegetableComment = "That would make a good tea sandwich."
	default:
		vegetableComment = "Everything tastes good in soup."
}
print(vegetableComment)


print("----------------------- for-in")
let interestingNumbers = [
	"Prime": [2, 3, 5, 7, 11, 13],
	"Fibonacci": [1, 1, 2, 3, 5, 8],
	"Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
	for number in numbers {
		if number > largest {
			largest = number
		}
	}
}
print(largest)
for i in 3..<5{
	largest += i;
}
print(largest)

print("----------------------- while ")
var n = 2
while n < 100{
	n = n * 2
}
print(n)

print("----------------------- func ")
func greet(name: String, day: String) -> String {
	return "Hello \(name), today is \(day)."
}
print(greet("Bob", day:"Tuesday"))



print("----------------------- func2 ")
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
	var min = scores[0]
	var max = scores[0]
	var sum = 0
	for score in scores {
		if score > max {
			max = score
		}
		else if score < min {
			min = score
		}
		sum += score
	}
	return (min, max, sum)
}
let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics)
print(statistics.0)
print(statistics.sum)


print("----------------------- func var_parm ")
func sumOf(numbers: Int...) -> Int {
	var sum = 0
	for number in numbers {
		sum += number
	}
	return sum
}
print(sumOf())
print(sumOf(1, 2, 3))

print("----------------------- func parm ")
func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
	for item in list {
		if condition(item) {
			return true
		}
	}
	return false
}
func lessThanTen(number: Int) -> Bool {
	return number < 10
}
var numbers = [20, 19, 7, 12]
print(hasAnyMatches(numbers, condition: lessThanTen))


print("----------------------- class ")
class NamedShape {
	var numberOfSides: Int = 0 { 
		//willSet和didSet监视器
		willSet(newNumberOfSides) { 
		    print("About to set newNumberOfSides to \(newNumberOfSides)") 
		} 
		didSet { 
		    if numberOfSides > oldValue  { 
		        print("Added \(numberOfSides - oldValue) number") 
		    } 
		} 
	}
	var name: String
	init(name: String) {
		self.name = name
	}
	func simpleDescription() -> String {
		return "A shape: \(name) with \(numberOfSides) sides."
	}
}
var shape = NamedShape(name:"abc")
shape.numberOfSides = 7
print(shape.simpleDescription())

print("----------------------- class inheritance")
// 继承
class Square: NamedShape {
	var sideLength: Double
	init(sideLength: Double, name: String) {
		self.sideLength = sideLength
		super.init(name: name)
		numberOfSides = 4
	} 
	func area() -> Double {
		return sideLength * sideLength
	} 
	// 重载需要override 标记
	override func simpleDescription() -> String {
		return super.simpleDescription()+",with sides of length \(sideLength)"
		// return "A square with sides of length \(sideLength)."
	}
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
print(test.simpleDescription())



print("----------------------- enum")
enum Rank: Int {
	case Ace = 1
	case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
	case Jack, Queen, King
	func simpleDescription() -> String {
		switch self {
			case .Ace:
				return "this is ace"
			case .Jack:
				return "this is jack"
			case .Queen:
				return "this is queen"
			case .King:
				return "this is king"
			default:
				return String(self.rawValue)
		}
	}	
}
let ace = Rank.Ace
print(ace)
print(ace.rawValue)
print(ace.simpleDescription())

if let convertedRank = Rank(rawValue: 11) {
	print(convertedRank.simpleDescription())
}


print("----------------------- struct")
// 区别就是结构体是传值， 类是传引
struct Card {
	var rank: Rank
	func simpleDescription() -> String {
		return "The \(rank.simpleDescription())"
	}
}
let threeOfSpades = Card(rank: .King)
print(threeOfSpades.simpleDescription())


print("----------------------- protocol")
protocol ExampleProtocol {
	var simpleDescription: String { get }
	mutating func adjust()
}
// 类、 枚举和结构体都可以实现协议
class SimpleClass: ExampleProtocol {
	var simpleDescription: String = "A very simple class."
	var anotherProperty: Int = 69105
	// 在 class 中实现带有mutating方法的接口时，不用mutating进行修饰。
	// 因为对于class来说，类的成员变量和方法都是透明的，所以不必使用 mutating 来进行修饰
	// 枚举和结构体需要mutating func adjust()
	func adjust() {
		simpleDescription += " Now 100% adjusted."
	}
}
var a = SimpleClass()
a.adjust()
print(a.simpleDescription)

print("----------------------- extension")
 // extension 来为现有的类型添加功能(扩展)
extension Int: ExampleProtocol {
	var simpleDescription: String {
		return "The number \(self)"
	}
	mutating func adjust() {
		self += 42
	}
}
var exInt = 10
exInt.adjust()
print(exInt.simpleDescription)


print("----------------------- 泛型")
// 函数、 函数、 类、 枚举和结构体
// 在尖括号写个名字来创建个泛型函数或者类型
func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item] {
	var result = [Item]()
	for _ in 0..<numberOfTimes {
		result.append(item)
	}
	return result
}
print(repeatItem("knock", numberOfTimes:4))




// 运行结果：
// hello swift!
// ----------------------- base
// 20
// 30
// The width is 94
// I have 3 apples.
// I have 8 pieces of fruit.
// ["catfish", "bottle of water", "tulips", "blue paint"]
// ["Malcolm": "Captain", "Kaylee": "Mechanic", "Jayne": "Public Relations"]
// []
// ----------------------- if let
// false
// Hello, John Appleseed
// ----------------------- switch
// nil
// Optional("That would make a good tea sandwich.")
// ----------------------- for-in
// 25
// 32
// ----------------------- while 
// 128
// ----------------------- func 
// Hello Bob, today is Tuesday.
// ----------------------- func2 
// (3, 100, 120)
// 3
// 120
// ----------------------- func var_parm 
// 0
// 6
// ----------------------- func parm 
// true
// ----------------------- class 
// About to set newNumberOfSides to 7
// Added 7 number
// A shape: abc with 7 sides.
// ----------------------- class inheritance
// About to set newNumberOfSides to 4
// Added 4 number
// A shape: my test square with 4 sides.,with sides of length 5.2
// ----------------------- enum
// Ace
// 1
// this is ace
// this is jack
// ----------------------- struct
// The this is king
// ----------------------- protocol
// A very simple class. Now 100% adjusted.
// ----------------------- extension
// The number 52
// ----------------------- 泛型
// ["knock", "knock", "knock", "knock"]


