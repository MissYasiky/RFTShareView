//
//  RFTShareActionView.h
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RFTShareIcon;

@protocol RFTShareActionViewDelegate;
@protocol RFTShareActionViewDateSource;

@interface RFTShareActionView : UIView

- (instancetype)initWithDataSource:(id<RFTShareActionViewDateSource>)dataSource
                          delegate:(id<RFTShareActionViewDelegate>)delegate;
- (void)show;
- (void)dissmiss;

@end

@protocol RFTShareActionViewDelegate <NSObject>

@required
- (void)shareMoreView:(RFTShareActionView *)shareMoreView didSelectedIconWithName:(NSString *)iconName;
- (void)dismissShareMoreView:(RFTShareActionView *)shareMoreView;

@end

@protocol RFTShareActionViewDateSource <NSObject>

@required
- (NSInteger)numberOfSectionsInShareMoreView:(RFTShareActionView *)shareMoreView;
- (NSInteger)shareMoreView:(RFTShareActionView *)shareMoreView numberOfIconsInSection:(NSInteger)section;
- (RFTShareIcon *)shareMoreView:(RFTShareActionView *)shareMoreView objectForIconAtIndexPath:(NSIndexPath *)indexPath;

@end
