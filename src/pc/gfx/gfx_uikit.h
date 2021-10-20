//
//  gfx_uikit.h
//  sm64ios
//
//  Created by Christian Kosman on 9/21/21.
//

#ifndef gfx_uikit_h
#define gfx_uikit_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "../../ios/native_ui_controller.h"

@interface OverlayView : UIView
-   (id)initWithFrame:(CGRect)frame;
-   (void)drawRect:(CGRect)rect;
-   (BOOL)prefersHomeIndicatorAutoHidden;
-   (UIRectEdge)preferredScreenEdgesDeferringSystemGestures;
@end

@interface OverlayImageView : UIView
{
    CGImageRef imageRef;
}
@property(nonatomic) CGImageRef imageRef;
-   (void)setImageRef:(CGImageRef)newImageRef;
-   (id)initWithFrame:(CGRect)frame;
-   (void)drawRect:(CGRect)rect;
@end

OverlayView *overlayView;

void gfx_uikit_init(UIViewController *viewControllerPointer, struct ScreenData *screenData);
OverlayImageView *add_image_subview(CGImageRef imageRef, CGRect rect);
CGImageRef create_imageref(const char *path);

#endif /* gfx_uikit_h */
