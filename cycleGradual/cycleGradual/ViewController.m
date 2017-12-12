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
@property (nonatomic,strong) UIView *blueBackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBlueView];
    [self setupColorLayer];
    [self setupColorMaskLayer];
    [self setupBlueMaskLayer];
    [self createSlider];
    //[self setStoke];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)createBlueView
{
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 375, 375)];
    _blueBackView = blueView;
    blueView.backgroundColor = [UIColor colorWithRed:147.0/255.0 green:207.0/255.0 blue:248.0/255 alpha:1];
    [self.view addSubview:blueView];
}

-(void)setupColorLayer
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = _blueBackView.bounds;
    _layer = layer;
    //layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    CAGradientLayer *leftColorLayer = [[CAGradientLayer alloc] init];
    leftColorLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor];
    leftColorLayer.locations = @[@0.2,@0.7,@1.0];
    //leftColorLayer.frame = CGRectMake(0, 0, 375/2, 375);
    leftColorLayer.frame = CGRectMake(0, 0, _blueBackView.bounds.size.width/2, _blueBackView.bounds.size.height);
    [layer addSublayer:leftColorLayer];
    
    
    CAGradientLayer *rightColorLayer = [[CAGradientLayer alloc] init];
    rightColorLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor];
    rightColorLayer.locations = @[@0.2,@0.7,@1.0];
    //rightColorLayer.frame = CGRectMake(375/2, 0, 375/2, 375);
    rightColorLayer.frame = CGRectMake(_blueBackView.bounds.size.width/2, 0, _blueBackView.bounds.size.width/2, _blueBackView.bounds.size.height);
    [layer addSublayer:rightColorLayer];
    
    [self.blueBackView.layer addSublayer:layer];
}

-(CAShapeLayer*)createCycleLayer
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    //layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.frame = _blueBackView.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_blueBackView.bounds.size.width/2,_blueBackView.bounds.size.height/2) radius:375/2.5 startAngle:-1.3*M_PI endAngle:0.3*M_PI clockwise:YES];
    layer.path = path.CGPath;
    layer.lineWidth = 20;
    layer.lineCap = kCALineCapRound;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blueColor].CGColor;
    return layer;
}

- (void)setupColorMaskLayer {
    
    CAShapeLayer *layer = [self createCycleLayer];
    layer.lineWidth = 20.5; // 渐变遮罩线宽较大，防止蓝色遮罩有边露出来
    self.layer.mask = layer;
    
    self.colorMaskLayer = [CAShapeLayer layer];
    self.colorMaskLayer = layer;
    layer.strokeEnd = 0.3;
}

- (void)setupBlueMaskLayer {
    
    CAShapeLayer *layer = [self createCycleLayer];
    //self.blueBackView.mask = layer;
    self.blueBackView.layer.mask = layer;
    self.blueMaskLayer = layer;
}

-(void)createSlider
{
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(30, self.view.bounds.size.height-50, self.view.bounds.size.width-60, 20)];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    slider.value = 0.5f;
    [slider addTarget:self action:@selector(setStokeForSlider:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

-(void)setStokeForSlider:(UISlider*)slider
{
    self.colorMaskLayer.strokeEnd = slider.value;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
