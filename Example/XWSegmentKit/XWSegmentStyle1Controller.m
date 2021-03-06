//
//  XWSegmentStyle1Controller.m
//  XWSegmentKit_Example
//
//  Created by 田学为 on 2019/1/6.
//  Copyright © 2019年 tianxueweii. All rights reserved.
//

#import "XWSegmentStyle1Controller.h"

@interface XWSegmentStyle1Controller ()<XWSegmentBarDelegate, XWSegmentBarDataSource>
@property (nonatomic, strong) XWSegmentBar *segmentBar;
@end

@implementation XWSegmentStyle1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segmentBar];
    [self.segmentBar xw_segment_update];
    // Do any additional setup after loading the view.
}

- (XWSegmentBar *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [[XWSegmentBar alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 44, UIMainScreenSize.width, 44)];
        _segmentBar.delegate = self;
        _segmentBar.dataSource = self;
        _segmentBar.autoScroll = YES;
    }
    return _segmentBar;
}

- (NSInteger)xw_segment_numberOfItems {
    return self.titleArr.count;
}

- (XWSegmentContext *)xw_segment_itemContextAtIndex:(NSInteger)idx {
    XWSegmentContext *context = [[XWSegmentContext alloc] init];
    context.title = self.titleArr[idx];
    context.font = [UIFont systemFontOfSize:16];
    context.selectedFont = [UIFont systemFontOfSize:16];
    context.selectedColor = UIColor.redColor;
    context.color = UIColor.darkGrayColor;
    return context;
}

- (void)xw_segment_didSelectItemAtIndex:(NSInteger)idx {
    [self.collectionView setContentOffset:CGPointMake(UIMainScreenSize.width * idx, 0) animated:YES];
}

- (UIEdgeInsets)xw_segment_padding {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (XWSegmentPointer *)xw_segment_pointer {
    XWSegmentPointerLine *pointer = [[XWSegmentPointerLine alloc] init];
    pointer.lineColor = UIColor.redColor;
    pointer.height = 2;
    pointer.cornerRadius = 1;
    pointer.gradualWidth = YES;
    pointer.followScroll = YES;
    pointer.paddingBottom = 3;
    return pointer;
}

#pragma mark - ScrollVeiw Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segmentBar xw_segment_associatedScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

@end
