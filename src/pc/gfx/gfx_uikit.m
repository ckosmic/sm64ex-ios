//
//  gfx_uikit.m
//  sm64ios
//
//  Created by Christian Kosman on 9/21/21.
//

#include <math.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include "gfx_uikit.h"

OverlayView *overlayView;

@implementation OverlayView

-   (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-   (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
}

-   (BOOL)prefersHomeIndicatorAutoHidden {
    return TRUE;
}

-   (UIRectEdge)preferredScreenEdgesDeferringSystemGestures {
    return UIRectEdgeBottom;
}

@end

@implementation OverlayImageView

-   (CGImageRef) imageRef {
    return imageRef;
}

-   (void)setImageRef:(CGImageRef)newImageRef {
    if(imageRef != newImageRef) {
        imageRef = newImageRef;
        [self setNeedsDisplay];
    }
}

-   (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-   (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, 0.7);
    CGContextDrawImage(context, rect, self.imageRef);
}

-   (void)setRotation:(CGFloat)angle {
    CGFloat radians = angle / 180.0 * M_PI;
    CGAffineTransform rotation = CGAffineTransformRotate(self.transform, radians);
    self.transform = rotation;
}

@end

CGImageRef create_imageref(const char *path) {
    NSString *nsPath = [NSString stringWithUTF8String:path];
    CGDataProviderRef imageDataProvider = CGDataProviderCreateWithCFData((CFDataRef)[NSData dataWithContentsOfFile:nsPath]);
    CGImageRef imageRef = CGImageCreateWithPNGDataProvider(imageDataProvider, NULL, true, kCGRenderingIntentDefault);
    return imageRef;
}

OverlayImageView *add_image_subview(CGImageRef imageRef, CGRect rect) {
    OverlayImageView *v = [[OverlayImageView alloc] initWithFrame:rect];
    [v setImageRef:imageRef];
    v.contentMode = UIViewContentModeRedraw;
    [overlayView addSubview:v];
    return v;
}

void gfx_uikit_init(long *viewControllerPointer) {
    // There's probably a better way to do this than pointer casting
    UIViewController *viewController = (UIViewController *)viewControllerPointer;
    
    CGRect mainScreenBounds = [[UIScreen mainScreen] bounds];
    overlayView = [[OverlayView alloc] initWithFrame:mainScreenBounds];
    
    
    
    [viewController.view addSubview:overlayView];
}
