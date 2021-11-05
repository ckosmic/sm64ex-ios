//
//  HapticsController.h
//  sm64ios
//
//  Created by Christian Kosman on 9/29/21.
//

#ifndef haptics_controller_h
#define haptics_controller_h

#import <Foundation/Foundation.h>
#import <CoreHaptics/CoreHaptics.h>

@interface HapticsController : NSObject

@property(nonatomic,strong) CHHapticEngine *engine;
@property(nonatomic,strong) id<CHHapticPatternPlayer> player;
@property bool active;

- (id)init;
- (void)rumble:(float)intensity duration:(double)duration;
- (void)cleanup;

@end

bool hapticsSupported();

#endif /* haptics_controller_h */
