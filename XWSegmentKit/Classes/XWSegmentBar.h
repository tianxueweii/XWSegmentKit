//
//  XWSegmentBar.h
//  Pods
//
//  Created by tianxuewei on 2017/8/4.
//

#import <UIKit/UIKit.h>

@class XWSegmentBar;
@class XWSegmentItem;
@class XWSegmentPointer;
@class XWSegmentContext;

/**
 导航栏Cell锚点位置

 - XWSegmentBarAnchorLocationCenter: 中心
 - XWSegmentBarAnchorLocationBottom: 底部
 */
typedef NS_ENUM(NSUInteger, XWSegmentBarAnchorLocation) {
    XWSegmentBarAnchorLocationCenter = 0,
    XWSegmentBarAnchorLocationBottom
};

/**
 导航栏数据代理
 */
@protocol XWSegmentBarDataSource <NSObject>

@required

/**
 返回栏目数量

 @return item数量
 */
- (NSInteger)xw_segment_numberOfItems;

/**
 返回用于渲染子项的上下文
 该接口只有初始化或重载时会被调用
 
 @param idx idx
 @return 分段导航视图子项
 */
- (XWSegmentContext *)xw_segment_itemContextAtIndex:(NSInteger)idx;

@optional

/**
 栏目间距，默认为0
 
 @return 间距
 */
- (CGFloat)xw_segment_itemMinimumSpace;
/**
 栏目内填充，默认无填充

 @return UIEdgeInsets
 */
- (UIEdgeInsets)xw_segment_padding;

/**
 返回指针样式

 @return 导航指针
 */
- (XWSegmentPointer *)xw_segment_pointer;


@end

/**
 导航栏操作代理
 */
@protocol XWSegmentBarDelegate <NSObject>

@optional

/**
 是否允许点击栏目

 @param idx 栏目编号
 @return yes/no
 */
- (BOOL)xw_segment_shouldSelectItemAtIndex:(NSInteger)idx;

/**
 栏目点击

 @param idx 点击栏目编号
 */
- (void)xw_segment_didSelectItemAtIndex:(NSInteger)idx;


@end

@interface XWSegmentBar : UIView

#pragma mark - 初始化

/**
 初始化方法
 初始化实例后请在需要的地方使用xw_segment_update方法加载导航

 @return ins
 */
+ (instancetype)xw_segmentBar;
- (instancetype)init;


#pragma mark - 代理

/**
 数据源
 */
@property (nonatomic, weak) id <XWSegmentBarDataSource> dataSource;
/**
 代理
 */
@property (nonatomic, weak) id <XWSegmentBarDelegate> delegate;

#pragma mark - 配置
/**
 焦点不在屏幕中则自动滚动
 */
@property (nonatomic, assign) BOOL autoScroll;
/**
 item锚点位置
 */
@property (nonatomic, assign) XWSegmentBarAnchorLocation itemAnchorLocation;

#pragma mark - 接口

/**
 当前选中索引
 */
@property(nonatomic, readonly) NSInteger currentIndex;

/**
 返回所有内容上下文
 */
- (NSArray *)xw_segment_allContexts;

/**
 初始加载导航栏
 【注意】此方法需要在第一次初始化时调用
 */
- (void)xw_segment_update;
/**
 重载导航栏
 【注意】若已经加载导航栏，请使用该方法重载数据，在有操作行为时重载，可能会导致数据异常
 */
- (void)xw_segment_reloadData;

/**
 设置当前选中idx,会更新item状态和pointer位置

 @param currentIndex 当前idx
 */
- (void)xw_segment_setCurrentItemIndex:(NSInteger)currentIndex;

/**
 当需要支持拖动渐变时，需要关联滚动视图
 此方法用于同步内容视图scrollView拖动的偏移量
 请在scrollViewDidScroll:方法中调用此方法

 @param sc 关联的scrollview
 */
- (void)xw_segment_associatedScrollViewDidScroll:(UIScrollView *)sc;

@end
