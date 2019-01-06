//
//  XWSegmentStyleBaseController.h
//  XWSegmentKit_Example
//
//  Created by 田学为 on 2019/1/6.
//  Copyright © 2019年 tianxueweii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWSegmentKit.h"

#define UIMainScreenSize [UIScreen mainScreen].bounds.size
#define UIRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface XWSegmentStyleBaseController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *titleArr;

@end

NS_ASSUME_NONNULL_END
