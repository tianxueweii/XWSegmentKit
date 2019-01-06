//
//  UIView+XWSegmentExtension.m
//  Pods
//
//  Created by tianxuewei on 2017/8/14.
//
//

#import "UIView+XWSegmentExtension.h"


@implementation UIView (XWSegmentExtension)

- (CGFloat)xw_segment_width{
    return self.frame.size.width;
}

- (void)setXw_segment_width:(CGFloat)zb_segment_width{
    CGRect newframe = self.frame;
    newframe.size.width = zb_segment_width;
    self.frame = newframe;
}

- (CGFloat)xw_segment_height{
    return self.frame.size.height;
}

- (void)setXw_segment_height:(CGFloat)zb_segment_height{
    CGRect newframe = self.frame;
    newframe.size.height = zb_segment_height;
    self.frame = newframe;
}

- (CGFloat)xw_segment_centerX{
    return self.center.x;
}

- (void)setXw_segment_centerX:(CGFloat)zb_segment_centerX{
    CGPoint newPoint = self.center;
    newPoint.x = zb_segment_centerX;
    self.center = newPoint;
}

@end
