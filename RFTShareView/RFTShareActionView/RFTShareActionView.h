//
//  RFTShareActionView.h
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFTShareActionViewModel.h"

@class RFTShareIcon;

@protocol RFTShareActionViewDelegate;

@interface RFTShareActionView : UIView

/**
 使用以下方法初始化 RFTShareActionView
 @param viewModel RFTShareActionView 的视图模型，不可为 nil
 @param delegate  RFTShareActionView 的代理，不可为 nil
 */
- (instancetype)initWithViewModel:(RFTShareActionViewModel *)viewModel
                         delegate:(id<RFTShareActionViewDelegate>)delegate;

/**
 展示 RFTShareActionView 到顶层 window
 */
- (void)show;

/**
 隐藏 RFTShareActionView，并移出 window
 */
- (void)dissmiss;

@end

@protocol RFTShareActionViewDelegate <NSObject>

@required
/**
 点击了某一个类型的 icon 时
 */
- (void)shareMoreView:(RFTShareActionView *)shareMoreView didSelectedType:(RFTShareType)type;
@optional
/**
 RFTShareActionView 已经隐藏时
 */
- (void)didDismissShareMoreView:(RFTShareActionView *)shareMoreView;

@end
