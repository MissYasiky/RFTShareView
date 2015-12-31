//
//  RFTShareIcon.m
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import "RFTShareIcon.h"

static int32_t kImageViewSize = 54;
static int32_t kLabelHeight   = 12;
static int32_t kPadding       = 10;

@interface RFTShareIcon ()
@property (nonatomic, retain) UIImageView *iconImageView;
@property (nonatomic, retain) UILabel *iconLabel;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *selectedImageName;
@end

@implementation RFTShareIcon

- (id) init
{
    return [self initWithImageName:@"" LabelString:@""];
}

- (instancetype) initWithImageName:(NSString *)imageName LabelString:(NSString *)labelString
{
    if (self = [super init]) {
        _imageName = imageName;
        _selectedImageName = [imageName stringByAppendingString:@"_selected"];
        _labelName = labelString;
        
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

- (void)setLabelName:(NSString *)labelName
{
    _labelName = labelName;
    _iconLabel.text = _labelName;
}

- (NSString *)iconName
{
    return _labelName;
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
