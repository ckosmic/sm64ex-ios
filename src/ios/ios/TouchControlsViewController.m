//
//  TouchControlsViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 10/25/21.
//

#import "TouchControlsViewController.h"
#import "src/pc/controller/controller_touchscreen.h"
#include "src/pc/configfile.h"
#include <PR/os_cont.h>

@implementation OverlayImageView

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setRotation:(CGFloat)angle {
    CGFloat radians = angle / 180.0 * M_PI;
    CGAffineTransform rotation = CGAffineTransformRotate(self.transform, radians);
    self.transform = rotation;
}

@end

@implementation GestureRecognizer {
    void (*touch_down_callback)(void* event);
    void (*touch_motion_callback)(void* event);
    void (*touch_up_callback)(void* event);
    
    NSMutableArray *trackedTouches;
}

- (id)initWithTarget:(id)target action:(SEL)action {
    if((self = [super initWithTarget:target action:action])) {
        
    }
    trackedTouches = [[NSMutableArray alloc] init];
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [trackedTouches addObjectsFromArray:[touches allObjects]];
    for(int i = 0; i < trackedTouches.count; i++) {
        UITouch *touch = [trackedTouches objectAtIndex:i];
        if(![touch isEqual:[NSNull null]]) {
            CGPoint position = [touch locationInView:self.view];
            struct TouchEvent touchEvent;
            touchEvent.x = position.x;
            touchEvent.y = position.y;
            touchEvent.touchID = i + 1;
            if (touch_down_callback != NULL) {
                touch_down_callback((void*)&touchEvent);
            }
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    for(UITouch *touch in touches) {
        if(![touch isEqual:[NSNull null]]) {
            int i = [trackedTouches indexOfObject:touch];
            UITouch *touch = [trackedTouches objectAtIndex:i];
            CGPoint position = [touch locationInView:self.view];
            struct TouchEvent touchEvent;
            touchEvent.x = position.x;
            touchEvent.y = position.y;
            touchEvent.touchID = i + 1;
            if (touch_motion_callback != NULL) {
                touch_motion_callback((void*)&touchEvent);
            }
        }
    }
}

- (void)handleTouchesEnded:(NSSet<UITouch *> *)touches {
    bool isAllNull = YES;
    for(UITouch *touch in touches) {
        if(![touch isEqual:[NSNull null]]) {
            isAllNull = NO;
            int i = [trackedTouches indexOfObject:touch];
            UITouch *touch = [trackedTouches objectAtIndex:i];
            CGPoint position = [touch locationInView:self.view];
            struct TouchEvent touchEvent;
            touchEvent.x = position.x;
            touchEvent.y = position.y;
            touchEvent.touchID = i + 1;
            if (touch_up_callback != NULL) {
                touch_up_callback((void*)&touchEvent);
            }
            [trackedTouches setObject:[NSNull null] atIndexedSubscript:i];
        }
    }
    if(isAllNull) {
        [trackedTouches removeAllObjects];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self handleTouchesEnded:touches];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self handleTouchesEnded:touches];
}

- (void)set_touchscreen_callbacks:(void (*)(void* event))down motion:(void (*)(void* event))motion up:(void (*)(void* event))up {
    touch_down_callback = down;
    touch_motion_callback = motion;
    touch_up_callback = up;
}

- (void)reset {
    [super reset];
}

@end

@implementation TouchControlsViewController {
    void (*touch_down_callback)(void* event);
    void (*touch_motion_callback)(void* event);
    void (*touch_up_callback)(void* event);
    
    GestureRecognizer *gestureRecognizer;
    bool hidden;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.multipleTouchEnabled = YES;
    gestureRecognizer = [[GestureRecognizer alloc] initWithTarget:self action:@selector(handleTouchAction:)];
    gestureRecognizer.cancelsTouchesInView = YES;
    [gestureRecognizer set_touchscreen_callbacks:touch_down_callback motion:touch_motion_callback up:touch_up_callback];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    [self.m_gl_up setRotation:0.0];
    [self.m_gl_down setRotation:180.0];
    [self.m_gl_left setRotation:270.0];
    [self.m_gl_right setRotation:90.0];
    
    CGFloat scale = ((float)configTouchUiScale/100.0);
    [self setTouchControlsScale:scale];
    
    [self setTouchscreenImageViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTouchControlsScaleHandler:) name:@"SetTouchUIScale" object:nil];
}

- (void)setTouchControlsScaleHandler:(NSNotification *)notification {
    NSDictionary *dict = [notification userInfo];
    CGFloat scale = (CGFloat)[dict[@"scale"] floatValue];
    [self setTouchControlsScale:scale];
}

- (void)setTouchControlsScale:(CGFloat)scale {
    self.m_group_lr.transform = CGAffineTransformMakeScale(scale, scale);
    self.m_group_joystick.transform = CGAffineTransformMakeScale(scale, scale);
    self.m_group_startmenu.transform = CGAffineTransformMakeScale(scale, scale);
    self.m_group_main.transform = CGAffineTransformMakeScale(scale, scale);
    self.m_group_cbuttons.transform = CGAffineTransformMakeScale(scale, scale);
    
    touchscreen_reset_joystick_size();
}

- (void)setTouchscreenImageViews {
    self.m_iv_l.buttonTag = L_TRIG;
    self.m_iv_r.buttonTag = R_TRIG;
    self.m_iv_a.buttonTag = A_BUTTON;
    self.m_iv_b.buttonTag = B_BUTTON;
    self.m_iv_z.buttonTag = Z_TRIG;
    self.m_iv_up.buttonTag = U_CBUTTONS;
    self.m_iv_down.buttonTag = D_CBUTTONS;
    self.m_iv_left.buttonTag = L_CBUTTONS;
    self.m_iv_right.buttonTag = R_CBUTTONS;
    self.m_iv_start.buttonTag = START_BUTTON;
    self.m_iv_menu.buttonTag = 69;
    self.m_iv_joystick.buttonTag = 420;
    self.m_iv_joystick_bg.buttonTag = 69420;
    
    NSMutableArray *imageViews = [[NSMutableArray alloc] init];
    [imageViews addObject:self.m_iv_l];
    [imageViews addObject:self.m_iv_r];
    [imageViews addObject:self.m_iv_a];
    [imageViews addObject:self.m_iv_b];
    [imageViews addObject:self.m_iv_z];
    [imageViews addObject:self.m_iv_up];
    [imageViews addObject:self.m_iv_down];
    [imageViews addObject:self.m_iv_left];
    [imageViews addObject:self.m_iv_right];
    [imageViews addObject:self.m_iv_start];
    [imageViews addObject:self.m_iv_menu];
    [imageViews addObject:self.m_iv_joystick];
    [imageViews addObject:self.m_iv_joystick_bg];
    touchscreen_set_imageviews(imageViews);
}

- (void)handleTouchAction:(GestureRecognizer *)sender {
    
}

- (void)set_touchscreen_callbacks:(void (*)(void* event))down motion:(void (*)(void* event))motion up:(void (*)(void* event))up {
    touch_down_callback = down;
    touch_motion_callback = motion;
    touch_up_callback = up;
    [gestureRecognizer set_touchscreen_callbacks:touch_down_callback motion:touch_motion_callback up:touch_up_callback];
}

- (void)setTouchControlsHidden:(bool)hide {
    if(hidden == hide) return;
    hidden = hide;
    for(UIView *overlayView in self.view.subviews) {
        overlayView.hidden = hide;
    }
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures {
    return UIRectEdgeBottom;
}

@end
