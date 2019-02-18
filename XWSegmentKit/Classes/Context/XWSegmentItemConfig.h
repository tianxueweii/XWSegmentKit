//
//  XWSegmentItemConfig.h
//  Pods
//
//  Created by tianxuewei on 2019/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XWSegmentItemType) {
    XWSegmentItemTypeUnknown = 0,
    XWSegmentItemTypeText,
    XWSegmentItemTypeImage,
};

typedef struct {
    CGFloat normal;
    CGFloat selected;
} XWSegmentSize;

/**
 创建SegmentSize结构体

 @param normal 常规
 @param selected 选中
 @return 结构体实例
 */
FOUNDATION_EXTERN XWSegmentSize XWSegmentSizeCreate(CGFloat normal, CGFloat selected);

#pragma mark -

@interface XWSegmentItemConfig : NSObject

/**
 固定尺寸宽度
 该值默认为0。如果设置了该值，item的宽度将被按照设定值固定。item高度由SegmentBar高度和内边距决定
 */
@property (nonatomic, assign) CGFloat specificWidth;

/**
 逻辑尺寸
 该值在不同类型Item上有不同的响应，默认为(15,15)
 
 - TextType: 该值决定默认字号
 - ImageType: 该值决定图片默认宽度
 */
@property (nonatomic, assign) XWSegmentSize size;

/**
 实际宽度
 根据size和type处理后返回item实际物理宽度
 */
@property (nonatomic, readonly) XWSegmentSize width;

/**
 滚动进度
 该值会影响所有布局参数，请勿直接调用
 */
@property (nonatomic, assign) CGFloat progress;

/**
 是否选中
 */
@property (nonatomic, readonly) BOOL isSelected;


/**
 构造器

 @return config实例
 */
- (instancetype)init;

/** 当前Config类型 */
- (XWSegmentItemType)type;

/** 返回尺寸比 */
- (CGFloat)sizeScale;

@end

#pragma mark -

@interface XWSegmentTextItemConfig : XWSegmentItemConfig

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 默认颜色 */
@property (nonatomic, strong) UIColor *normalColor;
/** 选中颜色 */
@property (nonatomic, strong) UIColor *selectedColor;
/** 字体名称 */
@property (nonatomic, copy) NSString *fontName;

/**
 返回当前颜色状态
 */
- (UIColor *)currentColor;

/**
 返回当前仿射变换状态
 */
- (CGAffineTransform)currentTransform;

@end

#pragma mark -

@interface XWSegmentIamgeItemConfig : XWSegmentItemConfig

@end

NS_ASSUME_NONNULL_END
