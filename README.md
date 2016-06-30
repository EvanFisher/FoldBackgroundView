# FoldBackgroundView
##模仿淘宝和京东APP在选择商品详情时, 折叠后面的视图(OC实现).


<br />
## 效果图:
![Mou icon](https://github.com/EvanFisher/FoldBackgroundView/raw/master/Logo/Fold.gif)

<br />
<br />
##关键思路:
- 背景视图有一个距离屏幕远近变换的效果, 所以这里必须要用到Transform.m34这个属性.
- 背景视图旋转时, 分别绕顶部和底部旋转, 所以需要修改图层的anchorPoint属性.
- 点击图片时, 由于子控件超出父控件, 所以子控件并不能响应点击事件, 这时响应点击事件的是背景视图, 这里需要使用hitTest:方法来改变事件的响应者.
<br />
<br />

##核心代码:
```
 //修改锚点
    self.behindV.layer.anchorPoint = CGPointMake(0.5, 0);
    self.behindV.layer.position = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, 0);

```
```

	CATransform3D transform = CATransform3DIdentity;
        
	//眼睛离屏幕的距离.(近大远小.)
	transform.m34 = 1 / 1000.0;
        
	self.behindV.layer.transform = CATransform3DRotate(transform, 7*M_PI/180.0, 1, 0, 0);
```
```
//如果当前的点在imageV上, 就让imageV处理事件.
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint imageP = [self convertPoint:point toView:self.iconV];
    
    if ([self.iconV pointInside:imageP withEvent:event]) return self.iconV;
    
    else return [super hitTest:point withEvent:event];
}

```














