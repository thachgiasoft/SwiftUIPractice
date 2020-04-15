# SwiftUIPractice
实践SwiftUI及Combine

# Swift

## 数据转模型

 JSON解析及格式化验证：https://www.json.cn/

 JSON 2 swift：[http://www.jsoncafe.com](http://www.jsoncafe.com/)

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

## 数据状态和绑定

根据适用范围和存储 状态的复杂度的不同，需要选取合适的方案。@State 和 @Binding 提供 View 内部 的状态存储，它们应该是被标记为 private 的简单值类型，仅在内部使用。 ObservableObject 和 @ObservedObject 则针对跨越 View 层级的状态共享，它可以处理更复杂的数据类型，其引用类型的特点，也让我们需要在数据变化时通过某种 手段向外发送通知 (比如手动调用 objectWillChange.send() 或者使用 @Published)， 来触发界面刷新。对于 “跳跃式” 跨越多个 View 层级的状态，@EnvironmentObject 能让我们更方便地使用 ObservableObject，以达到简化代码的目的。 

如果你纠结于选择使用哪种方式的话，从 ObservableObject 开始入手会是一个相对好的选择:如果发现状态可以被限制在同一个 View 层级中， 则改用 @State;如果发现状态需要大批量共享，则改用 @EnvironmentObject。 

## @State

通过使用 @State 修饰器我们可以关联出 View 的状态. SwiftUI 将会把使用过 @State 修饰器的属性存储到一个特殊的内存区域，并且这个区域和 View struct 是隔离的. 当 @State 装饰过的属性发生了变化，SwiftUI 会根据新的属性值重新创建视图。

这个状态是属于单个 View 及其子层级，还是需要在平行的部件之间传递和使 用?@State 可以依靠 SwiftUI 框架完成 View 的自动订阅和刷新，但这是有 条件的:对于 @State 修饰的属性的访问，只能发生在 body 或者 body 所调 用的方法中。你不能在外部改变 @State 的值，它的所有相关操作和状态改变 都应该是和当前 View 挂钩的。如果你需要在多个 View 中共享数据，@State 可能不是很好的选择;如果还需要在 View 外部操作数据，那么 @State 甚至 就不是可选项了。 

## @Binding

有时候我们会把一个视图的属性传至子节点中，但是又不能直接的传递给子节点，因为在 Swift 中值的传递形式是`值类型`传递方式，也就是传递给子节点的是一个拷贝过的值。但是通过 @Binding 修饰器修饰后，属性变成了一个`引用类型`，传递变成了引用传递，这样父子视图的状态就能关联起来了。

状态对应的数据结构是否足够简单?对于像是单个的Bool或者String， @State 可以迅速对应。含有少数几个成员变量的值类型，也许使用 @State 也还不错。但是对于更复杂的情况，例如含有很多属性和方法的类型，可能其 中只有很少几个属性需要触发 UI 更新，也可能各个属性之间彼此有关联，那 么我们应该选择引用类型和更灵活的可自定义方式。 

## @ObservedObject

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

## @EnvironmentObject

从名字上可以看出，这个修饰器是针对全局环境的。通过它，我们可以避免在初始 View 时创建 ObservableObject, 而是从环境中获取 ObservableObject

被标记为 @EnvironmentObject 的值进 行指定，它们会自动去查询 View 的 Environment 中是否有符合的类型的值，如果有 则使用它们，如没有则抛出运行时的错误。 

## @Environment

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

# SwiftUI

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