//
//  XWSementContext.m
//  Pods
//
//  Created by tianxuewei on 2018/5/14.
//

#import "XWSegmentContext.h"
#import "UIColor+XWSegmentExtension.h"

#define PRECISION 0.0000001

@interface XWSegmentContext () {
    XWSegmentItemWidth _itemWidth;
}

@end

@implementation XWSegmentContext

@synthesize currentColor = _currentColor;
@synthesize isSelected = _isSelected;
@synthesize progress = _progress;

- (instancetype)init{
    self = [super init];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.color = [UIColor blackColor];
        self.selectedColor = [UIColor redColor];
    }
    return self;
}

#pragma mark -

- (UIFont *)selectedFont {
    if (!_selectedFont) {
        _selectedFont = self.font;
    }
    return _selectedFont;
}


#pragma mark - XWSegmentConfigInterface

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        self.progress = 1;
    }else{
        self.progress = 0;
    }
}

#pragma mark -

- (CGFloat)transformScale {
    return self.font.pointSize / self.selectedFont.pointSize;
}

- (CGFloat)width {
    if (_itemWidth.normal >= -PRECISION && _itemWidth.normal <= PRECISION) {
        CGFloat width = XWSegmentGetTextSizeWidth(self.title, self.font);
        _itemWidth.normal = width;
    }
    return _itemWidth.normal;
}

- (CGFloat)maxWidth {
    if (_itemWidth.selected >= -PRECISION && _itemWidth.selected <= PRECISION) {
        CGFloat width = XWSegmentGetTextSizeWidth(self.title, self.selectedFont);
        _itemWidth.selected = width;
    }
    return _itemWidth.selected;
}

#pragma mark -

- (UIColor *)currentColor {
    return [UIColor xw_segment_progressColor:self.color.xw_segment_rgbaColor
                                 targetColor:self.selectedColor.xw_segment_rgbaColor
                                       scale:self.progress];
}

- (CGAffineTransform)currentTransform {
    return CGAffineTransformMakeScale(self.transformScale + self.progress * (1 - self.transformScale),
                                      self.transformScale + self.progress * (1 - self.transformScale));;
}

@end




