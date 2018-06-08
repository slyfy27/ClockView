//
//  StringView.m
//  BEMAnalogClock
//
//  Created by wushuying on 2018/6/8.
//  Copyright © 2018年 Boris Emorine. All rights reserved.
//

#import "StringView.h"

@implementation StringView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(18, 18));
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(3.6*M_PI/180));
    
    NSString *hourNumber = @"转动起来哦";
    [hourNumber drawInRect:CGRectMake(0,0,100,40) withAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:12]}];
    CGContextRestoreGState(context);
}


@end
