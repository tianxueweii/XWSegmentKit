//
//  XWSegmentBarFlowLayout.h
//  Pods
//
//  Created by tianxuewei on 2018/9/28.
//

#import <UIKit/UIKit.h>
#import "XWSegmentBar.h"


@interface XWSegmentBarFlowLayout : UICollectionViewFlowLayout

/** 关联的segmentBar */
@property (nonatomic, weak) XWSegmentBar * segmentBar;
/** 开始下标开始更新layout */
@property (nonatomic, assign) NSInteger beginLayoutIdx;
/** 所有布局信息 */
@property (nonatomic, readonly) NSMutableArray <UICollectionViewLayoutAttributes *>* layoutAttributes;

/** 清除所有布局信息，下次需要布局时会重绘 */
- (void)cleanUpLayoutAttributes;
@end
