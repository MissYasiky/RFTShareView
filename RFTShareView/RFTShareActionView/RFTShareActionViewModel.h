//
//  RFTShareActionViewModel.h
//  RFTShareView
//
//  Created by MissYasiky on 2019/1/26.
//  Copyright © 2019 YJXie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 RFTShareActionView 支持的分享类型，可扩展，扩展时需扩写方法 "-iconImageName:" 和 "-iconLabelText:"
 */
typedef NS_ENUM(NSInteger, RFTShareType) {
    RFTShareTypeUnknow = -1,
    RFTShareTypeWechat = 0,
    RFTShareTypeWXTimeLine,
    RFTShareTypeQQ,
    RFTShareTypeQQZone,
    RFTShareTypeSina,
    RFTShareTypeCopyLink,
    RFTShareTypeReport
};

@interface RFTShareActionViewModel : NSObject

/**
 dataSource 必须是以 RFTShareType 的值为元素的二维数组
 如 @[
        @[@(RFTShareTypeWechat), @(RFTShareTypeWXTimeLine), @(RFTShareTypeQQ), @(RFTShareTypeSina)],
        @[@(RFTShareTypeReport)]
    ]
 第一维的元素会分段显示，用横线分隔开
 第二维的元素会按每行 4 个 icon 的形式依次排下来
 */
@property (nonatomic, copy) NSArray *dataSource;

/**
 分享弹窗的段落
 */
- (NSInteger)section;

/**
 第 section 段的分享 icon 有几个
 */
- (NSInteger)iconNumberAtSection:(NSInteger)section;

/**
 第 index.section 段，第 index.row 行的 icon 是什么类型的
 */
- (RFTShareType)typeAtIndexPath:(NSIndexPath *)index;

/**
 返回类型为 type 的 icon 的图片名
 */
- (NSString *)iconImageName:(RFTShareType)type;

/**
 返回类型为 type 的 icon 的文本内容
 */
- (NSString *)iconLabelText:(RFTShareType)type;

@end
