//
//  ViewController.m
//  day10_Transform
//
//  Created by 余一伟 on 16/6/26.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//

#import "ViewController.h"
#import "YYWCoverView.h"
#import "YYWFrontView.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) YYWFrontView *frontV;
@property (weak, nonatomic) IBOutlet UIView *behindV;

@property (nonatomic, strong) CALayer *shadowLayer;
@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self plusShadowLayer];
    
    self.frontV = [YYWFrontView frontView];
    self.imageV = self.frontV.iconV;
    [self.view addSubview:self.frontV];
    
    [self addTapGesture];
    
    [self addTapGestureForImage];
}




/** 给图片添加点击手势 */
- (void)addTapGestureForImage
{
    UITapGestureRecognizer *tapI = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapI:)];

    [self.imageV addGestureRecognizer:tapI];
    
}

- (void)tapI:(UITapGestureRecognizer *)tapI
{
    
  [YYWCoverView showWithImage:self.imageV.image fromFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x + 30, [UIScreen mainScreen].bounds.origin.y + 170, 100, 100)];
   
}


/** 给后面的View添加阴影层 */
- (void)plusShadowLayer
{
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.frame = self.behindV.bounds;
    
    shadowLayer.opacity = 0.2;
    
    [self.behindV.layer addSublayer:shadowLayer];
    self.shadowLayer = shadowLayer;

}



//点击Button
- (IBAction)clickButton:(UIButton *)sender
{
    //修改锚点
    self.behindV.layer.anchorPoint = CGPointMake(0.5, 0);
    self.behindV.layer.position = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, 0);
    

    [[UIApplication sharedApplication].keyWindow addSubview:self.frontV];

    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frontV.transform = CGAffineTransformIdentity;

        self.shadowLayer.backgroundColor = [UIColor blackColor].CGColor;

    }];
    
    
    [UIView animateWithDuration:0.25 animations:^{

        self.behindV.frame = CGRectMake(self.behindV.bounds.origin.x                              , self.behindV.bounds.origin.y+30, self.behindV.bounds.size.width, self.behindV.bounds.size.height);
        
        CATransform3D transform = CATransform3DIdentity;
        
        //眼睛离屏幕的距离.(近大远小.)
        transform.m34 = 1 / 1000.0;
        
        self.behindV.layer.transform = CATransform3DRotate(transform, 7*M_PI/180.0, 1, 0, 0);

        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.behindV.layer.transform = CATransform3DMakeScale(0.85, 0.85, 1);
        }];
        
    }];
    
}




/** 给behindView添加点击手势 */

- (void)addTapGesture
{
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    tapG.delegate = self;
    
    [self.behindV addGestureRecognizer:tapG];
    
    
}

//点击后面的View
- (void)tap:(UITapGestureRecognizer *)tap
{
    
    self.behindV.layer.anchorPoint = CGPointMake(0.5, 1);
    self.behindV.layer.position = CGPointMake(self.behindV.bounds.size.width*0.5, self.behindV.frame.size.height+30);
    
 
    
    [UIView animateWithDuration:0.5 animations:^{
        
         self.frontV.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        
        
        self.shadowLayer.backgroundColor = [UIColor whiteColor].CGColor;

    }];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CATransform3D transform = CATransform3DIdentity;
        
        transform.m34 = -1 / 1000.0;
        self.behindV.layer.transform = CATransform3DRotate(transform, 4*M_PI/180.0, 1, 0, 0);

    self.behindV.frame = CGRectMake(self.behindV.bounds.origin.x                                        , self.behindV.bounds.origin.y, self.behindV.bounds.size.width, self.behindV.bounds.size.height);
        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
      
            self.behindV.layer.transform = CATransform3DMakeScale(1, 1, 1);
      
        }];
    }];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"%lu", [UIApplication sharedApplication].keyWindow.subviews.count);

        [self.frontV removeFromSuperview];

        NSLog(@"%lu", [UIApplication sharedApplication].keyWindow.subviews.count);

    });
    
}


//什么情况下允许点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //如果 窗口的最后一个元素是frontView 就可以点击!
    return [[UIApplication sharedApplication].keyWindow.subviews.lastObject isEqual:self.frontV] ;
}


@end
