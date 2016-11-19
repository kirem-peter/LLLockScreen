//
//  LLUnlockScreenController.m
//  LL----锁屏
//
//  Created by liushaohua on 16/9/1.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import "LLUnlockScreenController.h"
#import "Masonry.h"
#import "LLUnlockView.h"
#import "SVProgressHUD.h"
@interface LLUnlockScreenController ()<LLUnlockViewDelegate>

@end

@implementation LLUnlockScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    
    
    //创建一个锁屏View
    LLUnlockView *lockV = [[LLUnlockView alloc]init];
    lockV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lockV];
    [lockV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(300);
    }];
    
    lockV.delegate = self;
}



- (void)UnlockView:(LLUnlockView *)lockV psd:(NSString *)psd
{
    //偏角设置保存
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *psdStr = [defaults objectForKey:@"psd_lock"];
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.3];
    if (psdStr.length == 0) {
        [defaults setObject:psd forKey:@"psd_lock"];
        NSLog(@"保存成功");
        [lockV clearLock];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        return;
    }
    
    if ([psd isEqualToString:psdStr]) {
        NSLog(@"恭喜你");
        [SVProgressHUD showSuccessWithStatus:@"恭喜你"];

        
    }else
    {
        NSLog(@"错误");
        [SVProgressHUD showErrorWithStatus:@"错误"];
        [lockV clearLock];
    }
    

}










@end
