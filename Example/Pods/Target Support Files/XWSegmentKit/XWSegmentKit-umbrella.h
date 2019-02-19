#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "XWSegmentBarFlowLayout.h"
#import "XWSegmentConfigHelper.h"
#import "UIColor+XWSegmentExtension.h"
#import "UIView+XWSegmentExtension.h"
#import "XWSegmentItem.h"
#import "XWSegmentPointer.h"
#import "XWSegmentPointerCustom.h"
#import "XWSegmentPointerLine.h"
#import "XWSegmentBar.h"
#import "XWSegmentContext.h"
#import "XWSegmentKit.h"

FOUNDATION_EXPORT double XWSegmentKitVersionNumber;
FOUNDATION_EXPORT const unsigned char XWSegmentKitVersionString[];

