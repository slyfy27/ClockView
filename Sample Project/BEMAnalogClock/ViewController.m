//
//  ViewController.m
//  BEMAnalogClockView
//
//  Created by Boris Emorine on 2/23/14.
//  Copyright (c) 2014 Boris Emorine. All rights reserved.
//

#import "ViewController.h"
#import "MTClockView.h"
#import "StringView.h"
#import "FocusSlider.h"

@interface ViewController (){
    CGFloat angle;
}
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSCalendar *calendar;
@property (nonatomic,strong) NSDate *date;


@property (nonatomic, strong) MTClockView *clockView;

@property (nonatomic, strong) UIView *panView;

//@property (nonatomic, strong) FocusSlider *focusSlider;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
//    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){100,200,30,16}];
//    label.font = [UIFont systemFontOfSize:15];
//    label.textColor = [UIColor whiteColor];
////    label.text = @"0.5";
//    [self.view addSubview:label];
//    label.backgroundColor = [UIColor redColor];
//    UILabel *label1 = [[UILabel alloc] initWithFrame:(CGRect){100,200,30,16}];
//    label1.font = [UIFont systemFontOfSize:15];
//    label1.textColor = [UIColor whiteColor];
////    label1.text = @"0.5";
//    label1.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:label1];
//    label.layer.anchorPoint = CGPointMake(0, 0.5);
//    label.transform = CGAffineTransformMakeRotation(M_PI/5);
    angle = 0;
    _clockView = [[MTClockView alloc] initWithFrame:(CGRect){100, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.height}];
//    _clockView = [[MTClockView alloc] initWithFrame:(CGRect){100, 0, 100, 100}];
    [self.view addSubview:_clockView];

    self.panView = [[UIView alloc] initWithFrame:self.clockView.frame];
//    panView.backgroundColor = [UIColor clearColor];
    self.panView.backgroundColor = [UIColor clearColor];
    self.panView.userInteractionEnabled = YES;
    [self.view.viewForBaselineLayout addSubview:self.panView];

    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleClockRotation:)];
//    rotationGesture.delegate = self;
    [self.panView addGestureRecognizer:rotationGesture];

//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleClockPan:)];
//    panGesture.delegate = self;
//    [panGesture setMaximumNumberOfTouches:1];
//    [self.panView addGestureRecognizer:panGesture];
//    [self clipBezi];
    
//    StringView *sv = [[StringView alloc] initWithFrame:(CGRect){100,200,100,40}];
//    [self.view addSubview:sv];
    
    // upSlider
//    FocusSlider *upCircularSlider = [[FocusSlider alloc]initWithFrame:CGRectMake(100, 100, 400, 250)];
//
//    upCircularSlider.lineWidth = 10;
//
//    [self.view addSubview:upCircularSlider];
}

- (void)clipBezi{
    CGSize size = self.panView.frame.size;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor yellowColor] CGColor]];
    UIBezierPath *progresslinePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 120) radius:self.panView.frame.size.width/2 startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    [progresslinePath addArcWithCenter:CGPointMake(50, 120) radius:self.panView.frame.size.width/2 - 60 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    shapeLayer.frame = _panView.frame;
    [shapeLayer setPath:progresslinePath.CGPath];
    self.panView.layer.mask = shapeLayer;//layer的mask，顾名思义，是种位掩蔽，在shapeLayer的填充区域中，alpha值不为零的部分，self会被绘制；alpha值为零的部分，self不会被绘制
//    [progresslinePath closePath];
    self.panView.layer.masksToBounds = NO;
    
//    CAShapeLayer *innershapeLayer = [CAShapeLayer layer];
//    [shapeLayer setFillColor:[[UIColor yellowColor] CGColor]];
//    UIBezierPath *innerprogresslinePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 120) radius:self.panView.frame.size.width/2 - 60 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    innershapeLayer.frame = _panView.frame;
//    [innershapeLayer setPath:innerprogresslinePath.CGPath];
//    self.panView.layer.mask = innershapeLayer;//layer的mask，顾名思义，是种位掩蔽，在shapeLayer的填充区域中，alpha值不为零的部分，self会被绘制；alpha值为零的部分，self不会被绘制
//    //    [progresslinePath closePath];
//    self.panView.layer.masksToBounds = NO;
    [self testRotationString];
}

- (void)testRotationString{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(18, 18));
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(3.6*M_PI/180));
    
    NSString *hourNumber = @"转动起来哦";
    [hourNumber drawInRect:CGRectMake(100,200,100,30) withAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:12]}];
    CGContextRestoreGState(context);
}

- (void)handleClockRotation:(UIRotationGestureRecognizer *)recognizer{
    self.clockView.transform = CGAffineTransformRotate(self.clockView.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

- (void)handleClockPan:(UIPanGestureRecognizer *)recognizer {
    UIView *view = recognizer.view;
    CGPoint translation = [recognizer locationInView:view];
    CGFloat angleInRadians = atan2f(translation.y - view.frame.size.height/2, translation.x - view.frame.size.width/2);
    self.clockView.transform = CGAffineTransformRotate(self.clockView.transform, -angleInRadians);
//    self.clockView.transform = CGAffineTransformMakeRotation(angleInRadians);
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        angle += angleInRadians;
    }
    NSLog(@"angle:%f,angleInRadians:%f",angle,angleInRadians);
}


@end
