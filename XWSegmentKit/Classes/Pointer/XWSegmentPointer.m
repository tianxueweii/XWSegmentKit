//
//  XWSegmentPointer.m
//  Pods
//
//  Created by tianxuewei on 2017/8/4.
//
//

#import "XWSegmentPointer.h"
#import "UIView+XWSegmentExtension.h"

@interface XWSegmentPointer ()

@end

@implementation XWSegmentPointer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.followScroll = YES;
        [self xw_segment_pointer_initialize];
    }
    return self;
}


- (void)setFollowScroll:(BOOL)followScroll{
    _followScroll = followScroll;
    if (!_followScroll) {
        _gradualWidth = NO;
    }
}


- (void)setGradualWidth:(BOOL)gradualWidth{
    //指针跟随滚动状态，可设置该值
    if (_followScroll) {
        _gradualWidth = gradualWidth;
    }
}


- (void)xw_segment_pointer_initialize;{}

@end
