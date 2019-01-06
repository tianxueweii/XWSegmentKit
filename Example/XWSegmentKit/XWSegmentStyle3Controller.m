//
//  XWSegmentStyle3Controller.m
//  XWSegmentKit_Example
//
//  Created by 田学为 on 2019/1/6.
//  Copyright © 2019年 tianxueweii. All rights reserved.
//

#import "XWSegmentStyle3Controller.h"

@interface XWSegmentStyle3Controller ()<XWSegmentBarDelegate, XWSegmentBarDataSource>
@property (nonatomic, strong) XWSegmentBar *segmentBar;

@end

@implementation XWSegmentStyle3Controller


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
    context.selectedFont = [UIFont systemFontOfSize:26];
    context.selectedColor = UIRandomColor;
    context.color = UIColor.darkGrayColor;
    return context;
}

- (XWSegmentPointer *)xw_segment_pointer {
    XWSegmentPointerCustom *pointer = [[XWSegmentPointerCustom alloc] init];
    pointer.pointerImg = [UIImage imageNamed:@"point"];
    pointer.width = pointer.pointerImg.size.width;
    pointer.height = pointer.pointerImg.size.height;
    pointer.paddingBottom = 0;
    return pointer;
}

- (void)xw_segment_didSelectItemAtIndex:(NSInteger)idx {
    [self.collectionView setContentOffset:CGPointMake(UIMainScreenSize.width * idx, 0) animated:NO];
}

- (UIEdgeInsets)xw_segment_padding {
    return UIEdgeInsetsMake(0, 5, 10, 5);
}

#pragma mark - ScrollVeiw Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segmentBar xw_segment_associatedScrollViewDidScroll:scrollView];
}

@end
