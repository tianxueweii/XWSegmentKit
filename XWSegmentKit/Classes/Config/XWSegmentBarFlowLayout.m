//
//  XWSegmentBarFlowLayout.m
//  Pods
//
//  Created by tianxuewei on 2018/9/28.
//

#import "XWSegmentBarFlowLayout.h"
#import "XWSegmentContext.h"

@interface XWSegmentBarFlowLayout()

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *>* layoutAttributes;

@end

@implementation XWSegmentBarFlowLayout

- (void)cleanUpLayoutAttributes {
    _layoutAttributes = nil;
}

#pragma mark - Override
- (CGSize)collectionViewContentSize{
    CGSize size = [super collectionViewContentSize];
    CGFloat newWidth = size.width;
    if (_layoutAttributes.lastObject) {
        newWidth = _layoutAttributes.lastObject.frame.origin.x + self.layoutAttributes.lastObject.frame.size.width + self.padding.right;
    }
    return CGSizeMake(newWidth, size.height);
}


- (void)prepareLayout{
    [super prepareLayout];
    [self layoutAttributes];
    for (NSInteger i = _beginLayoutIdx; i < self.segmentBar.xw_segment_allContexts.count; i++) {
        _layoutAttributes[i] = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    }
}

// 该方法覆写性能较差
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [[NSArray alloc] initWithArray:self.layoutAttributes copyItems:YES];
}

// 重绘
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    if (indexPath.item >= self.segmentBar.xw_segment_allContexts.count || !_layoutAttributes) {
        return attributes;
    }
    
    XWSegmentContext *context = self.segmentBar.xw_segment_allContexts[indexPath.item];
    CGFloat minimumSpacing = self.minimumInteritemSpacing;
    CGFloat origin;
    
    if (indexPath.item - 1 < 0) {
        origin = self.padding.left;
    }else{
        origin = self.layoutAttributes[indexPath.item - 1].frame.origin.x + self.layoutAttributes[indexPath.item - 1].frame.size.width + minimumSpacing;
    }

    CGRect nowFrame = attributes.frame;
    CGFloat sizeWidth = context.width + (context.maxWidth - context.width) * context.progress;
    nowFrame.origin.x = origin;
    nowFrame.origin.y = self.padding.top;
    nowFrame.size.width = sizeWidth;
    attributes.frame = nowFrame;
    return attributes;
}

#pragma mark - Get

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)layoutAttributes {
    if (!_layoutAttributes) {
        _layoutAttributes = [NSMutableArray array];
        for (int i = 0; i < self.segmentBar.xw_segment_allContexts.count; i++) {
            [_layoutAttributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
        }
    }
    return _layoutAttributes;
}


@end
