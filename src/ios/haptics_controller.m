//
//  haptics_controller.m
//  sm64ios
//
//  Created by Christian Kosman on 9/29/21.
//

#import "haptics_controller.h"

@implementation HapticsController

- (void)cleanup
{
    if(self.player != nil) {
        [self.player cancelAndReturnError:nil];
        self.player = nil;
    }
    if(self.engine != nil) {
        [self.engine stopWithCompletionHandler:nil];
        self.engine = nil;
    }
}

- (void)rumble:(float)intensity duration:(double)duration
{
    @autoreleasepool {
        NSError *error = nil;
        
        if(intensity == 0.0f) {
            if(self.player && self.active) {
                [self.player stopAtTime:0 error:&error];
            }
            self.active = false;
            return;
        }
        
        if(self.player == nil) {
            CHHapticEventParameter *param = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:intensity];
            CHHapticEventParameter *param2 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticSharpness value:1.0f];
            CHHapticEvent *event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous parameters:[NSArray arrayWithObjects:param, param2, nil] relativeTime:0 duration:duration];
            
            CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:[NSArray arrayWithObject:event] parameters:[[NSArray alloc] init] error:&error];
            
            self.player = [self.engine createPlayerWithPattern:pattern error:&error];
            [self.engine createAdvancedPlayerWithPattern:pattern error:&error];
            self.active = false;
        }
        
        CHHapticDynamicParameter *param = [[CHHapticDynamicParameter alloc] initWithParameterID:CHHapticDynamicParameterIDHapticIntensityControl value:intensity relativeTime:0];
        [self.player sendParameters:[NSArray arrayWithObject:param] atTime:0 error:&error];
        
        if(!self.active) {
            [self.player startAtTime:0 error:&error];
            self.active = true;
        }
    }
}

- (id)initialize
{
    @autoreleasepool {
        NSError *error = nil;
        self.engine = [[CHHapticEngine alloc] initAndReturnError:&error];
        [self.engine startAndReturnError:&error];
        
        return self;
    }
}

@end
