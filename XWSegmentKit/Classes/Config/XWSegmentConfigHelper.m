//
//  XWSegmentConfigHelper.m
//  Pods
//
//  Created by 田学为 on 2019/2/19.
//

#import "XWSegmentConfigHelper.h"

XWSegmentItemWidth XWSegmentItemWidthCreate(CGFloat normal, CGFloat selected) {
    XWSegmentItemWidth width;
    width.normal = normal;
    width.selected = selected;
    return width;
}


CGFloat XWSegmentGetTextSizeWidth(NSString *text, UIFont *font) {
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    CGFloat width = adjustedSize.width;
    return width;

}
