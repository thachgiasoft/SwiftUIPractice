# SwiftUIPractice
实践SwiftUI及Combine

# Swift

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