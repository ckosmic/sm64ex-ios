//
//  gfx_uikit.m
//  sm64ios
//
//  Created by Christian Kosman on 9/21/21.
//

#include <math.h>
#import "gfx_uikit.h"
#import "../../ios/ExternalGameViewController.h"
#import <objc/runtime.h>

OverlayView *overlayView;
UIViewController *gameViewController;
UIWindow *externalWindow;

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

void gfx_uikit_init(UIViewController *viewControllerPointer) {
    gameViewController = viewControllerPointer;
    
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    
    CGRect mainScreenBounds = [[UIScreen mainScreen] bounds];
    overlayView = [[OverlayView alloc] initWithFrame:mainScreenBounds];
    
    if([[UIScreen screens] count] > 1) {
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:overlayView];
    
        //setup_external_screen();
    } else {
        [gameViewController.view addSubview:overlayView];
    }
}

void setup_external_screen() {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ExternalGameViewController *externalVc = [storyboard instantiateViewControllerWithIdentifier:@"ExternalScreen"];
    UIScreen *screen = [UIScreen screens][1];
    externalWindow = [[objc_getClass("SDL_uikitwindow") alloc] initWithFrame:screen.bounds];
    externalWindow.rootViewController = nil;
    externalWindow.rootViewController = externalVc;
    externalWindow.screen = screen;
    externalWindow.screen.overscanCompensation = UIScreenOverscanCompensationScale;
    externalWindow.hidden = NO;
    UIView *realView = gameViewController.view;
    [externalVc.view addSubview:realView];
    realView.frame = externalVc.view.bounds;
    realView.contentScaleFactor = 1.0;
}
