//
//  YYWFrontView.m
//  day10_Transform
//
//  Created by Fisher on 16/6/28.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//

#import "YYWFrontView.h"

@implementation YYWFrontView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        
        self.frame = CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y + 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        self.backgroundColor = [UIColor grayColor];
        
        self.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(2, -5);
        
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        imageV.frame = CGRectMake(self.frame.origin.x + 30, self.bounds.origin.y - 30, 100, 100);
        
        imageV.image = [UIImage imageNamed:@"6aee3d8bade0b3a4d62d290182750dc2"];
        
        imageV.userInteractionEnabled = YES;
        
        [self addSubview:imageV];
        
        self.iconV = imageV;
    }
    return self;
}

+ (instancetype)frontView
{
    return [[self alloc]init];
}


//点在imageV上, 就让imageV处理事件.
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint imageP = [self convertPoint:point toView:self.iconV];
    
    if ([self.iconV pointInside:imageP withEvent:event]) return self.iconV;
    
    else return [super hitTest:point withEvent:event];
}










@end
