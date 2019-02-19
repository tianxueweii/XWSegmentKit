//
//  XWSegmentConfigHelper.h
//  Pods
//
//  Created by 田学为 on 2019/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    CGFloat normal;
    CGFloat selected;
} XWSegmentItemWidth;

/**
 创建一个item宽度结构体

 @param normal 非选中宽度
 @param selected 选中宽度
 @return 结构体实例
 */
FOUNDATION_EXTERN XWSegmentItemWidth XWSegmentItemWidthCreate(CGFloat normal, CGFloat selected);

/**
 根据内容和font获取文本长度

 @param text 文本
 @param font font
 @return CGFloat长度
 */
FOUNDATION_EXTERN CGFloat XWSegmentGetTextSizeWidth(NSString *text, UIFont *font);

@protocol XWSegmentConfigInterface <NSObject>

/**
 进度
 */
@property (nonatomic, assign) CGFloat progress;
/**
 是否选中
 */
@property (nonatomic, assign) BOOL isSelected;
/**
 当前色值
 */
@property (nonatomic, readonly) UIColor *currentColor;
/**
 当前变换
 */
@property (nonatomic, readonly) CGAffineTransform currentTransform;
/**
 item宽度
 */
@property (nonatomic, readonly) CGFloat width;
/**
 item最大
 */
@property (nonatomic, readonly) CGFloat maxWidth;
/**
 放缩比
 */
@property (nonatomic, readonly) CGFloat transformScale;

@end

NS_ASSUME_NONNULL_END
