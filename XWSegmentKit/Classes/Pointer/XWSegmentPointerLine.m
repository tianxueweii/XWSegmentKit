//
//  XWSegmentPointerLine.m
//  Pods
//
//  Created by tianxuewei on 2017/8/5.
//
//

#import "XWSegmentPointerLine.h"
#import "UIView+XWSegmentExtension.h"
@implementation XWSegmentPointerLine

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.backgroundColor = _lineColor;
}
@end
