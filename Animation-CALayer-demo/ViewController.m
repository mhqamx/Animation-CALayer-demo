//
//  ViewController.m
//  Animation-CALayer-demo
//
//  Created by 马霄 on 1/13/16.
//  Copyright © 2016 马 霄. All rights reserved.
//
#define kLayerWidth 50
#define kPhotowidth 100
#import "ViewController.h"

@interface ViewController ()
/** layer动画 */
@property (nonatomic, strong) CALayer *movableCircleLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawImageWithContent];
    [self baseRotationAnimation];
    [self baseTranslationAnimation];
    [self baseSpringAnimation];
    [self baseScaleAnimation];
    [self baseAnimation];
}

- (void)initLayer {
    // 1.初始化calayer
    self.movableCircleLayer = [CALayer layer];
    // 2.指定大小
    self.movableCircleLayer.bounds = CGRectMake(0, 0, kLayerWidth, kLayerWidth);
    // 3.指定中心点
    self.movableCircleLayer.position = self.view.center;
    // 4.改为圆形
    self.movableCircleLayer.cornerRadius = kLayerWidth * 0.5;
    // 5.指定背景颜色
    self.movableCircleLayer.backgroundColor = [UIColor blueColor].CGColor;
    // 6.设置阴影
    self.movableCircleLayer.shadowColor = [UIColor grayColor].CGColor;
    self.movableCircleLayer.shadowOffset = CGSizeMake(3, 3);
    self.movableCircleLayer.shadowOpacity = 0.8;
    // 7.添加到视图上
    [self.view.layer addSublayer:self.movableCircleLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat width = kLayerWidth;
    if (self.movableCircleLayer.bounds.size.width <= kLayerWidth) {
        width = kLayerWidth * 2.5;
    }
    
    // 修改大小
    self.movableCircleLayer.bounds = CGRectMake(0, 0, width, width);
    // 将中心位置放到点击位置
    self.movableCircleLayer.position = [[touches anyObject] locationInView:self.view];
    // 再修改圆形
    self.movableCircleLayer.cornerRadius = width * 0.5;
}

- (void)drawImageWithContent {
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, kPhotowidth, kPhotowidth);
    layer.position = self.view.center;
    layer.cornerRadius = kPhotowidth * 0.5;
    layer.masksToBounds = YES;
    // 要设置此属性才能剪辑成圆形, 但是添加此属性后,下面设置的阴影就没有了
    layer.borderColor = [UIColor redColor].CGColor;
    layer.borderWidth = 1;
    
    // 如果只是显示图片, 不做其他处理, 直接设置contents就可以了, 也就不会出现绘图和图像倒立的问题了
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"test"].CGImage);
    
    [self.view.layer addSublayer:layer];
}

/** 平移动画 */
- (void)baseTranslationAnimation {
    UIView *springView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 50, 50)];
    [self.view addSubview:springView];
    springView.layer.borderColor = [UIColor redColor].CGColor;
    springView.layer.borderWidth = 1;
    springView.backgroundColor = [UIColor yellowColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.duration = 2;
    
    // Z轴旋转180度
    CGFloat width = self.view.frame.size.width;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(width - 50, 0)];
    
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [springView.layer addAnimation:animation forKey:@"transform.translation"];
}

/** 旋转动画 */
- (void)baseRotationAnimation {
    UIView *springView = [[UIView alloc] initWithFrame:CGRectMake(0, 240, 50, 50)];
    [self.view addSubview:springView];
    springView.layer.borderColor = [UIColor greenColor].CGColor;
    springView.layer.borderWidth = 1;
    springView.backgroundColor = [UIColor orangeColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 2;
    
    // Z轴旋转180度
    CATransform3D transform3D = CATransform3DMakeRotation(3.1415926, 0, 0, 180);
    animation.toValue = [NSValue valueWithCATransform3D:transform3D];
    
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [springView.layer addAnimation:animation forKey:@"transform"];
}

/** 缩放动画 */
- (void)baseScaleAnimation {
    UIView *springView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 50, 50)];
    [self.view addSubview:springView];
    springView.layer.borderWidth = 1;
    springView.layer.borderColor = [UIColor blueColor].CGColor;
    springView.backgroundColor = [UIColor greenColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 2;
    animation.fromValue = @(1);
    animation.toValue = @(0);
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [springView.layer addAnimation:animation forKey:@"transform.scale"];
}

/** 闪烁动画 */
- (void)baseSpringAnimation {
    UIView *springView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 50, 50)];
    [self.view addSubview:springView];
    
    springView.layer.borderColor = [UIColor blackColor].CGColor;
    springView.layer.borderWidth = 1;
    springView.layer.backgroundColor = [UIColor cyanColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 2;
    animation.fromValue = @(1);
    animation.toValue = @(0);
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [springView.layer addAnimation:animation forKey:@"opacity"];
}

/** 路径动画 */
- (void)baseAnimation {
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    animationView.layer.borderWidth = 1;
    animationView.layer.borderColor = [UIColor redColor].CGColor;
    animationView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    animationView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"test"]).CGImage;
    [self.view addSubview:animationView];
    
    // 添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 起点, 这个值是指position, 也就是layer的中心值
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    // 终点, 这个值是指position, 也就是layer的中心值
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width - 50, self.view.bounds.size.height - 100)];
    
    // byValue与toValue的区别:byValue是指x方向再移动到指定的宽然后y方向移动到指定的高
    // 而toValue是整体移动到指定的点
    // 线性动画
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    
    // 设定开始值到结束值得时间, 也就是动画时长, 单位为s
    animation.duration = 2;
    
    // 播放速率, 默认为1, 表示常速
    // 设置为2则为2倍的自然速率
    // 如果小于1, 就是慢放
    animation.speed = 0.5;
    
    // 开始播放动画的时间, 默认为0.0, 通常是在组合动画中使用
    animation.beginTime = 0.0;
    
    // 播放动画的次数, 默认为0, 表示只播放1次
    // 设置为3表示播放三次
    // 设置HUGE_VALF 表示无限播放
    animation.repeatCount = HUGE_VALF;
    
    // 默认为NO, 设置为YES之后, 在动画达到toValue点时, 就会以动画有toValue返回到fromeValue点
    // 如果不设置或是设置为NO, 在动画达到toValue之后会突然返回fromValue点
    animation.autoreverses = YES;
    
    // 当autoreverses设置为NO时, 最终会留在toValue处
    animation.fillMode = kCAFillModeForwards;
    
    // 将动画添加到图层中
    [animationView.layer addAnimation:animation forKey:@"position"];
    
}


@end
