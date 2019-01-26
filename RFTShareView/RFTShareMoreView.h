//
//  RFTShareMoreView.h
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RFTShareIcon;

@protocol RFTShareMoreViewDelegate;
@protocol RFTShareMoreViewDateSource;

@interface RFTShareMoreView : UIView

- (instancetype)initWithDataSource:(id<RFTShareMoreViewDateSource>)dataSource
                          delegate:(id<RFTShareMoreViewDelegate>)delegate;
- (void)show;
- (void)dissmiss;

@end

@protocol RFTShareMoreViewDelegate <NSObject>

@required
- (void)shareMoreView:(RFTShareMoreView *)shareMoreView didSelectedIconWithName:(NSString *)iconName;
- (void)dismissShareMoreView:(RFTShareMoreView *)shareMoreView;

@end

@protocol RFTShareMoreViewDateSource <NSObject>

@required
- (NSInteger)numberOfSectionsInShareMoreView:(RFTShareMoreView *)shareMoreView;
- (NSInteger)shareMoreView:(RFTShareMoreView *)shareMoreView numberOfIconsInSection:(NSInteger)section;
- (RFTShareIcon *)shareMoreView:(RFTShareMoreView *)shareMoreView objectForIconAtIndexPath:(NSIndexPath *)indexPath;

@end
