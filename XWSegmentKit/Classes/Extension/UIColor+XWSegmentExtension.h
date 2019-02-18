//
//  UIColor+XWSegmentExtension.h
//  Pods
//
//  Created by tianxuewei on 2019/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 存放RGBA值结构体
 */
typedef struct {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
} XWSegmentColor, XW_RGB_Color;

@interface UIColor (XWSegmentExtension)

/**
 获取颜色混合值

 @param aColor1 颜色1
 @param aColor2 颜色2
 @return 混合后新颜色结构体
 */
FOUNDATION_EXTERN XWSegmentColor XWSegmentColorAdd(XWSegmentColor aColor1, XWSegmentColor aColor2);

/**
 获取颜色差值

 @param aColor1 颜色1
 @param aColor2 颜色2
 @return 差值后新颜色结构体
 */
FOUNDATION_EXTERN XWSegmentColor XWSegmentColorReduce(XWSegmentColor aColor1, XWSegmentColor aColor2);

/**
 获取颜色比例值

 @param aColor 颜色
 @param scale 比例
 @return 比例后新颜色结构体
 */
FOUNDATION_EXTERN XWSegmentColor XWSegmentColorScale(XWSegmentColor aColor, CGFloat scale);

/**
 以rgba结构体输出颜色值

 @return XWSegmentColor结构体
 */
- (XWSegmentColor)xw_segment_rgbaColor;

/**
 将rgba结构体转化为UIColor

 @param color 结构体
 @return UIColor对象
 */
+ (UIColor *)xw_segment_colorWithRgbaColor:(XWSegmentColor)color;

/**
 按照输入比例，获取基本色至目标色中间的过度色

 @param aColor 基本色
 @param tColor 目标色
 @param scale 比例
 @return 合成UIColor对象
 */
+ (UIColor *)xw_segment_progressColor:(XWSegmentColor)aColor targetColor:(XWSegmentColor)tColor scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
