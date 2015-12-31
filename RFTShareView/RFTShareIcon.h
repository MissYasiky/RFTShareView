//
//  RFTShareIcon.h
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFTShareIcon : UIControl

@property (nonatomic, copy) NSString *labelName;
/*
 "imageName"为icon的图片名，该icon选中的图片将默认为"imageName_selected"
 */
- (instancetype) initWithImageName:(NSString *)imageName LabelString:(NSString *)labelString;
- (NSString *)iconName;

@end
