//
//  XWSegmentPointer.h
//  Pods
//
//  Created by tianxuewei on 2017/8/4.
//
//  pointer抽象类，不建议直接使用
//

#import <UIKit/UIKit.h>
#import "XWSegmentBar.h"

@interface XWSegmentPointer : UIView

/**
 宽度
 */
@property (nonatomic, assign) CGFloat width;
/**
 控制（正+负-）跟随改变宽度长度，默认长度为内容长度
 */
@property (nonatomic, assign) CGFloat adjustGradualWidth;
/**
 高度
 */
@property (nonatomic, assign) CGFloat height;
/**
 底边距
 */
@property (nonatomic, assign) CGFloat paddingBottom;

/**
 指针是否跟随滚动 默认：yes
 注意：关闭此项后，会关闭gradualWidth
 */
@property (nonatomic, assign, getter=isFollowScroll) BOOL followScroll;
/**
 指针宽度渐变 默认：NO
 注意：如果设置为YES width将失效，默认宽度为item宽度
 */
@property (nonatomic, assign, getter=isGradualWidth) BOOL gradualWidth;

/**
 指针初始化时，系统会自动调用，如果继承该类，请重写这个方法。该方法供开发者自行hook
 */
- (void)xw_segment_pointer_initialize;




@end
