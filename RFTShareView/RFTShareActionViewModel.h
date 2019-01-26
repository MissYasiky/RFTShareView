//
//  RFTShareActionViewModel.h
//  RFTShareView
//
//  Created by MissYasiky on 2019/1/26.
//  Copyright © 2019 YJXie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

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

@property (nonatomic, copy) NSArray *dataSource;

- (NSInteger)section;
- (NSInteger)iconNumberAtSection:(NSInteger)section;
- (RFTShareType)typeAtIndexPath:(NSIndexPath *)index;
- (NSString *)iconImageName:(RFTShareType)type;
- (NSString *)iconLabelText:(RFTShareType)type;

@end
