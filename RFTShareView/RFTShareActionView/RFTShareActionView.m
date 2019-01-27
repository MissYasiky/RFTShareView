//
//  RFTShareActionView.m
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import "RFTShareActionView.h"
#import "RFTShareIcon.h"

static NSTimeInterval kDuration = 0.3;
static CGFloat kCoverViewAlpha  = 0.4;
static CGFloat kIconYPadding     = 18;

@interface RFTShareActionView ()

@property (nonatomic,   weak) id<RFTShareActionViewDelegate> delegate;
@property (nonatomic, strong) RFTShareActionViewModel *viewModel;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *shareActionView;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, assign) CGFloat bottom;

@end

@implementation RFTShareActionView

- (instancetype)initWithViewModel:(RFTShareActionViewModel *)viewModel
                         delegate:(id<RFTShareActionViewDelegate>)delegate {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        _delegate = delegate;
        
        self.frame = [UIScreen mainScreen].bounds;
        
        [self addSubview:self.coverView];
        [self addSubview:self.shareActionView];
    }
    return self;
}

#pragma mark - Getter & Setter

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.frame];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0;
        
        UITapGestureRecognizer *gestureRcog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmiss)];
        gestureRcog.numberOfTapsRequired = 1;
        gestureRcog.numberOfTouchesRequired = 1;
        [_coverView addGestureRecognizer:gestureRcog];
    }
    return _coverView;
}

- (UIView *)shareActionView {
    if (_shareActionView == nil) {
        CGRect rect = self.frame;
        rect.size.height = 80.0;
        rect.origin.y = self.frame.size.height;
        _shareActionView = [[UIView alloc] initWithFrame:rect];
        _shareActionView.backgroundColor = [UIColor colorWithRed:0xf5/255.0f green:0xf5/255.0f blue:0xf5/255.0f alpha:1.0];
        [self setupSubviews];
    }
    return _shareActionView;
}

#pragma mark - Public Method

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window addSubview:self];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:kDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGRect mviewRc = self.shareActionView.frame;
    mviewRc.origin.y = self.frame.size.height - self.shareActionView.frame.size.height;
    self.shareActionView.frame = mviewRc;
    self.coverView.alpha = kCoverViewAlpha;
    [UIView commitAnimations];
}

- (void)dissmiss {
    [UIView animateWithDuration:kDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect mviewRc = self.shareActionView.frame;
        mviewRc.origin.y = self.frame.size.height;
        self.shareActionView.frame = mviewRc;
        self.coverView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Private Method

- (void)setupSubviews {
    
    NSInteger section = [self.viewModel section];
    
    CGFloat width = self.frame.size.width;
    
    UIView *blueLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    blueLine.backgroundColor = [UIColor colorWithRed:0x61/255.0f green:0xb8/255.0f blue:0xe2/255.0f alpha:0.9];
    [self.shareActionView addSubview:blueLine];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 39)];
    titleLabel.text = @"分享到";
    titleLabel.textColor = [UIColor colorWithRed:0x45/255.0f green:0x4a/255.0f blue:0x4d/255.0f alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareActionView addSubview:titleLabel];
    
    CGFloat iconWidth = [RFTShareIcon iconWidth];
    CGFloat iconHeight = [RFTShareIcon iconHeight];
    CGFloat originX = (width - 4 * iconWidth) / 5;
    CGFloat originY = titleLabel.frame.size.height;
    
    for (int i = 0; i < section; i++) {
        NSInteger iconsNumber = [self.viewModel iconNumberAtSection:i];
        if (iconsNumber == 0) {
            continue;
        }
        
        NSInteger row = 0;
        for (int j = 0; j < iconsNumber; j++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:j inSection:i];
            RFTShareType type = [self.viewModel typeAtIndexPath:index];
            NSString *imageName = [self.viewModel iconImageName:type];
            NSString *iconText = [self.viewModel iconLabelText:type];
            RFTShareIcon *shareIcon = [[RFTShareIcon alloc] initWithImageName:imageName LabelString:iconText];
            shareIcon.tag = type;
            shareIcon.frame = CGRectMake(originX + row % 4 * (originX + iconWidth), originY + row / 4 * (iconHeight + kIconYPadding), iconWidth , iconHeight);
            [self.shareActionView addSubview:shareIcon];
            
            [shareIcon addTarget:self action:@selector(iconSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
            
            row ++;
        }
        
        originY += iconHeight + kIconYPadding;
        originY += (row-1) / 4 * (iconHeight + kIconYPadding);
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, originY, width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0xe6/255.0f green:0xe6/255.0f blue:0xe6/255.0f alpha:1.0];
        [self.shareActionView addSubview:line];
        
        originY += 12;
    }
    
    originY -= 12;
    
    CGFloat btnHeight = 44.0;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        btnHeight += window.safeAreaInsets.bottom;
    }
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleButton.backgroundColor = [UIColor clearColor];
    [_cancleButton setFrame:CGRectMake(0, originY, width, btnHeight)];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor colorWithRed:0xc3/255.0f green:0xc6/255.0f blue:0xc7/255.0f alpha:1.0] forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor colorWithRed:0x66/255.0f green:0xcc/255.0f blue:0xff/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancleButton addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareActionView addSubview:_cancleButton];
    
    CGRect shareViewRect = self.shareActionView.frame;
    shareViewRect.size.height = _cancleButton.frame.origin.y + btnHeight;
    self.shareActionView.frame = shareViewRect;
}

#pragma mark - action

- (void)iconSelectedAction:(RFTShareIcon *)icon {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareMoreView:didSelectedType:)]) {
        RFTShareType type = icon.tag;
        [self.delegate shareMoreView:self didSelectedType:type];
    }
}

- (void)dismissAction {
    [self dissmiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didDismissShareMoreView:)]) {
        [self.delegate didDismissShareMoreView:self];
    }
}

@end
