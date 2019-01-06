//
//  XWSegmentItem.h
//  Pods
//
//  Created by tianxuewei on 2017/8/4.
//
//  当前版本只支持纯文本，后续会在Context中加入更多类型
//

#import <UIKit/UIKit.h>
#import "XWSegmentBar.h"

@class XWSegmentContext;

@interface XWSegmentItem : UICollectionViewCell

/**
 锚点位置在中间
 */
@property (nonatomic, assign) XWSegmentBarAnchorLocation anchorLocation;
/**
 根据上下文设置item

 @param context 上下文
 */
- (void)setupSegmentItemWithContext:(XWSegmentContext *)context animated:(BOOL)animated;

@end
