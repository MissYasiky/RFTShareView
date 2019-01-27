# RFTShareView

## 控件效果
抽离出一个分享弹窗控件，类似 ActionSheet 的形式，自下而上出现在顶部视图上。点击背景蒙层次或取消按钮可隐藏弹窗。弹窗上的 icon 可自由组合。

![弹窗效果](https://github.com/MissYasiky/RFTShareView/blob/develop/ScreenShot/iphone%206%20ScreenShot.png)

![弹窗效果](https://github.com/MissYasiky/RFTShareView/blob/develop/ScreenShot/RFTShareViewDemo.gif)

## 使用方法：

1、使用分享弹窗的 ViewController.m

```Objective-c
#import "RFTShareActionView.h"

@interface ViewController () <RFTShareActionViewDelegate>

@property (nonatomic, strong) RFTShareActionView  *shareView;
@property (nonatomic, strong) RFTShareActionViewModel *shareViewModel;

@end

@implementation ViewController

#pragma mark - RFTShareActionView Delegate

// 点击响应事件的代理方法 
- (void)shareMoreView:(RFTShareActionView *)shareMoreView didSelectedType:(RFTShareType)type {
}

// 隐藏弹窗后的代理方法
- (void)didDismissShareMoreView:(RFTShareActionView *)shareMoreView {
}

@end

```

2、弹窗的初始化

```Objective-c
RFTShareActionViewModel *shareViewModel = [[RFTShareActionViewModel alloc] init];
shareViewModel.dataSource = @[@[@(RFTShareTypeWechat), @(RFTShareTypeWXTimeLine), @(RFTShareTypeQQ), @(RFTShareTypeSina)], @[@(RFTShareTypeReport)]];
RFTShareActionView *shareView = [[RFTShareActionView alloc] initWithViewModel:shareViewModel delegate:self];
```

3、展示与隐藏
```Objective-c
[shareView show]; // 展示弹窗
[shareView dismiss]; // 隐藏弹窗
```
