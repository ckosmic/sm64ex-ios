//
//  FrameController.h
//  sm64ios
//
//  Created by Christian Kosman on 11/2/21.
//

#ifndef FrameController_h
#define FrameController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FrameController : NSObject
@property(nonatomic, retain) CADisplayLink *gfxDisplayLink;
@property(nonatomic, retain) NSMutableArray *onScreenRefresh;
- (id)init;
- (void)startMainLoop;
- (void)tick:(CADisplayLink *)sender;
@end

FrameController *frameController;

#endif /* FrameController_h */
