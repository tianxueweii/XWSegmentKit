//
//  XWSementContext.h
//  Pods
//
//  Created by tianxuewei on 2018/5/14.
//
//  当前版本仅支持单文本item
//

#import <Foundation/Foundation.h>

@interface XWSegmentContext : NSObject

/** 标题 */
@property (nonatomic, copy)  NSString *title;
/** 默认颜色 */
@property (nonatomic, strong) UIColor *color;
/** 选中颜色 */
@property (nonatomic, strong) UIColor *selectedColor;
/** 标题默认Font */
@property (nonatomic, strong) UIFont *font;
/**
 标题选中Font
 如果默认Font和选中状态Font字体不同，则采用selectedFont
 */
@property (nonatomic, strong) UIFont *selectedFont;


@end

/** 位置处理 */
@interface XWSegmentContext(ContextRect)

/** 是否选中 */
@property (nonatomic, readonly) BOOL isSelected;
/** 当前形变 */
@property (nonatomic, readonly) CGAffineTransform currentTransform;
/** 当前形变比 */
@property (nonatomic, readonly, assign) CGFloat currentTransformScale;

/** item宽度 */
- (CGFloat)width;
/** item最大 */
- (CGFloat)maxWidth;
/**
 item仿缩比
 SelctedFont/Font
 */
- (CGFloat)fontTransformScale;

@end


/** 颜色处理 */
@interface XWSegmentContext(ContextColor)

/** 当前颜色 */
@property (nonatomic, readonly) UIColor *currentColor;

/** 当前 RGB */
@property (nonatomic, assign, readonly) CGFloat R;
@property (nonatomic, assign, readonly) CGFloat G;
@property (nonatomic, assign, readonly) CGFloat B;
@property (nonatomic, assign, readonly) CGFloat alpha;
/** 当前选中 RGB */
@property (nonatomic, assign, readonly) CGFloat selectR;
@property (nonatomic, assign, readonly) CGFloat selectG;
@property (nonatomic, assign, readonly) CGFloat selectB;
@property (nonatomic, assign, readonly) CGFloat selectAlpha;

@end




