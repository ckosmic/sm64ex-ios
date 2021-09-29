//
//  controller_touchscreen.h
//  sm64ios
//
//  Created by Christian Kosman on 9/19/21.
//

#ifndef controller_touchscreen_h
#define controller_touchscreen_h

struct TouchEvent {
    int touchID;
    float x, y;
};

void touch_down(struct TouchEvent* event);
void touch_motion(struct TouchEvent* event);
void touch_up(struct TouchEvent* event);

void (*menu_button_pressed)(void); 

extern struct ControllerAPI controller_touchscreen;

#endif /* controller_touchscreen_h */
