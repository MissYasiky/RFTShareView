//
//  ViewController.m
//  RFTShareView
//
//  Created by YJXie on 15/12/31.
//  Copyright © 2015年 YJXie. All rights reserved.
//

#import "ViewController.h"
#import "RFTShareIcon.h"
#import "RFTShareMoreView.h"

static NSString *kIconImageKey = @"kIconImageKey";
static NSString *kIconLabelKey = @"kIconLabelKey";

static NSArray * shareIconDate()
{
    static NSArray *array = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[@[
                      @{kIconImageKey : @"share_wechat",  kIconLabelKey : @"微信"},
                      @{kIconImageKey : @"share_moment",  kIconLabelKey : @"朋友圈"},
                      @{kIconImageKey : @"share_qq",      kIconLabelKey : @"QQ"},
                      @{kIconImageKey : @"share_weibo",   kIconLabelKey : @"新浪微博"},
                      @{kIconImageKey : @"share_link",    kIconLabelKey : @"复制链接"}
                      ],
                  @[
                      @{kIconImageKey : @"share_report",  kIconLabelKey : @"举报"}
                      ]
                  ];
    });
    return array;
}

@interface ViewController () <RFTShareMoreViewDateSource, RFTShareMoreViewDelegate>

@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) RFTShareMoreView  *shareView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Getter & Setter

- (RFTShareMoreView *)shareView {
    if (_shareView == nil) {
        _shareView = [[RFTShareMoreView alloc] initWithDataSource:self delegate:self];
    }
    return _shareView;
}

#pragma mark - RFTShareMoreView DateSource

- (NSInteger)numberOfSectionsInShareMoreView:(RFTShareMoreView *)shareMoreView
{
    return [shareIconDate() count];
}

- (NSInteger)shareMoreView:(RFTShareMoreView *)shareMoreView numberOfIconsInSection:(NSInteger)section
{
    NSArray *array = (NSArray *)shareIconDate()[section];
    return [array count];
}

- (RFTShareIcon *)shareMoreView:(RFTShareMoreView *)shareMoreView objectForIconAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = shareIconDate()[indexPath.section][indexPath.row];
    RFTShareIcon *shareIcon = [[RFTShareIcon alloc] initWithImageName:info[kIconImageKey] LabelString:info[kIconLabelKey]];
    return shareIcon;
}

#pragma mark - RFTShareMoreView Delegate

- (void)dismissShareMoreView:(RFTShareMoreView *)shareMoreView
{
    [self.shareView dissmiss];
}

- (void)shareMoreView:(RFTShareMoreView *)shareMoreView didSelectedIconWithName:(NSString *)iconName
{
    if([iconName isEqualToString:@"微信"] || [iconName isEqualToString:@"朋友圈"] || [iconName isEqualToString:@"QQ"] || [iconName isEqualToString:@"新浪微博"]){
        //share to the third platform, eg: weChat, qq, sina
    }else if ([iconName isEqualToString:@"复制链接"]){
        [self p_copyShareLink];
    }else if ([iconName isEqualToString:@"举报"]){
        //do something to report
    }
}

#pragma mark - Action

-(IBAction)showShareMoreView:(id)sender
{
    [self.shareView show];
}

#pragma mark - Private Method

- (void)p_copyShareLink
{
    [self.shareView dissmiss];
    
    NSString *link = @"the link you want to copy";
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:link];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"链接已拷贝" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"got it!" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

@end
