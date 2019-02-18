//
//  XWSegmentItemConfig.m
//  Pods
//
//  Created by tianxuewei on 2019/2/18.
//

#import "XWSegmentItemConfig.h"
#import "UIColor+XWSegmentExtension.h"

XWSegmentSize XWSegmentSizeCreate(CGFloat normal, CGFloat selected) {
    XWSegmentSize size;
    size.normal = normal;
    size.selected = selected;
    return size;
}

CGFloat XWSegmentGetTextWidth(NSString *text, NSFont *font) {
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    CGFloat width = adjustedSize.width;
    return width;
}

@interface XWSegmentItemConfig ()

/**
 根据size和type处理后返回item实际物理宽度
 */
@property (nonatomic, assign) XWSegmentSize width;
/** 类型 */
@property (nonatomic, assign) XWSegmentItemType type;
/** 是否选中 */
@property (nonatomic, assign) BOOL isSelected;

@end

@implementation XWSegmentItemConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _isSelected = NO;
        _progress = 0;
        _type = XWSegmentItemTypeUnknown;
        _size = XWSegmentSizeCreate(15, 15);
    }
    return self;
}

- (XWSegmentSize)width {
    return _size;
}

- (XWSegmentItemType)type {
    return _type;
}

- (CGFloat)sizeScale {
    if (self.size.selected) {
        return self.size.normal / self.size.selected;
    }
    return 1;
}


@end

@interface XWSegmentTextItemConfig ()

/** NormalColor */
@property (nonatomic, assign) XWSegmentColor normalRGBA;
/** SelectedColor */
@property (nonatomic, assign) XWSegmentColor selectedRGBA;

@end

@implementation XWSegmentTextItemConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        self.type = XWSegmentItemTypeText;
        self.normalColor = UIColor.blackColor;
        self.selectedColor = UIColor.redColor;
    }
    return self;
}

#pragma mark -

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    _normalRGBA = normalColor.xw_segment_rgbaColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    _selectedRGBA = selectedColor.xw_segment_rgbaColor;
}

#pragma mark -
//
//- (XWSegmentSize)width {
//    if (!_width.normal && !_width.selected) {
//        _width.normal = XWSegmentGetTextWidth(self.title, [UIFont fontWithName:self.fontName size:_size.normal]);
//        _width.selected = XWSegmentGetTextWidth(self.title, [UIFont fontWithName:self.fontName size:_size.selected]);
//    }
//    return _width;
//}


- (UIColor *)currentColor {
    return [UIColor xw_segment_progressColor:_normalRGBA targetColor:_selectedRGBA scale:self.progress];
}

- (CGAffineTransform)currentTransform {
    CGFloat sizeScale = self.sizeScale;
    CGFloat trans = sizeScale + self.progress * (1 - sizeScale);
    return CGAffineTransformMakeScale(trans, trans);
}

@end

@implementation XWSegmentIamgeItemConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        self.type = XWSegmentItemTypeImage;
    }
    return self;
}

@end
