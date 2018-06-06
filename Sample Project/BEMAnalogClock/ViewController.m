//
//  ViewController.m
//  BEMAnalogClockView
//
//  Created by Boris Emorine on 2/23/14.
//  Copyright (c) 2014 Boris Emorine. All rights reserved.
//

#import "ViewController.h"
#import "MTClockView.h"

@interface ViewController (){
    CGFloat angle;
}
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSCalendar *calendar;
@property (nonatomic,strong) NSDate *date;


@property (nonatomic, strong) MTClockView *clockView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    angle = 0;
    _clockView = [[MTClockView alloc] initWithFrame:(CGRect){400, 30, 300, 300}];
    [self.view addSubview:_clockView];
    
    UIView *panView = [[UIView alloc] initWithFrame:self.clockView.frame];
    panView.backgroundColor = [UIColor clearColor];
    panView.userInteractionEnabled = YES;
    [self.view.viewForBaselineLayout addSubview:panView];
    
//    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleClockRotation:)];
////    rotationGesture.delegate = self;
//    [panView addGestureRecognizer:rotationGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleClockPan:)];
    panGesture.delegate = self;
    [panGesture setMaximumNumberOfTouches:1];
    [panView addGestureRecognizer:panGesture];
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
