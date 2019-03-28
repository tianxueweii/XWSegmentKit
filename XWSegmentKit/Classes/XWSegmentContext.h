//
//  XWSementContext.h
//  Pods
//
//  Created by tianxuewei on 2018/5/14.
//
//  当前版本仅支持单文本item
//

#import <Foundation/Foundation.h>
#import "XWSegmentConfigHelper.h"


@interface XWSegmentContext : NSObject<XWSegmentConfigInterface>

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
/** 固定宽度 */
@property (nonatomic, assign) CGFloat fixedWidth;

@end





