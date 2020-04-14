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

## 数据流

### State

这个状态是属于单个 View 及其子层级，还是需要在平行的部件之间传递和使 用?@State 可以依靠 SwiftUI 框架完成 View 的自动订阅和刷新，但这是有 条件的:对于 @State 修饰的属性的访问，只能发生在 body 或者 body 所调 用的方法中。你不能在外部改变 @State 的值，它的所有相关操作和状态改变 都应该是和当前 View 挂钩的。如果你需要在多个 View 中共享数据，@State 可能不是很好的选择;如果还需要在 View 外部操作数据，那么 @State 甚至 就不是可选项了。 

### Binding

状态对应的数据结构是否足够简单?对于像是单个的Bool或者String， @State 可以迅速对应。含有少数几个成员变量的值类型，也许使用 @State 也还不错。但是对于更复杂的情况，例如含有很多属性和方法的类型，可能其 中只有很少几个属性需要触发 UI 更新，也可能各个属性之间彼此有关联，那 么我们应该选择引用类型和更灵活的可自定义方式。 

### ObservableObject 和 ObservedObject 

ObservableObject 协议要求实现类型是 class，它只有一个需要实现的属性:objectWillChange。在数据将要发生改变时，这个属性用来向外进行 “广播”， 它的订阅者 (一般是 View 相关的逻辑) 在收到通知后，对 View 进行刷新。 

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