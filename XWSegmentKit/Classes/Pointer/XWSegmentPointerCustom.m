//
//  ZbSegmentPointerCustom.m
//  Pods
//
//  Created by tianxuewei on 2017/8/8.
//
//

#import "XWSegmentPointerCustom.h"

@interface XWSegmentPointerCustom ()

@property (nonatomic, strong) UIImageView *containerView;

@end

@implementation XWSegmentPointerCustom

- (void)layoutSubviews {
    [super layoutSubviews];
    _containerView.frame = self.bounds;
}

- (void)setPointerImg:(UIImage *)pointerImg {
    _pointerImg = pointerImg;
    [self.containerView setImage:pointerImg];
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [[UIImageView alloc] init];
        [self addSubview:_containerView];
    }
    return _containerView;
}

@end
