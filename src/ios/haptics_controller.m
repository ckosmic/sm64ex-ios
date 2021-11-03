//
//  haptics_controller.m
//  sm64ios
//
//  Nabbed from SDL_mfijoystick.m
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
        CHHapticEvent *event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous parameters:@[param, param2] relativeTime:0 duration:duration];
        
        CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:@[event] parameters:@[] error:&error];
        
        self.player = [self.engine createAdvancedPlayerWithPattern:pattern error:&error];
        self.player.isMuted = NO;
        self.active = false;
    }
    
    CHHapticDynamicParameter *param = [[CHHapticDynamicParameter alloc] initWithParameterID:CHHapticDynamicParameterIDHapticIntensityControl value:intensity relativeTime:0];
    [self.player sendParameters:@[param] atTime:0 error:&error];
    
    if(!self.active) {
        [self.player startAtTime:0 error:&error];
        self.active = true;
    }
}

- (id)init
{
    if(self == [super init]) {
        NSError *error = nil;
        self.engine = [[CHHapticEngine alloc] initAndReturnError:&error];
        self.engine.isMutedForHaptics = NO;
        [self.engine startAndReturnError:&error];
        
        __weak __typeof__(self) weakSelf = self;
        [self.engine setStoppedHandler:^(CHHapticEngineStoppedReason reason) {
            printf("[sm64ios] Haptic engine stopped\n");
            HapticsController *_this = weakSelf;
            if(_this == nil)
                return;
            
            _this.player = nil;
            _this.engine = nil;
        }];
        
        [self.engine setResetHandler:^() {
            printf("[sm64ios] Haptic engine reset\n");
            HapticsController *_this = weakSelf;
            if(_this == nil)
                return;
            
            _this.player = nil;
            [_this.engine startAndReturnError:nil];
        }];
    }
    return self;
}

@end

bool hapticsSupported() {
    return CHHapticEngine.capabilitiesForHardware.supportsHaptics;
}
