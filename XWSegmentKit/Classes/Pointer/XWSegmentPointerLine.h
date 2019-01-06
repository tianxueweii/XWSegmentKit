//
//  XWSegmentPointerLine.h
//  Pods
//
//  Created by tianxuewei on 2017/8/5.
//
//

#import "XWSegmentPointer.h"

@interface XWSegmentPointerLine : XWSegmentPointer

/**
 line的颜色
 */
@property (nonatomic, setter=setLineColor:) UIColor *lineColor;
/**
 line圆角
 */
@property (nonatomic, assign) CGFloat cornerRadius;

@end
