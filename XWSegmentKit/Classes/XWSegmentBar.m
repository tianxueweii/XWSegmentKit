//
//  XWSegmentBar.m
//  Pods
//
//  Created by tianxuewei on 2017/8/4.
//
//

#import "XWSegmentBar.h"
#import "XWSegmentItem.h"
#import "XWSegmentPointer.h"
#import "XWSegmentPointerLine.h"
#import "XWSegmentContext.h"
#import "XWSegmentBarFlowLayout.h"
#import "UIView+XWSegmentExtension.h"

NSString *const kXWSegmentBarItemKey = @"com.segmentKit.XWSegmentBarItemKey";

#define Segment_Bar_Width  self.xw_segment_width
#define Segment_Bar_Height  self.xw_segment_height

@interface XWSegmentBar ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UICollectionView *mainScrollBar;
@property (nonatomic, strong) XWSegmentPointer *pointer;
@property (nonatomic, strong) XWSegmentBarFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray <XWSegmentContext *>*contexts;

@end

@implementation XWSegmentBar

#pragma mark - Init
+ (instancetype)xw_segmentBar{
    return [[self alloc] init];
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoScroll = YES;
        self.clipsToBounds = YES;
        _currentIndex = 0;
    }
    return self;
}

- (void)initializeSubViews{
    [self addSubview:self.mainScrollBar];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _mainScrollBar.frame = self.bounds;
}

#pragma mark - Interface

- (NSArray *)xw_segment_allContexts{
    return self.contexts;
}

- (void)xw_segment_update{
    
    if (self.mainScrollBar) {
        [self.mainScrollBar removeFromSuperview];
        self.mainScrollBar = nil;
    }
    [self p_setUpContextsWithDataSource];
    [self initializeSubViews];
    [self layoutIfNeeded];
    self.flowLayout.itemSize = CGSizeMake(0, self.mainScrollBar.contentSize.height);
    [self p_setUpPointerWithDataSource];
    [self xw_segment_setCurrentItemIndex:_currentIndex];
}

- (void)xw_segment_reloadData{
    // 为了防止数据错乱，在滚动或拖拽时，不重载数据
    if (self.mainScrollBar.isDragging || self.mainScrollBar.isDecelerating || self.mainScrollBar.isTracking){
        return;
    }
    // 重载数据，清理flowLayout布局信息
    [self.flowLayout cleanUpLayoutAttributes];
    [self p_setUpContextsWithDataSource];
    [self.mainScrollBar reloadData];
    [self xw_segment_setCurrentItemIndex:_currentIndex];
}


- (void)xw_segment_setCurrentItemIndex:(NSInteger)index {
    
    if (!self.contexts.count) {
        return;
    }
    
    // flowlayout从0开始刷新
    _flowLayout.beginLayoutIdx = 0;
    
    if (index != _currentIndex) {
        XWSegmentContext *lstctx = self.contexts[_currentIndex];
        
        [lstctx setValue:@(NO) forKey:@"isSelected"];
        [lstctx setValue:@(0) forKey:@"currentTransformScale"];
        
        [UIView performWithoutAnimation:^{
            [self.mainScrollBar reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.currentIndex inSection:0]]];
        }];
    }
    
    [self setCurrentIndex:index];
    
    XWSegmentContext *ctx = self.contexts[_currentIndex];
    [ctx setValue:@(YES) forKey:@"isSelected"];
    [ctx setValue:@(1) forKey:@"currentTransformScale"];
    [UIView performWithoutAnimation:^{
        [self.mainScrollBar reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.currentIndex inSection:0]]];
    }];

    if (!self.autoScroll) return;
    
    // 这里不用selectItemAtIndexPath：的原因是在重绘布局后不能直接精准位移滚动视图
    // [self.mainScrollBar selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    // 修改偏移量
    CGFloat offsetX = _flowLayout.layoutAttributes[_currentIndex].center.x - _mainScrollBar.xw_segment_width * 0.5f;
    CGFloat maxOffsetX = _mainScrollBar.contentSize.width - _mainScrollBar.xw_segment_width;
    // 处理最小滚动偏移量
    if (offsetX < 0 || maxOffsetX <= 0) {
        offsetX = 0;
    }
    // 处理最大滚动偏移量
    if (offsetX > maxOffsetX && maxOffsetX > 0) {
        offsetX = maxOffsetX;
    }
    [_mainScrollBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [self p_pointerUpdateFrameWithIndex:_currentIndex];
}


/**
 关联滚动视图滚动会调用该方法，该方法会在主线程更新UI，需尽量降低该函数算法复杂度
 */
- (void)xw_segment_associatedScrollViewDidScroll:(UIScrollView *)sc{

    // 如果非拖拽状态，则返回
    if (!(sc.isDragging || sc.isDecelerating)) return;
    
    // 如果items.count为空，则返回
    if (self.contexts.count <= 0) return;
    // 从sc获取计算信息
    CGFloat offsetX = sc.contentOffset.x;
    CGFloat viewWidth = sc.frame.size.width;;
    
    NSInteger leftIndex = offsetX / viewWidth;
    NSInteger rightIndex = leftIndex + 1;
    // 如果越界则放弃本次处理
    if (offsetX < 0 || rightIndex >= _contexts.count) return;

    // 计算右边按钮的偏移相对比
    CGFloat rightScale  = offsetX / viewWidth;
    rightScale -= leftIndex;
    // 左边按钮的偏移比
    CGFloat leftScale = 1 - rightScale;
    
    // 设置item
    [self p_itemGradualChangeWithLeftIndex:leftIndex rightIndex:rightIndex leftScale:leftScale rightScale:rightScale];
    
    // 如果sc正在减速，则选中当前index，并位移
    if (sc.isDecelerating) {
        [self setCurrentIndex:(leftScale > rightScale) ? leftIndex : rightIndex];
        // 滚动至指定idx
        [self.mainScrollBar selectItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0] animated:self.autoScroll scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
    
    // 设置pointer
    if([_dataSource respondsToSelector:@selector(xw_segment_pointer)]){
        [self p_pointerGradualChangeWithLeftIndex:leftIndex rightIndex:rightIndex scrale:rightScale];
    }
}

#pragma mark - Collection DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.contexts.count;
}

- (XWSegmentItem *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XWSegmentItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXWSegmentBarItemKey forIndexPath:indexPath];
    XWSegmentContext *context = _contexts[indexPath.item];
    cell.anchorLocation = self.itemAnchorLocation;
    //根据上下文渲染Cell
    [cell setupSegmentItemWithContext:context animated:NO];
    return cell;
}

#pragma mark - Collection Delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(xw_segment_shouldSelectItemAtIndex:)]) {
        return [_delegate xw_segment_shouldSelectItemAtIndex:indexPath.item];
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item >= self.contexts.count) {
        indexPath = [NSIndexPath indexPathForItem:self.contexts.count - 1 inSection:0];
    }
    
    [self xw_segment_setCurrentItemIndex:indexPath.item];
    
    if ([_delegate respondsToSelector:@selector(xw_segment_didSelectItemAtIndex:)]) {
        [_delegate xw_segment_didSelectItemAtIndex:indexPath.item];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    XWSegmentContext *context = _contexts[indexPath.item];
    [context setValue:@(NO) forKey:@"isSelected"];
}

#pragma mark - Private Func
/**
 初始化上下文数组
 */
- (void)p_setUpContextsWithDataSource{
    NSInteger count = 0;
    if ([_dataSource respondsToSelector:@selector(xw_segment_numberOfItems)]) {
        count = [_dataSource xw_segment_numberOfItems];
    }
    //如果无数据，则隐藏pointer
    if (count <= 0) {
        if (self.pointer) {
            self.pointer.hidden = !count;
        }
        return;
    }
    self.contexts = [NSMutableArray array];    
    for (size_t i = 0; i < count; i ++) {
        if ([_dataSource respondsToSelector:@selector(xw_segment_itemContextAtIndex:)]) {
            XWSegmentContext *context = [_dataSource xw_segment_itemContextAtIndex:i];
            [_contexts addObject:context];
        }
    }
}

/**
 初始化指针
 */
- (void)p_setUpPointerWithDataSource{
    if (!_pointer) {
        if ([_dataSource respondsToSelector:@selector(xw_segment_pointer)]) {
            _pointer = [_dataSource xw_segment_pointer];
            [self.mainScrollBar addSubview:_pointer];
            [self layoutIfNeeded];
            _pointer.frame = CGRectMake(0, Segment_Bar_Height - _pointer.height - _pointer.paddingBottom, _pointer.width, _pointer.height);
        }
    }
}

/**
 滚动栏目渐变

 @param leftIndex 左侧栏目Idx
 @param rightIndex 右侧栏目Idx
 @param leftScale 左侧栏目变化比
 @param rightScale 右侧栏目变化比
 */
- (void)p_itemGradualChangeWithLeftIndex:(NSInteger)leftIndex
                              rightIndex:(NSInteger)rightIndex
                               leftScale:(CGFloat)leftScale
                              rightScale:(CGFloat)rightScale{
    
    
    _flowLayout.beginLayoutIdx = leftIndex;
    
    static NSInteger oldLeftIndex = -1;
    static NSInteger oldRightIndex = -1;
    
    XWSegmentContext *context, *pointContext;
    
    context = _contexts[leftIndex];
    pointContext = _contexts[rightIndex];
    
    // 形变
    CGAffineTransform leftTransform = CGAffineTransformMakeScale(context.fontTransformScale + leftScale * (1 - context.fontTransformScale),
                                                                 context.fontTransformScale + leftScale * (1 - context.fontTransformScale));
    CGAffineTransform rightTransform = CGAffineTransformMakeScale(pointContext.fontTransformScale + rightScale * (1- pointContext.fontTransformScale),
                                                                  pointContext.fontTransformScale + rightScale * (1- pointContext.fontTransformScale));
    
    // 记录当前形变
    [context setValue:[NSValue valueWithCGAffineTransform:leftTransform] forKey:@"currentTransform"];
    [context setValue:@(leftScale) forKey:@"currentTransformScale"];
    [pointContext setValue:[NSValue valueWithCGAffineTransform:rightTransform] forKey:@"currentTransform"];
    [pointContext setValue:@(rightScale) forKey:@"currentTransformScale"];
    
    // 色差
    CGFloat leftRedDif       = context.selectR - context.R;
    CGFloat leftGreenDif     = context.selectG - context.G;
    CGFloat leftBlueDif      = context.selectB - context.B;
    CGFloat leftAlphaDif     = context.selectAlpha - context.alpha;

    CGFloat rightRedDif      = pointContext.selectR - pointContext.R;
    CGFloat rightGreenDif    = pointContext.selectG - pointContext.G;
    CGFloat rightBlueDif     = pointContext.selectB - pointContext.B;
    CGFloat rightAlphaDif    = pointContext.selectAlpha - pointContext.alpha;
    
    
    UIColor *leftColor = [UIColor colorWithRed:leftScale * leftRedDif + context.R
                                         green:leftScale * leftGreenDif + context.G
                                          blue:leftScale * leftBlueDif + context.B
                                         alpha:leftScale * leftAlphaDif + context.alpha];
    
    
    UIColor *rightColor = [UIColor colorWithRed:rightScale * rightRedDif + pointContext.R
                                          green:rightScale * rightGreenDif + pointContext.G
                                           blue:rightScale * rightBlueDif + pointContext.B
                                          alpha:rightScale * rightAlphaDif + pointContext.alpha];
    
    // 记录当前颜色
    [context setValue:leftColor forKey:@"currentColor"];
    [pointContext setValue:rightColor forKey:@"currentColor"];

    
    // 调整Cell
    if (oldLeftIndex == rightIndex) {
        [_contexts[oldRightIndex] setValue:@(NO) forKey:@"isSelected"];
        [_contexts[oldRightIndex] setValue:@(0) forKey:@"currentTransformScale"];
        
        [UIView performWithoutAnimation:^{
            [self.mainScrollBar reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:oldRightIndex inSection:0]]];
        }];
    }
    
    if (oldRightIndex == leftIndex) {
        [_contexts[oldLeftIndex] setValue:@(NO) forKey:@"isSelected"];
        [_contexts[oldLeftIndex] setValue:@(0) forKey:@"currentTransformScale"];
        
        [UIView performWithoutAnimation:^{
            [self.mainScrollBar reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:oldLeftIndex inSection:0]]];
        }];
    }
    
    oldLeftIndex = leftIndex;
    oldRightIndex = rightIndex;
    
    [UIView performWithoutAnimation:^{
        [self.mainScrollBar reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:leftIndex inSection:0],
                                                      [NSIndexPath indexPathForItem:rightIndex inSection:0]]];
    }];
}


/**
 指针根据传入idx更新位置

 @param idx 当前idx
 */
- (void)p_pointerUpdateFrameWithIndex:(NSInteger)idx{
    NSArray <UICollectionViewLayoutAttributes *>*layoutAttributes = self.flowLayout.layoutAttributes;
    CGPoint point = layoutAttributes[idx].center;
    // 如果已到既定位置则返回
    if (self.pointer.xw_segment_centerX == point.x) return;
    // 调整
    [UIView animateWithDuration:0.4 animations:^{
        if(self.pointer.isGradualWidth){
            self.pointer.xw_segment_width = layoutAttributes[idx].frame.size.width + self.pointer.adjustGradualWidth;
        }
        self.pointer.xw_segment_centerX = point.x;
    }];
}


/**
 指针根据位置相对比，更新位置

 @param leftIndex 相对左下标
 @param rightIndex 相对右下标
 @param scale 移动比
 */
- (void)p_pointerGradualChangeWithLeftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex scrale:(CGFloat)scale{

    NSArray <UICollectionViewLayoutAttributes *>*layoutAttributes = self.flowLayout.layoutAttributes;
    if (_pointer.isFollowScroll) {
        CGPoint leftPoint = layoutAttributes[leftIndex].center;
        CGPoint rightPoint = layoutAttributes[rightIndex].center;

        CGFloat offset = rightPoint.x - leftPoint.x;
        CGFloat currentX = offset * scale + leftPoint.x;

        _pointer.xw_segment_centerX = currentX;
    }

    if (_pointer.isGradualWidth) {
        CGFloat widthDiff = layoutAttributes[rightIndex].frame.size.width - layoutAttributes[leftIndex].frame.size.width;
        _pointer.xw_segment_width = scale * widthDiff + layoutAttributes[leftIndex].frame.size.width + _pointer.adjustGradualWidth;
    }
}

#pragma mark - Set

//设置当前选中item。会重绘所有layout
- (void)setCurrentIndex:(NSInteger)currentIndex{
    
    NSInteger count = self.contexts.count;
    
    if (count <= 0) {
        return;
    }
    if (currentIndex < 0) {
        currentIndex = 0;
    }
    if (currentIndex >= count) {
        currentIndex = count - 1;
    }
    
    _currentIndex = currentIndex;
}

#pragma mark - Lazyload Get
//代理数据获取
- (NSMutableArray<XWSegmentContext *> *)contexts{
    if (!_contexts) {
        _contexts = [NSMutableArray array];
    }
    return _contexts;
}

- (UICollectionView *)mainScrollBar{
    if (!_mainScrollBar) {
        
        _flowLayout = [[XWSegmentBarFlowLayout alloc] init];
        _flowLayout.segmentBar = self;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        if([_dataSource respondsToSelector:@selector(xw_segment_itemMinimumSpace)]){
            _flowLayout.minimumInteritemSpacing = [_dataSource xw_segment_itemMinimumSpace];
        }else{
            _flowLayout.minimumInteritemSpacing = 20;
        }
        
        if ([_dataSource respondsToSelector:@selector(xw_segment_padding)]) {
            _flowLayout.sectionInset = [_dataSource xw_segment_padding];
        }else{
            _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        
        _mainScrollBar = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _mainScrollBar.delegate = self;
        _mainScrollBar.dataSource = self;
        
        _mainScrollBar.showsHorizontalScrollIndicator = NO;
        _mainScrollBar.backgroundColor = [UIColor clearColor];
        [_mainScrollBar registerClass:[XWSegmentItem class] forCellWithReuseIdentifier:kXWSegmentBarItemKey];
    }
    return _mainScrollBar;
}

@end
