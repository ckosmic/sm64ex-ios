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
@property(nonatomic) CADisplayLink *gfxDisplayLink;
@property(nonatomic) NSMutableArray *onScreenRefresh;
@property(nonatomic) NSMutableArray *onScreenRefreshForGame;
@property(nonatomic) NSInteger swapInterval;
- (id)init;
- (void)startMainLoop;
- (void)tick:(CADisplayLink *)sender;
- (void)setPreferredFramesPerSecond:(NSInteger)fps;
@end

FrameController *frameController;

#endif /* FrameController_h */
