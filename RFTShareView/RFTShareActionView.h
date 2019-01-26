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

- (instancetype)initWithViewModel:(RFTShareActionViewModel *)viewModel
                         delegate:(id<RFTShareActionViewDelegate>)delegate;
- (void)show;
- (void)dissmiss;

@end

@protocol RFTShareActionViewDelegate <NSObject>

@required
- (void)shareMoreView:(RFTShareActionView *)shareMoreView didSelectedType:(RFTShareType)type;
@optional
- (void)didDismissShareMoreView:(RFTShareActionView *)shareMoreView;

@end
