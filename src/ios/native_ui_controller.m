//
//  native_ui_controller.m
//  sm64ios
//
//  Created by Christian Kosman on 9/26/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include "native_ui_controller.h"

UIViewController *rootVc;

void set_root_viewcontroller(UIViewController *vc) {
    rootVc = vc;
}

void present_viewcontroller(NSString *vcName) {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:vcName];
    if(rootVc != NULL) {
        [rootVc presentViewController:vc animated:YES completion:nil];
    }
}
