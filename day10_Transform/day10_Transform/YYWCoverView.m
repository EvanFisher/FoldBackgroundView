//
//  YYWImageView.m
//  day10_Transform
//
//  Created by 余一伟 on 16/6/27.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//

#import "YYWCoverView.h"



@implementation YYWCoverView



+ (void)showWithImage:(UIImage *)image fromFrame:(CGRect)frame;
{
    YYWCoverView *backgroundView = [[YYWCoverView alloc] init];
    
    backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    
    backgroundView.frame = [UIScreen mainScreen].bounds;
    
    

    
    //添加到窗口
    [[UIApplication sharedApplication].keyWindow addSubview:backgroundView];
    
    
    
    
    UIImageView *imageV = [[UIImageView alloc] init];
    //imageV's frame is equal to the icon
    imageV.frame = frame;
    
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    //让图片可点击
    imageV.userInteractionEnabled = YES;
    
    imageV.image = image;
    
    
    [backgroundView addSubview:imageV];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
        
        imageV.frame = [UIScreen mainScreen].bounds;
    }];
    
    //给图片添加手势
     UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    
    [imageV addGestureRecognizer:tapImage];
    
}

+ (void)tapImage:(UITapGestureRecognizer *)tapI
{
   UIView *backgroundView =  [UIApplication sharedApplication].keyWindow.subviews.lastObject;
    
    UIImageView *imageV = backgroundView.subviews.lastObject;
    
    [UIView animateWithDuration:0.5 animations:^{
        backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        imageV.frame = CGRectMake([UIScreen mainScreen].bounds.origin.x + 30, [UIScreen mainScreen].bounds.origin.y + 170, 100, 100);

        
    } completion:^(BOOL finished)
    {
        [backgroundView removeFromSuperview];
    }];

}



@end
