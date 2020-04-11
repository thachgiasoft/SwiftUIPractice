# SwiftUIPractice
实践SwiftUI及Combine

# Swift

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

# SwiftUI

## Image

1. 自定义Image这个标签的大小，必须先设置resizable()才能设置frame(width: 50, height: 50)，否则失效。

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