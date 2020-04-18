# SwiftUIPractice
实践SwiftUI及Combine

# Swift

## 数据转模型

 JSON解析及格式化验证：https://www.json.cn/

 JSON 2 swift：[http://www.jsoncafe.com](http://www.jsoncafe.com/)

## JSON数据处理：JSONDecoder

1. 遵循Codable

2. 如果遇到嵌套的情况则通过在struct里再套一个struct

3.  对于有时不会返回的字段设置为optional类型

4. 不同代码风格通过CodingKeys映射的方式实现对不同代码风格的兼容

   ```
   enum CodingKeys: String, CodingKey {
   	case list = "list"
   }
   ```

5.  JSONDecoder的keyDecodingStategy属性：useDefaultKeys、convertFromSnakeCase、custom

## 国际化与本地化

### 本地化字符串

1. 项目配置 -> “Info” -> “Localizations”区域下，可以看到工程默认只支持英文，我们可以再添加中文语言。

2. 在工程中，右键添加文件（New File...），选择Resource下的Strings File文件类型，文件名定义为“Localizable.strings”。

3. 选中刚创建的“Localicable.strings”文件，在右侧属性面板中点击“Localize...”创建本地化资源。

4. 分别在英文和中文资源下，输入如下键值对。

5. 使用NSLocalizedString函数来访问Localizable.strings资源文件。NSLocalizedString函数第一个参数为对应的键名，第二个是自定义的说明，给开发或翻译人员看的。

   ```objective-c
   myLabel.text = NSLocalizedString("Welcome", comment: "Welcome")
   ```

   也可以用三方库R.Swift 。

   ```swift
   Text(R.string.localizable.welcome())
   ```

### 本地化图片

1. 选中需要本地化的图片，同上面一样点击“Localize...”创建本地化图片资源。
2. 打开工程目录，可以看到在中文资源和英文资源下都有这个图片，把需要替换的图片替换掉。
3. 图片使用同平时一样

### **应用名称的本地化** 

1. 要实现应用名称根据语言环境显示不一样的名称，只需创建InfoPlist.strings文件，并像上面一样实现本地化资源。
2. 分别在英文和中文InfoPlist.strings文件中定义CFBundleDisplayName值。

```properties
//英文资源里
"CFBundleDisplayName" = "SWiftUIPractice";
 
//中文资源里
"CFBundleDisplayName" = "SWiftUI实战";
```

### **Xcode中切换语言** 

为了调试国际化，我们除了可以进入模拟器或真机里切换系统语言。也可以在Xcode中配置相关项，使Debug运行时预览不同语言和地区APP的界面效果。

1. 选择“Product” -> “Scheme” -> “Edit Scheme...”。
2. 切换语言后运行工程：Application Language -->Chinese(Simplified)

## 三方库

### 优雅地使用资源 - R.Swift 

https://github.com/mac-cain13/R.swift 

Get strong typed, autocompleted resources like images, fonts and segues in Swift projects. 

1. 每当项目build时，R.swift开始运行。
2. 这个文件根据项目里的资源文件自动在 R.generated.swift 文件中按照类型生成结构体 。
3. 强类型,无需类型判断和转换,自动返回对应类型。
4. 支持多种资源类型。
5. 自动完成,无需猜测图像名称,避免资源名称拼写错误 。

#### R.Swift 集成

1. 在当前项目的 targets 中选择 Build phrase,点击+号选择添加 New Run Script Phase。 
2. 将 Run Script 移动至 Compile sources 之上, Check Pods Manifest.lock 之下。在 Run Script 中添加:"$PODS_ROOT/R.swift/rswift" “$SRCROOT"。 
3. 编译你的项目,在 Finder 中你会看到 R.generated.swift 在工程中,将该文件拖动至项目中,切记 千万不要勾选 Copy items if needed。 

# Combine

## Publisher 和常 见 Operator 

### 基础 **Publisher** 和 **Operator**

#### zip

```swift
let subject1 = PassthroughSubject<Int, Never>()
let subject2 = PassthroughSubject<String, Never>()

check("Zip") {
    subject1.zip(subject2)
}

subject1.send(1)
subject2.send("A")
subject1.send(2)
subject2.send("B")
subject2.send("C")
subject2.send("D")
subject1.send(3)
subject1.send(4)
subject1.send(5)
```

```swift
----- Zip -----
receive subscription: (Zip)
request unlimited

receive value: ((1, "A"))
receive value: ((2, "B"))
receive value: ((3, "C"))
receive value: ((4, "D"))
receive cancel
```

#### combineLatest

```swift
let subject3 = PassthroughSubject<Int, Never>()
let subject4 = PassthroughSubject<String, Never>()

check("Combine Latest") {
    subject3.combineLatest(subject4)
}

subject3.send(1)
subject4.send("A")
subject3.send(2)
subject4.send("B")
subject4.send("C")
subject4.send("D")
subject3.send(3)
subject3.send(4)
subject3.send(5)
```

```
----- Combine Latest -----
receive subscription: (CombineLatest)
request unlimited

receive value: ((1, "A"))
receive value: ((2, "A"))
receive value: ((2, "B"))
receive value: ((2, "C"))
receive value: ((2, "D"))
receive value: ((3, "D"))
receive value: ((4, "D"))
receive value: ((5, "D"))
receive cancel
```

#### merge

```swift
let subject_example1 = PassthroughSubject<Int, Never>()
let subject_example2 = PassthroughSubject<Int, Never>()

check("Subject Order") {
    subject_example1.merge(with: subject_example2)
}

subject_example1.send(20)
subject_example2.send(1)
subject_example1.send(40)
subject_example1.send(60)
subject_example2.send(1)
subject_example1.send(80)
subject_example1.send(100)
subject_example1.send(completion: .finished)
subject_example2.send(completion: .finished)
```

```
----- Subject Order -----
receive subscription: (Merge)
request unlimited

receive value: (20)
receive value: (1)
receive value: (40)
receive value: (60)
receive value: (1)
receive value: (80)
receive value: (100)
receive finished
```

#### delay

```swift
let s1 = check("Subject") {
    () -> PassthroughSubject<Int, Never> in
    let subject = PassthroughSubject<Int, Never>()
    delay(1) {
        subject.send(1)
        delay(1) {
            subject.send(2)
            delay(1) {
                subject.send(completion: .finished)
            }
        }
    }
    return subject
}
```

```
----- Subject -----
receive subscription: (PassthroughSubject)
request unlimited

receive value: (1)
receive value: (2)
receive finished
```

#### debounce(防抖)

网络请求、I/O读写或是复杂渲染等都是很耗费资源的操作，对于这类操作，我们希望尽可能少发生。

debounce又叫做“防抖”：Publisher在接收到第一个值后，并不不是立即将它发布出去，而是会开启一个内部计时器，当一定时间内没有新的事件来到，再将这个值进行发布。如果在计时器间有新的事件，则重置计时器并重复上述等待过程。

```swift
import Combine
import Foundation

let searchText = PassthroughSubject<String, Never>()

var temp = check("Debounce") {
    searchText
        .debounce(for: .seconds(1), scheduler: RunLoop.main)
}

delay(0) { searchText.send("S") }
delay(0.1) { searchText.send("Sw") }
delay(0.2) { searchText.send("Swi") }
delay(1.3) { searchText.send("Swif") }
delay(1.4) { searchText.send("Swift") }
```

```
----- Debounce -----
receive subscription: (Debounce)
request unlimited

receive value: (Swi)
receive value: (Swift)
```

#### throttle（节流）

在指定的时间间隔内发布上游发布者发布的最新元素或第一个元素。

它在收到一个事件后开始计时，并忽略计时周期内的后续输入。

```swift
let searchText = PassthroughSubject<String, Never>()

var temp = check("Debounce") {
    searchText
        .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
}

delay(0) { searchText.send("S") }
delay(0.1) { searchText.send("Sw") }
delay(0.2) { searchText.send("Swi") }
delay(1.3) { searchText.send("Swif") }
delay(1.4) { searchText.send("Swift") }
```

```
----- Debounce -----
receive subscription: (Throttle)
request unlimited

receive value: (S)
receive value: (Swi)
receive value: (Swift)
```



### 错误处理

#### 转换错误类型 -mapError

map 对 Output 进行转换，mapError 对 Failure 进行转换，就是这么简单。 

#### 抛出错误

Combine 为 Publisher 的 map 操作提供了一个可以抛出错误的版本，tryMap。使用 tryMap 我们就可以将这类处理数据时发生的错误转变为标志事件流失败的结束事 件: 

```swift
check("Throw") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { s -> Int in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
        }
}
```

除了 tryMap 以外，Combine 中还有很多类似的以 try 开头的 Operator，比如 tryScan，tryFilter，tryReduce 等等。当你有需求在数据转换或者处理时，将事件 流以错误进行终止，都可以使用对应操作的 try 版本来进行抛出，并在订阅者一侧接 收到对应的错误事件。 

#### 从错误中恢复 

在 Combine 里，有一些 Operator 是专门帮助事件流从错误中恢复的，最简单的是 replaceError，它会把错误替换成一个给定的值，并且立即发送 finished 事件: 

```swift
check("Replace Error") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { s -> Int in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
        }
        .replaceError(with: -1)
}
```

如果我们想要在事件流以错误结束时被转为一个默认值的话，replaceError 就会很 有用。replaceError 会将 Publisher 的 Failure 类型抹为 Never，这正是我们使用 assign 来将 Publisher 绑定到 UI 上时所需要的 Failure 类型。我们可以用 replaceError 来提供这样一个在出现错误时应该显示的默认值。 

replaceError 在错误时接受单个值，另一个操作 catch 则略有不同，它接受的是一 个新的 Publisher，当上游 Publisher 发生错误时，catch 操作会使用新的 Publisher 来把原来的 Publisher 替换掉。举个例子: 

```swift
check("Catch with Just") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { s -> Int in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
        }
        .catch { _ in Just(-1) }
}
```

如果我们将 (由 ["1", "2", "Swift", "4"] 构成的) 原 Publisher 看作是用户输入，将结 果的 Int 看作是最后输出，那么像上面那样的方式使用 replaceError 或者 catch 的 话，一旦用户输入了不能转为 Int 的非法值 (如 “Swift”)，整个结果将永远停在我们 给定的默认恢复值上，接下来的任意用户输入都将被完全忽略。这往往不是我们想 要的结果，一般情况下，我们会想要后续的用户输入也能继续驱动输出，这时候我们 可以靠组合一些 Operator 来完成所需的逻辑: 

```swift
check("Catch and Continue") {
    ["1", "2", "Swift", "4"].publisher
        .print("[Original]")
        .flatMap { s in
            return Just(s)
                .tryMap { s -> Int in
                    guard let value = Int(s) else {
                        throw MyError.myError
                    }
                    return value
                }
                .print("[TryMap]")
                .catch { _ in
                    Just(-1).print("[Just]") }
                .print("[Catch]")
        }
}
```



### **Publisher** 的类型系统

#### 嵌套的泛型类型和类型抹消

eraseToAnyPublisher 

#### 操作符熔合 

将操作符的作用时机提前到创建 Publisher 时的方式，被称为操作符熔合 (operator fusion)。 

## 响应式编程边界

### 响应式和指令式的桥梁

#### Future

```swift
import Combine
import Foundation

var cancellables = Set<AnyCancellable>()

var cancellable = Future<(Data,URLResponse), Error> { promise in
    URLSession.shared.dataTask(with: URL(string: "https://example.com")!) { (data, response, error) in
        if let data = data, let response = response {
            promise(.success((data,response)))
        } else {
            promise(.failure(error!))
        }
    }.resume()
}
.print()
.sink(receiveCompletion: { _ in
    
}) { _ in
    
}
cancellables.insert(cancellable)
```

Future只能为我们提供一次性Publisher：对于提供的promise，你只有两种选择：发送一个值并让Publisher正常结束，或者发送一个错误。因此，Future只适用于那些必然会产生事件结果，且至多会产生一个结果的场景。比如刚才看到的网络请求：它要么成功并返回数据及响应，要么直接失败并给出URLError。一个dataTask的网络请求不会永远不发送任何事件，也不会产生多次的响应，用Future进行包装恰得其所。如果你的异步API有可能不发送任何一个值，而是可能发布两个或更多的值话，你会需要一个更加一般性的Publisher类型来把指令式程序转换为响应式程序，这个类型就是Subject。

#### Subject

相对于单次事件的网络请求，可以发布多次事件的操作在日常开发中更加常见：比如把每次由于TextField导致的键盘出现看作一次事件的话，一般情况下你并不能控制用户调出多少次键盘；再比如设定了某个计时器，希望间隔一秒反复调用某个方法，直到计时器被停止之前，对这个方法的调用也是一个重复的多次发生的事件。

```swift
import Combine
import Foundation

var cancellables = Set<AnyCancellable>()

let subject = PassthroughSubject<Date, Never>()
Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
    subject.send(Date())
}
var cancellable = subject
    .print()
    .sink(receiveCompletion: { _ in
        
    }) { _ in
        
}

cancellables.insert(cancellable)
```

##### PassthroughSubject

PassthroughSubject 在订阅时不产生值，并将之后的值进行传递。 

##### CurrentValueSubject

CurrentValueSubject 则在订阅时立即将上次的值发送给订阅者。 

### Foundation中的Publisher

#### URLSession Publisher

```swift
import Combine
import Foundation

struct Response: Decodable {
    struct Foo: Decodable {
        let foo: String
    }
    let args: Foo?
}

let input = PassthroughSubject<String, Error>()

let session = check("URL Session") {
    input.flatMap { text in
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://httpbin.org/get?foo=\(text)")!)
            .map { data, _ in data }
            .decode(type: Response.self, decoder: JSONDecoder())
            .compactMap { $0.args?.foo }
    }
}

input.send("hello")
input.send("world")
input.send(completion: .finished)
```

#### Timer Publisher

如果我们检查这个返回值的类型，会发现 Timer.TimerPublisher 是一个满足 ConnectablePublisher 的类型。ConnectablePublisher 不同于普通的 Publisher， 你需要明确地调用 connect() 方法，它才会开始发送事件: 

```swift
import Combine
import Foundation

let timer = Timer.publish(every: 1, on: .main, in: .default)
let temp = check("Timer Connected") {
    timer
}
timer.connect()
```

一个显而易见的问题是，既然我们需要调用 connect() 才能让事件开始发生，那当我 们不再关心这个事件流的时候，是不是应该本着资源使用的 “谁创建，谁释放” 的原 则，让这个事件流停止发送呢?答案是肯定的:connect() 会返回一个 Cancellable 值，我们需要在合适的时候调用 cancel() 来停止事件流并释放资源。同样地，对于 订阅来说，大多数情况下我们也需要及时取消，以保证内存不发生泄漏。 

#### Notification Publisher

### 订阅和绑定

#### 通过sink订阅Publisher事件

#### 通过assign绑定Publisher值

```swift
import Combine
import SwiftUI

class Clock {
    var timeString: String = "--:--:--" {
        didSet { print("\(timeString)") }
    }
}

let clock = Clock()

let formatter = DateFormatter()
formatter.timeStyle = .medium

let timer = Timer.publish(every: 1, on: .main, in: .default)
var token = timer
    .map { formatter.string(from: $0) }
    .assign(to: \.timeString, on: clock)

timer.connect()
```

#### Publisher的引用共享

将值语义的 dataTaskPublisher 转变为引用语义 (reference semantics)。我们只要在创建 dataTaskPublisher 后加上 share() 即可。 通过 share() 操作，原来的 Publisher 将被包装在 class 内，对它的进一步变形也会 适用引用语义: 

```swift
import Combine
import Foundation

class LoadingUI {
    var isSuccess: Bool = false
    var text: String = ""
}

struct Response: Decodable {
    struct Foo: Decodable {
        let foo: String
    }
    let args: Foo?
}

let dataTaskPublisher = URLSession.shared
    .dataTaskPublisher(for: URL(string: "https://httpbin.org/get?foo=bar")!)
    .share()

let isSuccess = dataTaskPublisher
    .map { data, response -> Bool in
        guard let httpRes = response as? HTTPURLResponse else {
            return false
        }
        return httpRes.statusCode == 200
    }
    .replaceError(with: false)

let latestText = dataTaskPublisher
    .map { data, _ in data }
    .decode(type: Response.self, decoder: JSONDecoder())
    .compactMap { $0.args?.foo }
    .replaceError(with: "")

let ui = LoadingUI()
var token1 = isSuccess.assign(to: \.isSuccess, on: ui)
var token2 = latestText.assign(to: \.text, on: ui)
```

对于多个 Subscriber 对应一个 Publisher 的情况，如果我们不想让订阅行为反复发 生 (比如上例中订阅时会发生网络请求)，而是想要共享这个 Publisher 的话，使用 share() 将它转变为引用类型的 class。

### Cancellable,AnyCancellable和内存管理

在上面 Timer 的案例中，对计时器的 Publisher 执行 connect() 后得到的结果是一个 满足 Cancellable 协议的对象;用 sink 或 assign 来订阅某个 Publisher 时，我们必 须要持有返回值才能让这个订阅正常工作，该返回值的类型为 AnyCancellable。 

#### Cancellable

上面的操作有一个共同的特点，那就是它们都要求随着时间流动，计时器或者订阅 要能继续响应和工作。这必然需要某种 “资源”，并持有它们，以保持自己在内存中 依然存在。对于 Cancellable，我们需要在合适的时候主动调用 cancel() 方法来完 结:比如停止 Timer 的继续计时。如果我们在没有调用 cancel() 的情况下就将 connect 的返回值忽略或者释放掉，那么我们就将永远无法停止这个 Timer，它会一 直计时，并造成内存泄漏。 

```swift
public protocol Cancellable {

    /// Cancel the activity.
    func cancel()
}
```

#### AnyCancellable

和 Cancellable 这个抽象的协议不同，AnyCancellable 是一个 class，这也赋予了它 对自身的生命周期进行管理的能力。对于一般的 Cancellable，例如 connect 的返回 值，我们需要显式地调用 cancel() 来停止活动，但 AnyCancellable 则在自己的 deinit 中帮我们做了这件事。换句话说，当 sink 或 assign 返回的 AnyCancellable 被释放时，它对应的订阅操作也将停止。在实际里，我们一般会把这个 AnyCancellable 设置为所在实例 (比如 UIViewController) 的存储属性。这样，当该 实例 deinit 时，AnyCancellable 的 deinit 也会被触发，并自动释放资源。如果你对 RxSwift 有了解的话，它的行为和 DisposeBag 很类似，为了操作简便，我们也完全 可以为 Combine 自定义一个类似的 DisposeBag 类型来管理内存释放。 

```swift
final public class AnyCancellable : Cancellable, Hashable {

    /// Initializes the cancellable object with the given cancel-time closure.
    ///
    /// - Parameter cancel: A closure that the `cancel()` method executes.
    public init(_ cancel: @escaping () -> Void)

    public init<C>(_ canceller: C) where C : Cancellable

    /// Cancel the activity.
    final public func cancel()

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    final public func hash(into hasher: inout Hasher)

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: AnyCancellable, rhs: AnyCancellable) -> Bool

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}
```

针对上面 Combine 中常见的内存资源相关的操作，可以总结几条常见的规则和实践: 

1. 对于需要 connect 的 Publisher，在 connect 后需要保存返回的 Cancellable， 

   并在合适的时候调用 cancel() 以结束事件的持续发布。 

2. 对于 sink 或 assign 的返回值，一般将其存储在实例的变量中，等待属性持有 者被释放时一同自动取消。不过，你也完全可以在不需要时提前释放这个变量 或者明确地调用 cancel() 以取消绑定。 

3. 对于 1 的情况，也完全可以将 Cancellable 作为参数传递给 AnyCancellable 的初始化方法，将它包装成为一个可以自动取消的对象。这样一来，1 将被转 换为 2 的情况。

# SwiftUI

## 数据状态和绑定

根据适用范围和存储 状态的复杂度的不同，需要选取合适的方案。@State 和 @Binding 提供 View 内部 的状态存储，它们应该是被标记为 private 的简单值类型，仅在内部使用。 ObservableObject 和 @ObservedObject 则针对跨越 View 层级的状态共享，它可以处理更复杂的数据类型，其引用类型的特点，也让我们需要在数据变化时通过某种 手段向外发送通知 (比如手动调用 objectWillChange.send() 或者使用 @Published)， 来触发界面刷新。对于 “跳跃式” 跨越多个 View 层级的状态，@EnvironmentObject 能让我们更方便地使用 ObservableObject，以达到简化代码的目的。 

如果你纠结于选择使用哪种方式的话，从 ObservableObject 开始入手会是一个相对好的选择:如果发现状态可以被限制在同一个 View 层级中， 则改用 @State;如果发现状态需要大批量共享，则改用 @EnvironmentObject。 

### @State

通过使用 @State 修饰器我们可以关联出 View 的状态. SwiftUI 将会把使用过 @State 修饰器的属性存储到一个特殊的内存区域，并且这个区域和 View struct 是隔离的. 当 @State 装饰过的属性发生了变化，SwiftUI 会根据新的属性值重新创建视图。

这个状态是属于单个 View 及其子层级，还是需要在平行的部件之间传递和使 用?@State 可以依靠 SwiftUI 框架完成 View 的自动订阅和刷新，但这是有 条件的:对于 @State 修饰的属性的访问，只能发生在 body 或者 body 所调 用的方法中。你不能在外部改变 @State 的值，它的所有相关操作和状态改变 都应该是和当前 View 挂钩的。如果你需要在多个 View 中共享数据，@State 可能不是很好的选择;如果还需要在 View 外部操作数据，那么 @State 甚至 就不是可选项了。 

###@Binding 

有时候我们会把一个视图的属性传至子节点中，但是又不能直接的传递给子节点，因为在 Swift 中值的传递形式是`值类型`传递方式，也就是传递给子节点的是一个拷贝过的值。但是通过 @Binding 修饰器修饰后，属性变成了一个`引用类型`，传递变成了引用传递，这样父子视图的状态就能关联起来了。

状态对应的数据结构是否足够简单?对于像是单个的Bool或者String， @State 可以迅速对应。含有少数几个成员变量的值类型，也许使用 @State 也还不错。但是对于更复杂的情况，例如含有很多属性和方法的类型，可能其 中只有很少几个属性需要触发 UI 更新，也可能各个属性之间彼此有关联，那 么我们应该选择引用类型和更灵活的可自定义方式。 

### @ObservedObject

@ObservedObject 的用处和 @State 非常相似，从名字看来它是来修饰一个对象的，这个对象可以给多个独立的 View 使用。如果你用 @ObservedObject 来修饰一个对象，那么那个对象必须要实现 ObservableObject 协议，然后用 @Published 修饰对象里属性，表示这个属性是需要被 SwiftUI 监听的。

ObservableObject 协议要求实现类型是 class，它只有一个需要实现的属性:objectWillChange。在数据将要发生改变时，这个属性用来向外进行 “广播”， 它的订阅者 (一般是 View 相关的逻辑) 在收到通知后，对 View 进行刷新。 

```swift
class CalculatorModel: ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    var brain: CalculatorBrain = .left("0") {
        willSet{
            objectWillChange.send()
        }
    }
    
}
```

### @EnvironmentObject

从名字上可以看出，这个修饰器是针对全局环境的。通过它，我们可以避免在初始 View 时创建 ObservableObject, 而是从环境中获取 ObservableObject

被标记为 @EnvironmentObject 的值进 行指定，它们会自动去查询 View 的 Environment 中是否有符合的类型的值，如果有 则使用它们，如没有则抛出运行时的错误。 

###@Environment

继续上面一段的说明，我们的确开一个从 Environment 拿到用户自定义的 object，但是 SwiftUI 本身就有很多系统级别的设定，我们开一个通过 @Environment 来获取到它们

```swift
struct CalendarView: View {
    @Environment(\.calendar) var calendar: Calendar
    @Environment(\.locale) var locale: Locale
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        return Text(locale.identifier)
    }
}
```

# 

## Image

1. 自定义Image这个标签的大小，必须先设置resizable()才能设置frame(width: 50, height: 50)，否则失效。

## List

1. 删除分割线及点击反馈

   ```swift
   init() {
       UITableView.appearance().separatorStyle = .none
       UITableViewCell.appearance().selectionStyle = .none
   }
   ```

   

2. cell中按钮响应事件其他部分的点击不响应

   ```swift
   Button(action: { }) {
       Text("关注")
   }
   .buttonStyle(BorderlessButtonStyle())
   ```


## NavigationView

1. 隐藏右侧按钮

   ```swift
   //Post实现了Identifiable协议，可以省略id: \.id
   ForEach(loadPostListData("PostListData_recommend_1.json").list) { post in
       ZStack{
           PostCell(post: post)
           NavigationLink(destination: PostDetailView(post: post)) {
               EmptyView()
           }.hidden()
       }
       .listRowInsets(EdgeInsets())
   }
   ```

   

2. 纠正详情页title

   ```swift
   List {
       PostCell(post: post)
           .listRowInsets(EdgeInsets())
   
       ForEach(1...10, id: \.self) { i in
           Text("评论\(i)")
       }
   }
   .navigationBarTitle("详情", displayMode: .inline)
   ```

3. 必须设置title隐藏bar才起作用

   ```swift
   NavigationView {
       PostListView()
       .navigationBarTitle("Title")//必须设置title隐藏bar才起作用
       .navigationBarHidden(true)
   }
   ```

   

## 预览多尺寸以及适配

```swift
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwiftUIView()
            SwiftUIView().previewDevice("iPhone SE")
        }
    }
}
```

1. 如果设计的界面是基于414宽度的，那么可以适配如下：

   ```swift
   let scale: CGFloat = UIScreen.main.bounds.width / 414
   ```

   

2. 将VStack按照scaleEffect的scale缩放

   ```swift
   var body: some View {
           VStack(spacing: 12) {
               Spacer()
               Text("0")
                   .font(.system(size: 76))
                   .minimumScaleFactor(0.5)
                   .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                   .lineLimit(1)
               CalculatorButtonPad().padding(.bottom)
           }.scaleEffect(scale)
   ```

3. 整体使用 scaleEffect 进行缩放，会在布局时带来困难，因为它只是对视觉上进行了 缩放，而布局还是依照原有的尺寸进行。相对于整体的 scale 操作，可能对单个具体 元素的 frame 进行缩放效果会好一些 。

4. 多尺寸布局查看

   ```swift
   struct PostImageCell_Previews: PreviewProvider {
       static var previews: some View {
           let list = loadPostListData("PostListData_recommend_1.json").list
           let width = UIScreen.main.bounds.width
   
           return Group{
               PostImageCell(images: Array(list[0].images[0...0]), width: width)
               PostImageCell(images: Array(list[0].images[0...1]), width: width)
               PostImageCell(images: Array(list[0].images[0...2]), width: width)
               PostImageCell(images: Array(list[0].images[0...3]), width: width)
               PostImageCell(images: Array(list[0].images[0...4]), width: width)
               PostImageCell(images: Array(list[0].images[0...5]), width: width)
           }
           .previewLayout(.fixed(width: width, height: 300))
       }
   }
   ```

5. 自定义View中有Binding类型，对应预览使用.constant赋值

   ```swift
   struct HomeNavigationBar: View {
       @Binding var leftPercent: CGFloat // 0 for left, 1 for right
   
       var body: some View {
           HStack {
               Text("推荐")
                   .opacity(Double(1 - leftPercent * 0.5))
               Spacer()
               Text("热门")
           }
       }
   }
   
   struct HomeNavigationBar_Previews: PreviewProvider {
       static var previews: some View {
           HomeNavigationBar(leftPercent: .constant(0))
       }
   }
   ```

   

## Modifier顺序的影响

view modifier分为两种：

1. 像是font、backgroundColor这样定义具体类型上，然后返回同样类型的原地modifer。
2. 像是padding、background这样定义在extension中，将原来的view进行包装并返回新的view的封装类modifier。

原地modifier一般来说对顺序不敏感，对布局也不关心，它们更像是针对对象view本身对属性修改。封装类的modifer的顺序十分重要。

## 验证Dart Mode

1. 在模拟器中运行app，Xcode11通过运行时调试工具栏上的"Enviroment Overides"工具来在颜色模式之间进行切换。

2. 在SwiftUI预览中添加enviroment。

   ```swift
   struct SwiftUIView_Previews: PreviewProvider {
       static var previews: some View {
           Group {
               SwiftUIView()
               SwiftUIView().previewDevice("iPhone SE").environment(\.colorScheme, .dark)
           }
       }
   }
   
   ```

   

## 小技巧

1. 视图充满全屏

   ```swift
   .frame(.minWidth:0,.maxWidth:.infinity,.minHeight:0,.maxHeight:.infinity)
   ```

   

2. @state + private

3. List、ForEach

   > a. ArrayData.identified(by:\.id)或者.self
   >
   > b.数据遵循Identifiable协议

4. type lookup List



# 参考

1. SF Symbols 图标库  https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/
2. https://pokeapi.co/