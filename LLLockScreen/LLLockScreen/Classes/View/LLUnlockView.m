//
//  LLUnlockView.m
//  LL----锁屏
//
//  Created by liushaohua on 16/9/1.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import "LLUnlockView.h"

@interface LLUnlockView ()

@property (nonatomic, assign)CGPoint currentPoint;

@end


@implementation LLUnlockView{

    NSMutableArray<UIButton *> *_arrMBtn;

}


- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setUI];
    }
   
    _arrMBtn = [NSMutableArray array];
    return self;
}


#pragma 清楚数组
- (void)clearLock
{
    [_arrMBtn enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    
    [_arrMBtn removeAllObjects];
    NSLog(@"%zd",_arrMBtn.count);
    
    [self setNeedsDisplay];
}


#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint loc = [touches.anyObject locationInView:self];
  
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isContain = CGRectContainsPoint(obj.frame, loc);
        if ( isContain  ) {
            obj.selected = YES;
            
            [_arrMBtn addObject:obj];
        }
    }];
    //需要重绘
//    [self setNeedsDisplay];
}
#pragma mark - 移动事件
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint loc = [touches.anyObject locationInView:self];
    _currentPoint = loc;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isContain = CGRectContainsPoint(obj.frame, loc);
        if ( isContain & ![_arrMBtn containsObject:obj] ) {
            obj.selected = YES;

                [_arrMBtn addObject:obj];
            
        }
    }];
    [self setNeedsDisplay];
    

}
#pragma mark - 结束事件
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _currentPoint  = [_arrMBtn.lastObject center];
    [self setNeedsDisplay];
    
    NSMutableString *psd = [NSMutableString string];
    
    [_arrMBtn enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [self.subviews indexOfObject:obj];
        [psd appendFormat:@"%zd",index];
    }];
    
    
    
    
    
    

    if ([_delegate respondsToSelector:@selector(UnlockView:psd:)]) {
        [_delegate UnlockView:self psd:psd];
    }
    


}


#pragma mark - 绘图
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [_arrMBtn enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [path moveToPoint:obj.center];
        }
        
            [path addLineToPoint:obj.center];

    }];
    
    if (_arrMBtn.count > 0) {
        [path addLineToPoint:_currentPoint];
    }
   
    path.lineWidth = 5;
    [[UIColor greenColor] setStroke];
    [path stroke];
    
}



#pragma mark - 搭建界面
- (void)setUI{

    //创建按钮
    for (NSInteger i = 0; i<9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
    }
    
}


#pragma  mark - 设置子控件
- (void)layoutSubviews
{
    //一定要记得super 
    [super layoutSubviews];

    NSInteger columns = 3;
    CGFloat btnW = 74;
    CGFloat btnH = 74;
    //间距
    CGFloat margin = (self.frame.size.width - btnW * 3) * 0.5;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat  col = idx % columns;
        CGFloat row = idx / columns;
        CGFloat X = (btnW + margin) * col;
        CGFloat Y = (btnH + margin) * row;
        obj.frame = CGRectMake(X, Y, btnW, btnH);
    
    }];

}












@end
