//
//  ViewController.m
//  CABasicAnimationDEMO
//
//  Created by xiantian on 16/6/6.
//  Copyright © 2016年 xiantian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    UIImageView * imageviewone;
    
    double  angle;
}

@end

@implementation ViewController




/**
 *  对于iOS来说，坐标系的（0，0）点在左上角，就是越往下，Y值越大。越往右，X值越大。
 
 一个图层的frame，它是position，bounds，anchorPoint和transform属性的一部分。
 
 设置一个新的frame将会相应的改变图层的position和bounds，但是frame本身并没有保存
 
 */





- (void)viewDidLoad {
    [super viewDidLoad];
    
//    缩放动画又三种实现方式。 自选一种
     [self performSelector:@selector(mysouanimation1) withObject:nil afterDelay:0];
    
//    平移动画又三种方式  自选一种
     [self performSelector:@selector(pinganimation1) withObject:nil afterDelay:1];
//    旋转动画  这里举例一种
    
     [self performSelector:@selector(xuanzhuandonghua) withObject:nil afterDelay:2];
    
    
    
    [self  performSelector:@selector(baseAnimation) withObject:nil afterDelay:3];
    
    
    angle =0;
    
}


#pragma －－－－－－－－－－－－－－－－缩放动画－－－－－－－－－－－－－－－－－－－－－－

/**
 *  缩放动画1
 */

-(void)mysouanimation1{
    
    imageviewone = ({
        UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123.jpg"]];
        imageview.frame = CGRectMake(100, 100, 100, 100);
        imageview;
    });
    [self.view addSubview:imageviewone];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.duration =2.0;
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)];
    animation.repeatCount =1000;
    animation.autoreverses = YES;
//    是否返回起点
//    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion =NO;
    
    [imageviewone.layer addAnimation:animation forKey:nil];
}


/**
 *  缩放动画2
 */

-(void)mysouanimation2{
    
    imageviewone = ({
        UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123.jpg"]];
        imageview.frame = CGRectMake(100, 100, 100, 100);
        imageview;
    });
    [self.view addSubview:imageviewone];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration =2.0;
    animation.fromValue =[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1)];
    
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    
    //    是否返回起点
     animation.fillMode=kCAFillModeBackwards;
    animation.removedOnCompletion =NO;
    
    [imageviewone.layer addAnimation:animation forKey:nil];
    
}

/**
 *  缩放动画3
 */

-(void)mysouanimation3{
    
    imageviewone = ({
        UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123.jpg"]];
        imageview.frame = CGRectMake(100, 100, 100, 100);
        imageview;
    });
    [self.view addSubview:imageviewone];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration =2.0;
    
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    
//    animation.toValue =@2;
    //    告诉在动画结束的时候不要移除
    animation.removedOnCompletion =NO;
    
    [imageviewone.layer addAnimation:animation forKey:nil];
    
}


#pragma  －－－－－－－－－－－－－－－－平移动画－－－－－－－－－－－－－－－－－－－－－－


/**
 *  平移动画1
 */


-(void)pinganimation1{
    imageviewone = ({
        UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"456.jpg"]];
        imageview.frame = CGRectMake(20, 250, 100, 100);
        imageview;
    });
    [self.view addSubview:imageviewone];
    
    
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"position"];
    
    animation.duration =2.0;
    animation.toValue =[ NSValue  valueWithCGPoint:CGPointMake(250, 300)] ;
    animation.delegate =self;
    
    animation.repeatCount =1000;
    animation.autoreverses = YES;

    
    animation.removedOnCompletion =NO;
    animation.fillMode =kCAFillModeForwards;
    [imageviewone.layer addAnimation:animation forKey:nil];
    
}

/**
 *  平移动画2
 
 CATransform3D CATransform3DMakeTranslation (CGFloat tx, CGFloat ty, CGFloat tz)。
 
 做一个解释，对于初学者来说，可能没有看明白是什么意思。我详细说下
 
 对于CATransform3D来说，它是一个4x4 CGFloat的矩阵。
 
 而上面给的值：[1 0 0 0; 0 1 0 0; 0 0 1 0; tx ty tz 1].
 
 给竖起来后。就发现：
 
 1    0    0    0
 
 0    1    0    0
 
 0    0    1    0
 
 tx  ty  tz  1
 
 竖起来看就很明显了。
 
 CATransform3D 又是一个结构。他有自己的一个公式，可以进行套用。
 
 struct CATransform3D
 
 {
 
 CGFloat    m11（x缩放）,    m12（y切变）,      m13（旋转）,    m14（）;
 
 CGFloat    m21（x切变）,    m22（y缩放）,      m23（）       ,    m24（）;
 
 CGFloat    m31（旋转）  ,    m32（ ）       ,      m33（）       ,    m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
 
 CGFloat    m41（x平移）,    m42（y平移）,    m43（z平移） ,    m44（）;
 
 };
 
 根据这个公式，就一目了然了。
 
 CATransform3D CATransform3DMakeTranslation (CGFloat tx, CGFloat ty, CGFloat tz)
 
 的参数意思就是
 
 tx:：x平移。  ty：y平移。  tz：z平移
 
 
 
 换换函数：
 
 CATransform3D CATransform3DMakeTranslation (CGFloat tx, CGFloat ty, CGFloat tz)
 
 tx：X轴偏移位置，往下为正数。
 
 ty：Y轴偏移位置，往右为正数。
 
 tz：Z轴偏移位置，往外为正数。
 
 */


-(void)pinganimation2{
    imageviewone = ({
        UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"456.jpg"]];
        imageview.frame = CGRectMake(20, 250, 100, 100);
        imageview;
    });
    [self.view addSubview:imageviewone];
    

    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.duration =2.0;
    
    animation.toValue =[ NSValue  valueWithCATransform3D:CATransform3DMakeTranslation(150, 0, 0)] ;
    
    animation.removedOnCompletion =NO;
    animation.fillMode =kCAFillModeForwards;
    [imageviewone.layer addAnimation:animation forKey:nil];
    
}


/**
 *  修改layer的可动画属性
 */

-(void)pinganimation3{
    imageviewone = ({
        UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"456.jpg"]];
        imageview.frame = CGRectMake(20, 250, 100, 100);
        imageview;
    });
    [self.view addSubview:imageviewone];
    
    [UIView animateWithDuration:2.0 animations:^{
        imageviewone.layer.position =CGPointMake(250,300);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}


#pragma  －－－－－－－－－－－－－－－－旋转动画－－－－－－－－－－－－－－－－－－－－－－



-(void)xuanzhuandonghua{
    
    
    imageviewone = ({
        UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123.jpg"]];
        imageview.frame = CGRectMake(100, 400, 100, 100);
        imageview;
    });
    [self.view addSubview:imageviewone];
    
//    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.duration =3.0;
//    
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(imageviewone.layer.transform ,M_PI , 0, 0, 1)];
//    animation.repeatCount =2;
//    
//    [imageviewone.layer  addAnimation:animation forKey:nil];
    
     [NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector:@selector(transformAction) userInfo: nil repeats: YES];
  
}

-(void)transformAction{
    angle = angle + 0.01;//angle角度 double angle;
    if (angle > 6.28) {//大于 M_PI*2(360度) 角度再次从0开始
        angle = 0;
    }
    CGAffineTransform transform=CGAffineTransformMakeRotation(angle);
    imageviewone.transform = transform;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma －－－－－－－－－－－－－－－－闪烁动画－－－－－－－－－－－－－－－－－－－－－－


// 闪烁动画
- (void)baseSpringAnimation {
    

        UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123.jpg"]];
        imageview.frame = CGRectMake(0, 50, 50, 50);
        
        imageview.layer.borderColor = [UIColor greenColor].CGColor;
        imageview.layer.borderWidth = 2;
        imageview.backgroundColor = [UIColor redColor];
    

    [self.view addSubview:imageview];
  
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 2;
    animation.fromValue = @(1);
    animation.toValue = @(0);
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [imageview.layer addAnimation:animation forKey:@"opacity"];
}


#pragma －－－－－－－－－－－－－－－－路径动画－－－－－－－－－－－－－－－－－－－－－－


// 路径动画
- (void)baseAnimation {
    
    UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"456.jpg"]];
    imageview.frame = CGRectMake(200, 20, 100, 100);
    imageview.layer.borderWidth = 2;
    imageview.layer.borderColor = [UIColor redColor].CGColor;
    imageview.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imageview];
    
    // 添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 起点，这个值是指position，也就是layer的中心值
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    // 终点，这个值是指position，也就是layer的中心值
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width - 50,
                                                              self.view.bounds.size.height - 100)];
    // byValue与toValue的区别：byValue是指x方向再移动到指定的宽然后y方向移动指定的高
    // 而toValue是整体移动到指定的点
    //  animation.byValue = [NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width - 50 - 50,
    //                                                            self.view.bounds.size.height - 50 - 50 - 50)];
    // 线性动画
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    
    // 设定开始值到结束值花费的时间，也就是动画时长，单位为秒
    animation.duration = 2;
    
    // 播放速率，默认为1，表示常速
    // 设置为2则以2倍的速度播放，同样设置为N则以N倍速度播放
    // 如果值小于1，自然就是慢放
    animation.speed = 0.5;
    
    // 开始播放动画的时间，默认为0.0，通常是在组合动画中使用
    animation.beginTime = 0.0;
    
    // 播放动画的次数，默认为0，表示只播放一次
    // 设置为3表示播放3次
    // 设置为HUGE_VALF表示无限动画次数
    animation.repeatCount = HUGE_VALF;
    
    // 默认为NO，设置为YES后，在动画达到toValue点时，就会以动画由toValue返回到fromValue点。
    // 如果不设置或设置为NO，在动画到达toValue时，就会突然马上返回到fromValue点
    animation.autoreverses = YES;
    
    // 当autoreverses设置为NO时，最终会留在toValue处
    animation.fillMode = kCAFillModeForwards;
    // 将动画添加到层中
    [imageview.layer addAnimation:animation forKey:@"position"];
}












@end
