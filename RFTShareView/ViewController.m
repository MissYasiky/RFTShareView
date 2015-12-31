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

@interface ViewController ()<RFTShareMoreViewDateSource, RFTShareMoreViewDelegate>

@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) UIAlertController *alertController;
@property (nonatomic, retain) RFTShareMoreView  *shareView;
@property (nonatomic, retain) UIView            *coverView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"got it!" style:UIAlertActionStyleCancel handler:nil];
    [_alertController addAction:cancelAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSString *)shareMoreView:(RFTShareMoreView *)shareMoreView iconNameAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = shareIconDate()[indexPath.section][indexPath.row];
    return info[kIconLabelKey];
}

#pragma mark - WDShareMoreViewDelegate

- (void)dismissShareMoreView:(RFTShareMoreView *)shareMoreView
{
    [self p_dismissShareMoreView];
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

#pragma mark - WDShareMoreView related
-(IBAction)showShareMoreView:(id)sender
{
    CGRect rect = self.view.frame;
    
    if(_coverView == nil || _shareView == nil){
        
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        
        CGRect coverrc = rect;
        coverrc.origin.y = rect.size.height;
        
        _coverView = [[UIView alloc] initWithFrame:coverrc];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.4;
        [window addSubview:_coverView];
        
        UITapGestureRecognizer *gestureRcog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_dismissShareMoreView)];
        gestureRcog.numberOfTapsRequired = 1;
        gestureRcog.numberOfTouchesRequired = 1;
        [_coverView addGestureRecognizer:gestureRcog];
        
        CGRect viewrc = rect;
        viewrc.origin.x = 0.0f;
        viewrc.origin.y = rect.size.height;
        viewrc.size.width = rect.size.width;
        viewrc.size.height = 80.0f;
        
        _shareView = [[RFTShareMoreView alloc] initWithFrame:viewrc dataSource:self];
        [window addSubview:_shareView];
        
        [_shareView setDelegate:self];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGRect mviewRc = _shareView.frame;
    mviewRc.origin.y = rect.size.height - _shareView.frame.size.height;
    _shareView.frame = mviewRc;
    [UIView commitAnimations];
    
    CGRect coverRect = _coverView.frame;
    coverRect.origin.y = 0;
    _coverView.frame = coverRect;
}

-(void)p_dismissShareMoreView
{
    CGRect rect = self.view.frame;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect mviewRc = _shareView.frame;
        mviewRc.origin.y = rect.size.height;
        _shareView.frame = mviewRc;
    } completion:^(BOOL finished) {
    }];
    
    CGRect coverrc = _coverView.frame;
    coverrc.origin.y = rect.size.height;
    _coverView.frame = coverrc;
}

#pragma mark - private

- (void)p_copyShareLink
{
    [self p_dismissShareMoreView];
    
    NSString *link = @"the link you want to copy";
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:link];
    
    
    _alertController.title = @"链接已拷贝";
    _alertController.message = link;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:_alertController animated:YES completion:nil];
    });
}

@end
