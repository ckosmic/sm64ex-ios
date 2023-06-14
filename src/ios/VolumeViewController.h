//
//  VolumeViewController.h
//  sm64ios
//
//  Created by Christian Kosman on 6/11/23.
//

#ifndef VolumeViewController_h
#define VolumeViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#if TARGET_OS_TV
#import "src/ios/tvos/TVOSSlider.h"
#define UISlider TVOSSlider
#endif

@interface VolumeViewController : UITableViewController

#if TARGET_OS_IOS
@property (weak, nonatomic) IBOutlet UISlider* masterVolumeSlider;
@property (weak, nonatomic) IBOutlet UISlider* musicVolumeSlider;
@property (weak, nonatomic) IBOutlet UISlider* sfxVolumeSlider;
@property (weak, nonatomic) IBOutlet UISlider* envVolumeSlider;
#elif TARGET_OS_TV
@property (weak, nonatomic) IBOutlet TVOSSlider* masterVolumeSlider;
@property (weak, nonatomic) IBOutlet TVOSSlider* musicVolumeSlider;
@property (weak, nonatomic) IBOutlet TVOSSlider* sfxVolumeSlider;
@property (weak, nonatomic) IBOutlet TVOSSlider* envVolumeSlider;
#endif

@property (weak, nonatomic) IBOutlet UILabel* masterVolumeLabel;
@property (weak, nonatomic) IBOutlet UILabel* musicVolumeLabel;
@property (weak, nonatomic) IBOutlet UILabel* sfxVolumeLabel;
@property (weak, nonatomic) IBOutlet UILabel* envVolumeLabel;

@end


#endif /* VolumeViewController_h */
