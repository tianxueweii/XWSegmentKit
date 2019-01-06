//
//  XWSementContext.m
//  Pods
//
//  Created by tianxuewei on 2018/5/14.
//

#import "XWSegmentContext.h"

@interface XWSegmentContext(){
    CGFloat _R;
    CGFloat _G;
    CGFloat _B;
    CGFloat _alpha;

    CGFloat _selectR;
    CGFloat _selectG;
    CGFloat _selectB;
    CGFloat _selectAlpha;
    UIColor *_currentColor;
    
    CGAffineTransform _currentTransform;
    CGFloat _currentTransformScale;
    
    BOOL _isSelected;
}

@end

@implementation XWSegmentContext

- (instancetype)init{
    self = [super init];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.color = [UIColor blackColor];
        _currentTransform = CGAffineTransformIdentity;
    }
    return self;
}

#pragma mark - color
- (void)setColor:(UIColor *)color{
    _color = color;
    // 初始化存储
    [_color getRed:&_R green:&_G blue:&_B alpha:&_alpha];
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    // 初始化存储
    [_selectedColor getRed:&_selectR green:&_selectG blue:&_selectB alpha:&_selectAlpha];
}

#pragma mark - font
- (UIFont *)font{
    if(!_font){
        _font = [UIFont systemFontOfSize:15.f];
    }
    return _font;
}


- (void)setSelectedFont:(UIFont *)selectedFont{
    _selectedFont = selectedFont;
    _currentTransform = CGAffineTransformMakeScale(self.fontTransformScale, self.fontTransformScale);
}

@end

@implementation XWSegmentContext(ContextRect)

#pragma mark - currentTransform

- (CGAffineTransform)currentTransform{
    return _currentTransform;
}


#pragma mark - selected
- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (isSelected) {
        _currentColor = _selectedColor;
        _currentTransform = CGAffineTransformIdentity;
    }else{
        _currentColor = _color;
        _currentTransform = CGAffineTransformMakeScale(self.fontTransformScale, self.fontTransformScale);
    }
}

- (BOOL)isSelected{
    return _isSelected;
}

#pragma mark - Func
- (CGFloat)width{
    CGFloat width;
    if (!_font) {
        return 0;
    }
    CGSize size = [_title sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    width = adjustedSize.width;
    return width;
}

- (CGFloat)maxWidth{
    CGFloat width;
    if (!self.selectedFont) {
        self.selectedFont = self.font;
    }
    CGSize size = [_title sizeWithAttributes:@{NSFontAttributeName:self.selectedFont}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    width = adjustedSize.width;
    return width;
}

- (CGFloat)fontTransformScale{
    if (_selectedFont) {
        return _font.pointSize / _selectedFont.pointSize;
    }
    return 1.0f;
}

- (CGFloat)currentTransformScale{
    return _currentTransformScale;
}


@end


@implementation XWSegmentContext(ContextColor)

- (UIColor *)currentColor{
    if (!_currentColor) {
        _currentColor = _color;
    }
    return _currentColor;
}

- (CGFloat)R{ return _R; }
- (CGFloat)G{ return _G; }
- (CGFloat)B{ return _B; }
- (CGFloat)alpha{ return _alpha; }
- (CGFloat)selectR{ return _selectR; }
- (CGFloat)selectG{ return _selectG; }
- (CGFloat)selectB{ return _selectB; }
- (CGFloat)selectAlpha{ return _selectAlpha; }

@end


