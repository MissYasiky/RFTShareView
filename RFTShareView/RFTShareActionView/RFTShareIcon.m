//
//  RFTShareIcon.m
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import "RFTShareIcon.h"

static CGFloat kImageViewSize = 54;
static CGFloat kLabelHeight   = 12;
static CGFloat kPadding       = 10;

@interface RFTShareIcon ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *iconLabel;

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *selectedImageName;

@end

@implementation RFTShareIcon

- (instancetype) initWithImageName:(NSString *)imageName LabelString:(NSString *)labelString
{
    if (self = [super init]) {
        _iconName = labelString;
        _imageName = imageName;
        _selectedImageName = [imageName stringByAppendingString:@"_selected"];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kImageViewSize, kImageViewSize)];
        _iconImageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_iconImageView];
        
        _iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kImageViewSize + kPadding, kImageViewSize, kLabelHeight)];
        _iconLabel.textColor = [UIColor colorWithRed:0x66/255.0f green:0x66/255.0f blue:0x66/255.0f alpha:1.0];
        _iconLabel.font = [UIFont systemFontOfSize:11];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.text = labelString;
        [self addSubview:_iconLabel];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        _iconImageView.image = [UIImage imageNamed:_selectedImageName];
    }else{
        _iconImageView.image = [UIImage imageNamed:_imageName];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        _iconImageView.image = [UIImage imageNamed:_selectedImageName];
    }else{
        _iconImageView.image = [UIImage imageNamed:_imageName];
    }
}

#pragma mark - UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!self.selected) {
        self.highlighted = YES;
    }
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!self.touchInside){
        if(!self.selected){
            self.highlighted = NO;
        }
        return NO;
    }
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!self.selected) {
        self.highlighted = NO;
    }
}


@end
