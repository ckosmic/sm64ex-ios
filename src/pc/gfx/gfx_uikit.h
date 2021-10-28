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
#import "../../ios/ExternalGameViewController.h"
#import "../../ios/TouchControlsViewController.h"

@interface OverlayView : UIView
-   (id)initWithFrame:(CGRect)frame;
-   (void)drawRect:(CGRect)rect;
-   (BOOL)prefersHomeIndicatorAutoHidden;
-   (UIRectEdge)preferredScreenEdgesDeferringSystemGestures;
@end

TouchControlsViewController *tcvc;
UIViewController *gameViewController;

void gfx_uikit_init(UIViewController *viewControllerPointer);
void setup_external_screen();
void gfx_uikit_set_touchscreen_callbacks(void (*down)(void* event), void (*motion)(void* event), void (*up)(void* event));

#endif /* gfx_uikit_h */
