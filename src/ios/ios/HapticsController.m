//
//  HapticsController.m
//  sm64ios
//
//  Nabbed from SDL_mfijoystick.m
//

#import "HapticsController.h"

@implementation HapticsController

- (void)cleanup {
    if(self.player != nil) {
        [self.player cancelAndReturnError:nil];
        self.player = nil;
    }
    if(self.engine != nil) {
        [self.engine stopWithCompletionHandler:nil];
        self.engine = nil;
    }
}

- (void)rumble:(float)intensity duration:(double)duration {
    @autoreleasepool {
        NSError *error = nil;
        
        if(self.engine == nil) {
            printf("Haptic engine stopped, ignoring rumble\n");
            return;
        }
        
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
            if(error != nil) {
                printf("Could not create haptic pattern\n");
            }
            
            self.player = [self.engine createPlayerWithPattern:pattern error:&error];
            if(error != nil) {
                printf("Could not create haptic player: %s\n", [error.localizedDescription UTF8String]);
            }
            self.active = false;
        }
        
        CHHapticDynamicParameter *param = [[CHHapticDynamicParameter alloc] initWithParameterID:CHHapticDynamicParameterIDHapticIntensityControl value:intensity relativeTime:0];
        [self.player sendParameters:[NSArray arrayWithObject:param] atTime:0 error:&error];
        if(error != nil) {
            printf("Could not update haptic player: %s\n", [error.localizedDescription UTF8String]);
        }
        
        if(!self.active) {
            [self.player startAtTime:0 error:&error];
            self.active = true;
        }
    }
}

- (id)init {
    @autoreleasepool {
        self = [super init];
        
        NSError *error = nil;
        self.engine = [[CHHapticEngine alloc] initAndReturnError:&error];
        if(error != nil) {
            printf("Could not create haptic engine\n");
            return nil;
        }
        self.engine.playsHapticsOnly = YES;
        [self.engine startAndReturnError:&error];
        if(error != nil) {
            printf("Could not start haptic engine\n");
            return nil;
        }
        
        __weak __typeof__(self) weakSelf = self;
        [self.engine setStoppedHandler:^(CHHapticEngineStoppedReason reason) {
            HapticsController *_this = weakSelf;
            if(_this == nil)
                return;
            
            _this.player = nil;
            _this.engine = nil;
            printf("Haptic engine stopped\n");
        }];
        
        [self.engine setResetHandler:^() {
            HapticsController *_this = weakSelf;
            if(_this == nil)
                return;
            
            _this.player = nil;
            [_this.engine startAndReturnError:nil];
            printf("Haptic engine reset\n");
        }];
        
        return self;
    }
}

@end

bool hapticsSupported() {
    return CHHapticEngine.capabilitiesForHardware.supportsHaptics;
}
