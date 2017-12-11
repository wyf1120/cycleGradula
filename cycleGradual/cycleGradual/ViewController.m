//
//  ViewController.m
//  cycleGradual
//
//  Created by wyf on 2017/12/9.
//  Copyright © 2017年 wyf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) CAShapeLayer *layer;
@property (nonatomic,strong) CAShapeLayer *colorMaskLayer;
@property (nonatomic,strong) CAShapeLayer *blueMaskLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self createBlueView];
    [self setupColorLayer];
//    [self setupColorMaskLayer];
//    [self setupBlueMaskLayer];
//    [self setStoke];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)createBlueView
{
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 375, 375)];
    [self.view addSubview:blueView];
}

-(void)setupColorLayer
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    _layer = layer;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    CAGradientLayer *leftColorLayer = [[CAGradientLayer alloc] init];
    leftColorLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor];
    leftColorLayer.locations = @[@0.2,@0.7,@1.0];
    leftColorLayer.frame = CGRectMake(0, 100, 375/2, 375);
    [layer addSublayer:leftColorLayer];
    
    
    CAGradientLayer *rightColorLayer = [[CAGradientLayer alloc] init];
    rightColorLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor];
    rightColorLayer.locations = @[@0.2,@0.7,@1.0];
    rightColorLayer.frame = CGRectMake(375/2, 100, 375/2, 375);
    [layer addSublayer:rightColorLayer];
    
    [self.view.layer addSublayer:layer];
}

-(CAShapeLayer*)createCycleLayer
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(375/2, 100+375/2) radius:375/2 startAngle:-3/4*M_PI endAngle:-1/3*M_PI clockwise:YES];
    layer.path = path.CGPath;
    layer.lineWidth = 20;
    layer.lineCap = kCALineCapRound;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    return layer;
}

- (void)setupColorMaskLayer {
    
    CAShapeLayer *layer = [self createCycleLayer];
    layer.lineWidth = 20.5; // 渐变遮罩线宽较大，防止蓝色遮罩有边露出来
    self.layer.mask = layer;
    
    self.colorMaskLayer = [CAShapeLayer layer];
    self.colorMaskLayer = layer;
}

- (void)setupBlueMaskLayer {
    
    CAShapeLayer *layer = [self createCycleLayer];
    self.layer.mask = layer;
    self.blueMaskLayer = layer;
    
    
}

-(void)setStoke
{
    self.colorMaskLayer.strokeEnd = 0.5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
