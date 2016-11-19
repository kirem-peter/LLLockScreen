//
//  LLUnlockView.h
//  LL----锁屏
//
//  Created by liushaohua on 16/9/1.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLUnlockView;
@protocol LLUnlockViewDelegate <NSObject>

@optional
- (void) UnlockView:(LLUnlockView *)lockV psd:(NSString *)psd;

@end

@interface LLUnlockView : UIView

@property (nonatomic, weak)id<LLUnlockViewDelegate> delegate;

- (void)clearLock;

@end
