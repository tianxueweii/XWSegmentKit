//
//  XWSegmentItem.m
//  Pods
//
//  Created by tianxuewei on 2017/8/4.
//
//

#import "XWSegmentItem.h"
#import "XWSegmentContext.h"
#import "UIView+XWSegmentExtension.h"


@interface XWSegmentItem ()

@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation XWSegmentItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        self.titleLb.center = self.contentView.center;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_titleLb sizeToFit];
    // 防止由于精度问题导致标题被裁剪
    _titleLb.xw_segment_width += 1;
    switch (_anchorLocation) {
        case XWSegmentBarAnchorLocationCenter:
            _titleLb.layer.anchorPoint = CGPointMake(0.5, 0.5);
            _titleLb.center = self.contentView.center;
            break;
        case XWSegmentBarAnchorLocationBottom:
            _titleLb.layer.anchorPoint = CGPointMake(0.5, 1);
            _titleLb.center = CGPointMake(self.contentView.xw_segment_width / 2, self.contentView.xw_segment_height);
            break;
    }
}

#pragma mark - 接口

- (void)setupSegmentItemWithContext:(XWSegmentContext *)context animated:(BOOL)animated{
    // 根据锚点不同基线位置也不同
    NSAttributedString *titleAttributedStr = [[NSAttributedString alloc] initWithString:context.title attributes:@{NSBaselineOffsetAttributeName : _anchorLocation == XWSegmentBarAnchorLocationCenter ? @(0) : @(-context.selectedFont.pointSize / 7.f)}];
    _titleLb.attributedText = titleAttributedStr;
    _titleLb.font = context.selectedFont;
    _titleLb.textColor = context.currentColor;
    _titleLb.transform = context.currentTransform;
    _titleLb.textAlignment = NSTextAlignmentJustified;
    [self layoutSubviews];
}

#pragma mark - 懒加载
- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.clipsToBounds = YES;
    }
    return _titleLb;
}


@end
