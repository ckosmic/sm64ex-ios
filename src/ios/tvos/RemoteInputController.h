//
//  RemoteInputController.h
//  sm64ios
//
//  Created by Christian Kosman on 11/11/21.
//

#ifndef RemoteInputController_h
#define RemoteInputController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RemoteInputController : NSObject

@property(nonatomic, retain) NSMutableArray *onMenuButtonPressed;

- (id)initWithTarget:(UIViewController *)viewController;

@end

#endif /* RemoteInputController_h */
