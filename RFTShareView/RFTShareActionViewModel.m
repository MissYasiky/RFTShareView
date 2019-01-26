//
//  RFTShareActionViewModel.m
//  RFTShareView
//
//  Created by MissYasiky on 2019/1/26.
//  Copyright © 2019 YJXie. All rights reserved.
//

#import "RFTShareActionViewModel.h"

@implementation RFTShareActionViewModel

- (NSInteger)section {
    return [self.dataSource count];
}

- (NSInteger)iconNumberAtSection:(NSInteger)section {
    if (section >= [self.dataSource count]) {
        return 0;
    }
    id object = self.dataSource[section];
    if (![object isKindOfClass:[NSArray class]]) {
        return 0;
    }
    NSArray *array = (NSArray *)object;
    return [array count];
}

- (RFTShareType)typeAtIndexPath:(NSIndexPath *)index {
    if (index.section < [self section] && index.row < [self iconNumberAtSection:index.section]) {
        return [self.dataSource[index.section][index.row] integerValue];
    } else {
        return RFTShareTypeUnknow;
    }
}

- (NSString *)iconImageName:(RFTShareType)type {
    switch (type) {
        case RFTShareTypeWechat:
            return @"share_wechat";
            break;
        case RFTShareTypeWXTimeLine:
            return @"share_moment";
            break;
        case RFTShareTypeQQ:
            return @"share_qq";
            break;
        case RFTShareTypeQQZone:
            return @"share_qq";
            break;
        case RFTShareTypeSina:
            return @"share_weibo";
            break;
        case RFTShareTypeCopyLink:
            return @"share_link";
            break;
        case RFTShareTypeReport:
            return @"share_report";
            break;
        default:
            return @"";
    }
}

- (NSString *)iconLabelText:(RFTShareType)type {
    switch (type) {
        case RFTShareTypeWechat:
            return @"微信";
            break;
        case RFTShareTypeWXTimeLine:
            return @"朋友圈";
            break;
        case RFTShareTypeQQ:
            return @"QQ";
            break;
        case RFTShareTypeQQZone:
            return @"QQ空间";
            break;
        case RFTShareTypeSina:
            return @"新浪微博";
            break;
        case RFTShareTypeCopyLink:
            return @"复制链接";
            break;
        case RFTShareTypeReport:
            return @"举报";
            break;
        default:
            return @"";
    }
}

@end
