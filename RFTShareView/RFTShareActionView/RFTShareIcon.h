//
//  RFTShareIcon.h
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFTShareIcon : UIControl

@property (nonatomic, copy, readonly) NSString *iconName;

/**
 RFTShareIcon 的初始化方法
 @param imageName icon 的图片名，icon选中的图片名默认为 "$(imageName)_selected"
 @param labelString icon 底部文本
 */
- (instancetype) initWithImageName:(NSString *)imageName LabelString:(NSString *)labelString;

/**
 RFTShareIcon 的宽度
 */
+ (CGFloat)iconWidth;

/**
 RFTShareIcon 的高度
 */
+ (CGFloat)iconHeight;

@end
