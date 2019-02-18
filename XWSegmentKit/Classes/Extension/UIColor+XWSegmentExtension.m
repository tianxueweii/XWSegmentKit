//
//  UIColor+XWSegmentExtension.m
//  Pods
//
//  Created by tianxuewei on 2019/2/18.
//

#import "UIColor+XWSegmentExtension.h"

XWSegmentColor XWSegmentColorAdd(XWSegmentColor aColor1, XWSegmentColor aColor2) {
    XWSegmentColor color;
    color.r = aColor1.r + aColor2.r;
    color.g = aColor1.g + aColor2.g;
    color.b = aColor1.b + aColor2.b;
    color.a = aColor1.a + aColor2.a;
    return color;
}

XWSegmentColor XWSegmentColorReduce(XWSegmentColor aColor1, XWSegmentColor aColor2) {
    XWSegmentColor color;
    color.r = aColor1.r - aColor2.r;
    color.g = aColor1.g - aColor2.g;
    color.b = aColor1.b - aColor2.b;
    color.a = aColor1.a - aColor2.a;
    return color;
}

XWSegmentColor XWSegmentColorScale(XWSegmentColor aColor, CGFloat scale) {
    XWSegmentColor color;
    color.r = aColor.r * scale;
    color.g = aColor.g * scale;
    color.b = aColor.b * scale;
    color.a = aColor.a * scale;
    return color;
}

@implementation UIColor (XWSegmentExtension)

- (XWSegmentColor)xw_segment_rgbaColor {
    XWSegmentColor color;
    [self getRed:&color.r green:&color.g blue:&color.b alpha:&color.a];
    return color;
}

+ (UIColor *)xw_segment_colorWithRgbaColor:(XWSegmentColor)color {
    return [UIColor colorWithRed:color.r green:color.g blue:color.b alpha:color.a];
}

+ (UIColor *)xw_segment_progressColor:(XWSegmentColor)aColor targetColor:(XWSegmentColor)tColor scale:(CGFloat)scale {
    XWSegmentColor diffColor = XWSegmentColorReduce(tColor, aColor);
    XWSegmentColor offsetColor = XWSegmentColorScale(diffColor, scale);
    XWSegmentColor resultColor = XWSegmentColorAdd(aColor, offsetColor);
    return [UIColor xw_segment_colorWithRgbaColor:resultColor];
}

@end
