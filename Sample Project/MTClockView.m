//
//  MTClockView.m
//  BEMAnalogClock
//
//  Created by wushuying on 2018/6/5.
//  Copyright © 2018年 Boris Emorine. All rights reserved.
//

#import "MTClockView.h"

@implementation MTClockView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.borderWidth = 60;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Drawings

- (void)drawRect:(CGRect)rect {
    // CLOCK'S FACE
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextSetAlpha(ctx, 0.5);
    CGContextFillPath(ctx);
    
//     CLOCK'S BORDER
    CGContextAddEllipseInRect(ctx, CGRectMake(rect.origin.x + self.borderWidth/2, rect.origin.y + self.borderWidth/2, rect.size.width - self.borderWidth, rect.size.height - self.borderWidth));
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetAlpha(ctx, 0.5);
    CGContextSetLineWidth(ctx,self.borderWidth);
    CGContextStrokePath(ctx);

    // CLOCK'S GRADUATION
    for (int i = 0; i<100; i++) {
        self.graduationLength = 10;
        
        CGFloat graduationOffset = 10;
        
        CGPoint P1 = CGPointMake((self.frame.size.width/2 + ((self.frame.size.width - 2*2 - graduationOffset) / 2) * cos((3.6*i)*(M_PI/180))), (self.frame.size.width/2 + ((self.frame.size.width - 2*2 - graduationOffset) / 2) * sin((3.6*i)*(M_PI/180) )));
        int tmp = 2;
        if (i % 10 == 0) {
            tmp = 6;
        }
        CGPoint P2 = CGPointMake((self.frame.size.width/2 + ((self.frame.size.width - tmp*2 - graduationOffset - self.graduationLength) / 2) * cos((3.6*i)*(M_PI/180))), (self.frame.size.width/2 + ((self.frame.size.width - tmp*2 - graduationOffset - self.graduationLength) / 2) * sin((3.6*i)*(M_PI/180))));
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        shapeLayer.path = path1.CGPath;
        [path1 setLineWidth:1.0];
        [path1 moveToPoint:P1];
        [path1 addLineToPoint:P2];
        path1.lineCapStyle = kCGLineCapSquare;
        [[UIColor whiteColor] set];
        
        [path1 strokeWithBlendMode:kCGBlendModeNormal alpha:1];
    }
    
    // DIGIT DRAWING
    
    UIFont *digitFont = [UIFont systemFontOfSize:9];
    CGFloat digitOffset = 0;
    
    CGPoint center = CGPointMake(rect.size.width/2.0f, rect.size.height/2.0f);
    NSLog(@"centerX:%f\n",center.x);
    CGFloat markingDistanceFromCenter = rect.size.width/2.0f - digitFont.lineHeight/4.0f - 15 + digitOffset;
    NSLog(@"markingDistanceFromCenter:%f\n",markingDistanceFromCenter);
    NSInteger offset = 0;
    
    for(int i = 0; i < 10; i ++){
        CGContextSaveGState(ctx);
//        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(18, 18));
//        CGContextConcatCTM(context, CGAffineTransformMakeRotation(3.6*M_PI/180));

        NSString *hourNumber = [NSString stringWithFormat:@"0.%d",i];
        CGFloat labelX = center.x + (markingDistanceFromCenter - digitFont.lineHeight/2.0f) * cos((M_PI/180) * (i+offset) * 36 - M_PI);
        CGFloat labelY = center.y + - 1 * (markingDistanceFromCenter - digitFont.lineHeight/2.0f) * sin((M_PI/180)*(i+offset) * 36);
//        if (i == 1) {
//            CGContextConcatCTM(ctx, CGAffineTransformMakeRotation(M_PI/5));
//            labelX = center.x + (markingDistanceFromCenter - digitFont.lineHeight/2.0f) * cos((M_PI/180) * (i+offset) * 36 - M_PI) * cos((M_PI/180) * (i+offset) * 36 - M_PI);
//            labelY = center.y + - 1 * (markingDistanceFromCenter - digitFont.lineHeight/2.0f) * sin((M_PI/180)*(i+offset) * (72));
////            labelX += 38;
////            labelY -= 44;
//        }
//        if (i == 2) {
//            CGContextConcatCTM(ctx, CGAffineTransformMakeRotation(M_PI * 2/5));
//            labelX -= 51;
//            labelY -= 132;
//        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX - digitFont.lineHeight/2,labelY - digitFont.lineHeight/2,15,digitFont.lineHeight)];
        if (i == 1) {
            label.frame = CGRectMake(labelX - digitFont.lineHeight/2,labelY - digitFont.lineHeight/2 + 0.5,15,digitFont.lineHeight);
        }
        if (i == 2) {
            label.frame = CGRectMake(labelX - digitFont.lineHeight/2 - 0.5,labelY - digitFont.lineHeight/2 + 1.5,15,digitFont.lineHeight);
        }
        if (i == 3) {
            label.frame = CGRectMake(labelX - digitFont.lineHeight/2 - 1.5,labelY - digitFont.lineHeight/2 + 3,15,digitFont.lineHeight);
        }
        if (i == 4) {
            label.frame = CGRectMake(labelX - digitFont.lineHeight/2 - 3.5,labelY - digitFont.lineHeight/2 + 2.5,15,digitFont.lineHeight);
        }
        if (i == 5) {
            label.frame = CGRectMake(labelX - digitFont.lineHeight/2 - 5,labelY - digitFont.lineHeight/2,15,digitFont.lineHeight);
        }
        if (i == 6) {
            label.frame = CGRectMake(labelX - digitFont.lineHeight/2 - 4.5,labelY - digitFont.lineHeight/2,15,digitFont.lineHeight);
        }
        if (i == 7) {
            label.frame = CGRectMake(labelX - digitFont.lineHeight/2 - 3.5,labelY - digitFont.lineHeight/2 - 1,15,digitFont.lineHeight);
        }
        if (i == 8) {
            label.frame = CGRectMake(labelX - digitFont.lineHeight/2 - 1.5,labelY - digitFont.lineHeight/2 - 1,15,digitFont.lineHeight);
        }
        if (i == 9) {
            label.frame = CGRectMake(labelX - digitFont.lineHeight/2,labelY - digitFont.lineHeight/2 - 0.5,15,digitFont.lineHeight);
        }
        label.textColor = [UIColor whiteColor];
        label.font = digitFont;
        label.text = hourNumber;
//        label.layer.anchorPoint = CGPointMake(0, 0.5);
//        [hourNumber drawInRect:CGRectMake(labelX - digitFont.lineHeight/2.0f,labelY - digitFont.lineHeight/2.0f,30,digitFont.lineHeight) withAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: digitFont}];
        
//        在 iOS 8 中，有个新选项可以移动镜片的位置，从较近物体的 0.0 到较远物体的 1.0 (不是指无限远)。
//        
//        ... // 锁定，配置
//        var lensPosition:Float = ... // 0.0 到 1.0的float
//        currentCameraDevice.setFocusModeLockedWithLensPosition(lensPosition) {
//            (timestamp:CMTime) -> Void in
//            // timestamp 对应于应用了镜片位置的第一张图像缓存区
//        }
//        ... // 解锁
        
//        在 iOS 设备上，镜头上的光圈是固定的 (在 iPhone 5s 以及其之后的光圈值是 f/2.2，之前的是 f/2.4)，因此只有改变曝光时间和传感器的灵敏度才能对图片的亮度进行调整，从而达到合适的效果。至于对焦，我们可以选择连续自动曝光，在“感兴趣的点”一次性自动曝光，或者手动曝光。除了指定“感兴趣的点”，我们可以通过设置曝光补偿 (compensation) 修改自动曝光，也就是曝光档位的目标偏移。目标偏移在曝光档数里有讲到，它的范围在 minExposureTargetBias 与 maxExposureTargetBias 之间，0为默认值 (即没有“补偿”)。
//
//        var exposureBias:Float = ... // 在 minExposureTargetBias 和 maxExposureTargetBias 之间的值
//        ... // 锁定，配置
//        currentDevice.setExposureTargetBias(exposureBias) { (time:CMTime) -> Void in
//        }
//        ... // 解锁
//        使用手动曝光，我们可以设置 ISO 和曝光时间，两者的值都必须在设备当前格式所指定的范围内。
//
//        var activeFormat = currentDevice.activeFormat
//        var duration:CTime = ... //在activeFormat.minExposureDuration 和 activeFormat.maxExposureDuration 之间的值，或用 AVCaptureExposureDurationCurrent 表示不变
//        var iso:Float = ... // 在 activeFormat.minISO 和 activeFormat.maxISO 之间的值，或用 AVCaptureISOCurrent 表示不变
//        ... // 锁定，配置
//        currentDevice.setExposureModeCustomWithDuration(duration, ISO: iso) { (time:CMTime) -> Void in
//        }
//        ... // 解锁
        label.transform = CGAffineTransformMakeRotation(M_PI/5 * i);
        [self addSubview:label];
        CGContextRestoreGState(ctx);
        NSLog(@"x:%f\ny:%f",labelX,labelY);
    }
}




@end
