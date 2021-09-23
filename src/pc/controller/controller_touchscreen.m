// Feel free to use it in your port too, but please keep authorship!
// Touch Controls made by: VDavid003
// https://github.com/VDavid003/sm64-port-android
// Modified for iOS
#include <stdlib.h>
#include <stdio.h>

#include <ultra64.h>
#include <PR/ultratypes.h>
#include <PR/gbi.h>

#import <UIKit/UIKit.h>

#include "config.h"
#include "sm64.h"
#include "game/game_init.h"
#include "game/memory.h"
#include "game/segment2.h"
#include "gfx_dimensions.h"
#include "pc/gfx/gfx_pc.h"
#include "pc/gfx/gfx_uikit.h"

#include "controller_api.h"
#include "controller_touchscreen.h"

#define SCREEN_WIDTH_API 1280
#define SCREEN_HEIGHT_API 960
#define SCREEN_ASPECT_API ((0.0 + SCREEN_WIDTH_API)/SCREEN_HEIGHT_API)

#define LEFT_EDGE ((int)floorf(SCREEN_WIDTH_API / 2 - SCREEN_HEIGHT_API / 2 * gfx_current_dimensions.aspect_ratio))
#define RIGHT_EDGE ((int)ceilf(SCREEN_WIDTH_API / 2 + SCREEN_HEIGHT_API / 2 * gfx_current_dimensions.aspect_ratio))

#define CORRECT_TOUCH_X(x) ((x * (RIGHT_EDGE - LEFT_EDGE)) + LEFT_EDGE)
#define CORRECT_TOUCH_Y(y) (y * SCREEN_HEIGHT_API)

#define SCREEN_SCALE [[UIScreen mainScreen] scale]

#define N64_TO_IOS_X(x) ((double)(x - LEFT_EDGE) / (double)(RIGHT_EDGE - LEFT_EDGE) * gfx_current_dimensions.width / SCREEN_SCALE)
#define N64_TO_IOS_Y(y) (((0.0 + y) / SCREEN_HEIGHT_API) * gfx_current_dimensions.height / SCREEN_SCALE)

#define N64_DISTANCE_X(a, b) (N64_TO_IOS_X(a) - N64_TO_IOS_X(b))
#define N64_DISTANCE_Y(a, b) (N64_TO_IOS_Y(a) - N64_TO_IOS_Y(b))

#define JOYSTICK_SIZE 280

enum ControlElementType {
    Joystick,
    Button
};

struct Position {
    s32 x,y;
};

struct ControlElement {
    enum ControlElementType type;
    struct Position (*GetPos)();
    int touchID;
    //Joystick
    int joyX, joyY;
    //Button
    int buttonID;
    NSString *label;
    int slideTouch;
    OverlayImageView *imageView;
    OverlayImageView *subImageView;
};

#include "controller_touchscreen_layouts.inc"

static struct ControlElement *ControlElements = ControlElementsDefault;
static int ControlElementsLength = sizeof(ControlElementsDefault)/sizeof(struct ControlElement);

CGImageRef image_button;
CGImageRef image_button_down;
CGImageRef image_joystick;
CGImageRef image_arrow;
CGImageRef image_a;
CGImageRef image_b;
CGImageRef image_z;
CGImageRef image_r;
CGImageRef image_start;

#define TRIGGER_DETECT(size) (((pos.x + size / 2 > CORRECT_TOUCH_X(event->x)) && (pos.x - size / 2 < CORRECT_TOUCH_X(event->x))) &&\
                              ((pos.y + size / 2 > CORRECT_TOUCH_Y(event->y)) && (pos.y - size / 2 < CORRECT_TOUCH_Y(event->y))))

void touch_down(struct TouchEvent* event) {
    struct Position pos;
    for(int i = 0; i < ControlElementsLength; i++) {
        if (ControlElements[i].touchID == 0) {
            pos = ControlElements[i].GetPos();
            switch (ControlElements[i].type) {
                case Joystick:
                    if (TRIGGER_DETECT(JOYSTICK_SIZE)) {
                        ControlElements[i].touchID = event->touchID;
                        ControlElements[i].joyX = CORRECT_TOUCH_X(event->x) - pos.x;
                        ControlElements[i].joyY = CORRECT_TOUCH_Y(event->y) - pos.y;
                    }
                    break;
                case Button:
                    if (TRIGGER_DETECT(120)) {
                        ControlElements[i].touchID = event->touchID;
                    }
                    break;
            }
        }
    }
}

void touch_motion(struct TouchEvent* event) {
    struct Position pos;
    for(int i = 0; i < ControlElementsLength; i++) {
        pos = ControlElements[i].GetPos();
        if (ControlElements[i].touchID == event->touchID) {
            pos = ControlElements[i].GetPos();
                switch (ControlElements[i].type) {
                    case Joystick:
                        ; //workaround
                        s32 x,y;
                        x = CORRECT_TOUCH_X(event->x) - pos.x;
                        y = CORRECT_TOUCH_Y(event->y) - pos.y;
                        if (pos.x + JOYSTICK_SIZE/2 < CORRECT_TOUCH_X(event->x))
                            x = JOYSTICK_SIZE/2;
                        if (pos.x - JOYSTICK_SIZE/2 > CORRECT_TOUCH_X(event->x))
                            x = -JOYSTICK_SIZE/2;
                        if (pos.y + JOYSTICK_SIZE/2 < CORRECT_TOUCH_Y(event->y))
                            y = JOYSTICK_SIZE/2;
                        if (pos.y - JOYSTICK_SIZE/2 > CORRECT_TOUCH_Y(event->y))
                            y = -JOYSTICK_SIZE/2;

                        ControlElements[i].joyX = x;
                        ControlElements[i].joyY = y;
                        break;
                    case Button:
                        if (ControlElements[i].slideTouch && !TRIGGER_DETECT(120)) {
                            ControlElements[i].slideTouch = 0;
                            ControlElements[i].touchID = 0;
                        }
                        break;
                }
        }
        else {
            switch (ControlElements[i].type) {
                case Joystick:
                    break;
                case Button:
                    if (TRIGGER_DETECT(120)) {
                        ControlElements[i].slideTouch = 1;
                        ControlElements[i].touchID = event->touchID;
                    }
                    break;
            }
        }
    }
}

static void handle_touch_up(int i) {//seperated for when the layout changes
    ControlElements[i].touchID = 0;
    switch (ControlElements[i].type) {
        case Joystick:
            ControlElements[i].joyX = 0;
            ControlElements[i].joyY = 0;
            break;
        case Button:
            break;
    }
}

void touch_up(struct TouchEvent* event) {
    struct Position pos;
    for(int i = 0; i < ControlElementsLength; i++) {
        if (ControlElements[i].touchID == event->touchID)
            handle_touch_up(i);
    }
}

void add_button_label(OverlayImageView *button, NSString *labelString, CGRect rect) {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = labelString;
    
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [button addSubview:label];
}

void render_touch_controls(void) {
    struct Position pos;
    for (int i = 0; i < ControlElementsLength; i++) {
        pos = ControlElements[i].GetPos();
        CGRect rect = CGRectMake(N64_TO_IOS_X(pos.x - 64), N64_TO_IOS_Y(pos.y - 64), N64_DISTANCE_X(pos.x+64,pos.x-64), N64_DISTANCE_Y(pos.y+64,pos.y-64));
        switch (ControlElements[i].type) {
            case Joystick:
                ;
                CGRect bgRect = CGRectMake(N64_TO_IOS_X(pos.x - 128), N64_TO_IOS_Y(pos.y - 128), N64_DISTANCE_X(pos.x+128,pos.x-128), N64_DISTANCE_Y(pos.y+128,pos.y-128));
                CGRect jsRect = CGRectMake(N64_TO_IOS_X(pos.x + ControlElements[i].joyX - 64), N64_TO_IOS_Y(pos.y + ControlElements[i].joyY - 64), N64_DISTANCE_X(pos.x+64,pos.x-64), N64_DISTANCE_Y(pos.y+64,pos.y-64));
                // Draw joystick background
                if(ControlElements[i].imageView == NULL)
                    ControlElements[i].imageView = add_image_subview(image_joystick, bgRect);
                // Draw joystick nub
                if(ControlElements[i].subImageView == NULL)
                    ControlElements[i].subImageView = add_image_subview(image_button, jsRect);
            
                // Reposition joystick nub
                ControlElements[i].subImageView.frame = jsRect;
                break;
            case Button:
                ;
                if(ControlElements[i].imageView == NULL) {
                    ControlElements[i].imageView = add_image_subview(image_button, rect);
                    switch(ControlElements[i].buttonID) {
                        case U_CBUTTONS:
                            ControlElements[i].subImageView = add_image_subview(image_arrow, rect);
                            [ControlElements[i].subImageView setRotation:180.0];
                            break;
                        case D_CBUTTONS:
                            ControlElements[i].subImageView = add_image_subview(image_arrow, rect);
                            [ControlElements[i].subImageView setRotation:0.0];
                            break;
                        case L_CBUTTONS:
                            ControlElements[i].subImageView = add_image_subview(image_arrow, rect);
                            [ControlElements[i].subImageView setRotation:90.0];
                            break;
                        case R_CBUTTONS:
                            ControlElements[i].subImageView = add_image_subview(image_arrow, rect);
                            [ControlElements[i].subImageView setRotation:270.0];
                            break;
                        case A_BUTTON:
                            ControlElements[i].subImageView = add_image_subview(image_a, rect);
                            break;
                        case B_BUTTON:
                            ControlElements[i].subImageView = add_image_subview(image_b, rect);
                            break;
                        case Z_TRIG:
                            ControlElements[i].subImageView = add_image_subview(image_z, rect);
                            break;
                        case R_TRIG:
                            ControlElements[i].subImageView = add_image_subview(image_r, rect);
                            break;
                        case START_BUTTON:
                            ControlElements[i].subImageView = add_image_subview(image_start, rect);
                            break;
                    }
                }
                
                if (ControlElements[i].touchID)
                    [ControlElements[i].imageView setImageRef:image_button_down];
                else
                    [ControlElements[i].imageView setImageRef:image_button];
                break;
        }
    }
}

static void touchscreen_init(void) {
    image_button = create_imageref("res/touch_button.png");
    image_button_down = create_imageref("res/touch_button_dark.png");
    image_joystick = create_imageref("res/touch_joystick.png");
    image_arrow = create_imageref("res/icon_arrow.png");
    image_a = create_imageref("res/icon_a.png");
    image_b = create_imageref("res/icon_b.png");
    image_z = create_imageref("res/icon_z.png");
    image_r = create_imageref("res/icon_r.png");
    image_start = create_imageref("res/icon_start.png");
}

static void touchscreen_read(OSContPad *pad) {
    for(int i = 0; i < ControlElementsLength; i++) {
        switch (ControlElements[i].type) {
            case Joystick:
                if (ControlElements[i].joyX || ControlElements[i].joyY) {
                    pad->stick_x = (ControlElements[i].joyX + JOYSTICK_SIZE/2) * 255 / JOYSTICK_SIZE - 128;
                    pad->stick_y = (-ControlElements[i].joyY + JOYSTICK_SIZE/2) * 255 / JOYSTICK_SIZE - 128; //inverted for some reason
                }
                break;
            case Button:
                if (ControlElements[i].touchID) {
                    pad->button |= ControlElements[i].buttonID;
                }
                break;
        }
    }
}

static u32 touchscreen_rawkey(void) { //dunno what this does but I'll skip it for now
    return VK_INVALID;
}

static void touchscreen_shutdown(void) {
    CGImageRelease(image_button);
    CGImageRelease(image_button_down);
    for(int i = 0; i < ControlElementsLength; i++) {
        [ControlElements[i].imageView release];
        [ControlElements[i].subImageView release];
    }
}

struct ControllerAPI controller_touchscreen = {
    0,
    touchscreen_init,
    touchscreen_read,
    touchscreen_rawkey,
    NULL,
    NULL,
    NULL,
    touchscreen_shutdown
};
