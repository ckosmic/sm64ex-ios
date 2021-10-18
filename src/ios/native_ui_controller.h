//
//  native_ui_controller.h
//  sm64ios
//
//  Created by Christian Kosman on 9/26/21.
//

#ifndef native_ui_controller_h
#define native_ui_controller_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIViewController *present_viewcontroller(NSString *vcName, bool animated);

bool paused_by_menu;

#endif /* native_ui_controller_h */
