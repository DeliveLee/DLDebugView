# DLDebugView   


- A in app debug view for iOS
- 一个iOS APP内的调试窗口

## Contents:
* [Getting Started 【开始使用】](#Getting_Started)
	* [Features 【能做什么】](#Features)
	* [Installation 【安装】](#Installation)
* [Examples 【示例】](#Examples)
	* [Import In Code 【添加引用】](#Import_In_Code)
	* [Add To Window 【添加窗口】](#Add_To_Window)
	* [Print Debug Info 【打印信息】](#Print_Debug_Info)
* [ToDo List【将会添加】](#ToDo_List)


---

# <a id="Getting_Started"></a> Getting Started【开始使用】

## <a id="Features"></a> Features【能做什么】
- DLDebugView usually use in when you wanna got debug info but unable connect to Xcode.(Like Testflight or Fabric something, or just when QA testing)
    * Just use less than 5 lines code and almost same NSLog way, you can get a in app debugview and more feature than use NSLog.


- DLDebugView用于一些无法连接Xcode实时获取debug信息时，使用的In App显示Debug信息窗口。(比如使用Testflight或Fabric下载的版本一类的情况，或者QA在进行测试)
    * 只需要不到5行代码和几乎与NSLog完全相同的使用方式，你就可以获得一个App内的DebugView并且比NSLog支持更多的功能。

## <a id="Installation"></a> Installation【安装】

### From CocoaPods【使用CocoaPods】

```ruby
pod 'DLDebugView'
```
* Note this 【请注意】:
* Depends on [SDAutolayout] (https://github.com/gsdios/SDAutoLayout)
* 依赖于[SDAutolayout] (Thanks for this framework author, you made a awesome stuff.) (https://github.com/gsdios/SDAutoLayout) （感谢此框架作者，这个框架真的很棒。）

# <a id="Examples"></a> Examples【示例】

### <a id="Import_In_Code"></a> Import In Code【添加引用】

```objc
#import "DLDebugView/DlDebugView.h"
```
* I suggest add import into \*.pch file or Prefix Header file, then you can use DlDebugView in anywhere.
* 我建议把文件引用添加到pch文件或头引用文件中，这样就可以在任何地方使用它了。

### <a id="Add_To_Window"></a> Add To Window【添加窗口】
```objc
AppDelegate.m

[self.window setRootViewController:[UIViewController new]];
[self.window makeKeyAndVisible];

DLDebugView *debugView = [DLDebugView sharedManager];
[self.window addSubview:debugView];

```
* Note this 【请注意】:
* You should add DLDebugView code after `[self.window makeKeyAndVisible];`, and add DLDebugView into `self.window`, then debugview will always get in front than other UI stuff.
* 你应该在`[self.window makeKeyAndVisible];`后加入添加DLDebugView的代码， 并且添加到`self.window`， 这样debugview会一直保持在最前相比其他UI界面。

##### Then running your app, you will get a Blue Button on screen left top! Try to click it ^.^
##### You can click Blue button to open/close debugview, and drag blue button to change debugview position.
##### 这时候运行你的程序，你会得到一个绿色的按钮显示在屏幕左上方！点击它试试 ^.^
##### 你可以点击蓝色按钮去打开、关闭debugview，并且拖动蓝色按钮来改变debugview的位置。


### <a id="Print_Debug_Info"></a> Print Debug Info 【打印信息】
```objc
DLLog(DLDebugViewInfoMessage, @"here is a message");
DLLog(DLDebugViewInfoWarning, @"here is a warning");
DLLog(DLDebugViewInfoError, @"here is a error");
```
* Note this 【请注意】:
* `DLDebugViewInfoMessage`/`DLDebugViewInfoWarning`/`DLDebugViewInfoError` is Enum value, you can use this enum value to make this debuginfo's text color.
* `DLDebugViewInfoMessage`/`DLDebugViewInfoWarning`/`DLDebugViewInfoError` 是一个枚举值， 你可以通过指定这个值，来改变调试信息的文字颜色。

### <a id="ToDo_List"></a> ToDo List【将会添加】
- Maybe can use shake phone to showing the Blue button. (Thanks Maail :) 【也许应该支持通过晃动手机显示蓝色按钮】
- DebugView should support display image 【DebugView应该支持图片显示】
- Maybe should have some Quick functionality, like running some Foundation or code by inputing? 【也许应该有一些快速方法，通过输入来运行一些方法或者代码？】
