//
//  TouchControlsViewController.h
//  sm64ios
//
//  Created by Christian Kosman on 10/25/21.
//

#ifndef TouchControlsViewController_h
#define TouchControlsViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OverlayImageView : UIImageView
{
    CGImageRef imageRef;
}
@property (weak, nonatomic) IBOutlet OverlayImageView* subimage;
@property (nonatomic) int buttonTag;
@property (nonatomic) CGImageRef imageRef;

-   (void)setImageRef:(CGImageRef)newImageRef;
-   (id)initWithFrame:(CGRect)frame;
-   (void)drawRect:(CGRect)rect;
@end

@interface GestureRecognizer : UIGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action;
- (void)set_touchscreen_callbacks:(void (*)(void* event))down motion:(void (*)(void* event))motion up:(void (*)(void* event))up;

@end

@interface TouchControlsViewController : UIViewController

@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_l;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_r;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_a;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_b;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_z;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_up;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_down;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_left;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_right;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_start;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_menu;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_joystick;
@property (weak, nonatomic) IBOutlet OverlayImageView* m_iv_joystick_bg;

@property (weak, nonatomic) IBOutlet UIImageView* m_gl_up;
@property (weak, nonatomic) IBOutlet UIImageView* m_gl_down;
@property (weak, nonatomic) IBOutlet UIImageView* m_gl_left;
@property (weak, nonatomic) IBOutlet UIImageView* m_gl_right;

@end

#endif /* TouchControlsViewController_h */
