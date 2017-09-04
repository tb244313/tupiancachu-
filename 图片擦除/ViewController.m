//
//  ViewController.m
//  图片擦除
//
//  Created by apple on 2017/9/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageV.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.imageV addGestureRecognizer:pan];
    
}


-(void)pan:(UIPanGestureRecognizer *)pan
{

    //获取当前手指所在的点
    CGPoint curP = [pan locationInView:self.imageV];
    CGFloat rectWH = 30;
    CGFloat x = curP.x - rectWH * 0.5;
    CGFloat y = curP.y - rectWH * 0.5;
    
    CGRect rect = CGRectMake(x, y, rectWH, rectWH);
    
    //开启一个图片上下文
    UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //把UIImageView上面的图片给绘制到上下文
    [self.imageV.layer renderInContext:ctx];
    
    //确定擦除区域
    CGContextClearRect(ctx, rect);
    
    //生成一张新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //把上下文给关闭
    UIGraphicsEndImageContext();
    
    self.imageV.image = newImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
