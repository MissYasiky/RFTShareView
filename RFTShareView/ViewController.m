//
//  ViewController.m
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import "ViewController.h"
#import "RFTShareActionView.h"

@interface ViewController () <RFTShareActionViewDelegate>

@property (nonatomic,   weak) IBOutlet UIButton *button;
@property (nonatomic, strong) RFTShareActionView  *shareView;
@property (nonatomic, strong) RFTShareActionViewModel *shareViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Getter & Setter

- (RFTShareActionView *)shareView {
    if (_shareView == nil) {
        _shareViewModel = [[RFTShareActionViewModel alloc] init];
        _shareViewModel.dataSource = @[@[@(RFTShareTypeWechat), @(RFTShareTypeWXTimeLine), @(RFTShareTypeQQ), @(RFTShareTypeSina)], @[@(RFTShareTypeReport)]];
        _shareView = [[RFTShareActionView alloc] initWithViewModel:_shareViewModel delegate:self];
    }
    return _shareView;
}

#pragma mark - RFTShareActionView Delegate

- (void)shareMoreView:(RFTShareActionView *)shareMoreView didSelectedType:(RFTShareType)type
{
    switch (type) {
        case RFTShareTypeWechat:
            NSLog(@"share to wechat");
            break;
        case RFTShareTypeWXTimeLine:
            NSLog(@"share to wx timeLine");
            break;
        case RFTShareTypeQQ:
            NSLog(@"share to QQ");
            break;
        case RFTShareTypeQQZone:
            NSLog(@"share to QQZone");
            break;
        case RFTShareTypeSina:
            NSLog(@"share to sina");
            break;
        default:
            break;
    }
}

#pragma mark - Action

-(IBAction)showShareMoreView:(id)sender
{
    [self.shareView show];
}

@end
