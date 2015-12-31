//
//  RFTShareMoreView.m
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import "RFTShareMoreView.h"
#import "RFTShareIcon.h"

//#import "WXApi.h"
//#import <TencentOpenAPI/QQApiInterface.h>

static int32_t const kIconSizeWidth  = 54;
static int32_t const kIconSizeHeight = 76;
static int32_t const kIconPadding    = 18;

@interface RFTShareMoreView ()
@property (nonatomic, strong) UIButton *cancleButton;
@end

@implementation RFTShareMoreView

- (id)initWithFrame:(CGRect)frame dataSource:(id<RFTShareMoreViewDateSource>)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _dateSource = dataSource;
        
        self.backgroundColor = [UIColor colorWithRed:0xf5/255.0f green:0xf5/255.0f blue:0xf5/255.0f alpha:1.0];
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    CGRect frame = self.frame;
    
    UIView *blueLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
    blueLine.backgroundColor = [UIColor colorWithRed:0x61/255.0f green:0xb8/255.0f blue:0xe2/255.0f alpha:0.9];
    [self addSubview:blueLine];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 39)];
    titleLabel.text = @"分享到";
    titleLabel.textColor = [UIColor colorWithRed:0x45/255.0f green:0x4a/255.0f blue:0x4d/255.0f alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    NSInteger section = [_dateSource numberOfSectionsInShareMoreView:self];
    if (section <= 0) return;
    
    CGFloat originX = (frame.size.width - 4 * kIconSizeWidth) / 5;
    CGFloat originY = titleLabel.frame.size.height;
    
    for (int i = 0; i < section; i++) {
        NSInteger iconsNumber = [_dateSource shareMoreView:self numberOfIconsInSection:i];
        if (iconsNumber <= 0) {
            continue;
        }
        
        NSInteger row = 0;
        for (int j = 0; j < iconsNumber; j++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:j inSection:i];
            
            NSString *text = [_dateSource shareMoreView:self iconNameAtIndexPath:index];
//            if (([text isEqualToString:@"微信"] || [text isEqualToString:@"朋友圈"]) && ![WXApi isWXAppInstalled]) {
//                
//                continue;
//            }
//            if ([text isEqualToString:@"QQ"] && ![QQApiInterface isQQInstalled]) {
//                
//                continue;
//            }
            RFTShareIcon *object = [_dateSource shareMoreView:self objectForIconAtIndexPath:index];
            object.frame = CGRectMake(originX + row % 4 * (originX + kIconSizeWidth), originY + row / 4 * (kIconSizeHeight + kIconPadding), kIconSizeWidth , kIconSizeHeight);
            [self addSubview:object];
            
            [object addTarget:self action:@selector(iconSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
            
            row ++;
        }
        
        originY += kIconSizeHeight + kIconPadding;
        originY += (row-1) / 4 * (kIconSizeHeight + kIconPadding);
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, originY, frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0xe6/255.0f green:0xe6/255.0f blue:0xe6/255.0f alpha:1.0];
        [self addSubview:line];
        
        originY += 12;
    }
    
    originY -= 12;
    
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleButton.backgroundColor = [UIColor clearColor];
    [_cancleButton setFrame:CGRectMake(0, originY, frame.size.width, 44)];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor colorWithRed:0xc3/255.0f green:0xc6/255.0f blue:0xc7/255.0f alpha:1.0] forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor colorWithRed:0x66/255.0f green:0xcc/255.0f blue:0xff/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancleButton addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancleButton];
    
    frame.size.height = _cancleButton.frame.origin.y + _cancleButton.frame.size.height;
    self.frame = frame;
    return;
}

#pragma mark - action

- (void)iconSelectedAction:(RFTShareIcon *)icon
{
    [_delegate shareMoreView:self didSelectedIconWithName:[icon iconName]];
}

- (void)dismissAction
{
    [_delegate dismissShareMoreView:self];
}

@end
