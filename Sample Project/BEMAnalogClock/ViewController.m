//
//  ViewController.m
//  BEMAnalogClockView
//
//  Created by Boris Emorine on 2/23/14.
//  Copyright (c) 2014 Boris Emorine. All rights reserved.
//

#import "ViewController.h"
#import "MTClockView.h"

@interface ViewController ()
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSCalendar *calendar;
@property (nonatomic,strong) NSDate *date;


@property (nonatomic, strong) MTClockView *clockView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _clockView = [[MTClockView alloc] initWithFrame:(CGRect){10, 50, 300, 300}];
    [self.view addSubview:_clockView];
    
    UIView *panView = [[UIView alloc] initWithFrame:self.clockView.frame];
    panView.backgroundColor = [UIColor clearColor];
    [self.view.viewForBaselineLayout addSubview:panView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleClockPan:)];
    panGesture.delegate = self;
    [panGesture setMaximumNumberOfTouches:1];
    [panView addGestureRecognizer:panGesture];
}

- (void)handleClockPan:(UIPanGestureRecognizer *)recognizer {
    UIView *view = recognizer.view;
    CGPoint translation = [recognizer locationInView:view];
    CGFloat angleInRadians = atan2f(translation.y - view.frame.size.height/2, translation.x - view.frame.size.width/2);
    
    self.clockView.transform = CGAffineTransformMakeRotation(angleInRadians + M_PI/2);
}


@end
