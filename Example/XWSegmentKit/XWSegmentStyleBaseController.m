//
//  XWSegmentStyleBaseController.m
//  XWSegmentKit_Example
//
//  Created by 田学为 on 2019/1/6.
//  Copyright © 2019年 tianxueweii. All rights reserved.
//

#import "XWSegmentStyleBaseController.h"

@interface XWSegmentStyleBaseController ()

@end

@implementation XWSegmentStyleBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}

- (NSArray *)titleArr {
    return @[@"关注", @"头条", @"新时代", @"游戏", @"NBA", @"时尚", @"轻松一刻", @"股票", @"健康", @"漫画", @"改革开放", @"中国足球", @"二次元", @"天猫", @"星座", @"CBA", @"易城live", @"京东"];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        CGRect rect = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 88, UIMainScreenSize.width, UIMainScreenSize.height - [UIApplication sharedApplication].statusBarFrame.size.height - 88);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.itemSize = rect.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = UIRandomColor;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}



@end
