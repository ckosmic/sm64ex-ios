//
//  VolumeViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 6/11/23.
//

#import "VolumeViewController.h"
#import "src/pc/configfile.h"

#if TARGET_OS_TV
#define UISlider TVOSSlider
#endif

@implementation VolumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setVolumeLabelValue:(UILabel *)label toVolumeValue:(int)volumeValue {
    int percentValue = (int)(((float)volumeValue / 127.0) * 100.0);
    label.text = [NSString stringWithFormat:@"%d%%", percentValue];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.masterVolumeSlider setValue:configMasterVolume animated:FALSE];
    [self.musicVolumeSlider setValue:configMusicVolume animated:FALSE];
    [self.sfxVolumeSlider setValue:configSfxVolume animated:FALSE];
    [self.envVolumeSlider setValue:configEnvVolume animated:FALSE];
    
    [self setVolumeLabelValue:self.masterVolumeLabel toVolumeValue:configMasterVolume];
    [self setVolumeLabelValue:self.musicVolumeLabel toVolumeValue:configMusicVolume];
    [self setVolumeLabelValue:self.sfxVolumeLabel toVolumeValue:configSfxVolume];
    [self setVolumeLabelValue:self.envVolumeLabel toVolumeValue:configEnvVolume];
}

- (IBAction)MasterVolumeChanged:(id)sender {
    configMasterVolume = (unsigned int)((UISlider *)sender).value;
    configfile_save(configfile_name());
    [self setVolumeLabelValue:self.masterVolumeLabel toVolumeValue:configMasterVolume];
}

- (IBAction)MusicVolumeChanged:(id)sender {
    configMusicVolume = (unsigned int)((UISlider *)sender).value;
    configfile_save(configfile_name());
    [self setVolumeLabelValue:self.musicVolumeLabel toVolumeValue:configMusicVolume];
}

- (IBAction)SfxVolumeChanged:(id)sender {
    configSfxVolume = (unsigned int)((UISlider *)sender).value;
    configfile_save(configfile_name());
    [self setVolumeLabelValue:self.sfxVolumeLabel toVolumeValue:configSfxVolume];
}

- (IBAction)EnvVolumeChanged:(id)sender {
    configEnvVolume = (unsigned int)((UISlider *)sender).value;
    configfile_save(configfile_name());
    [self setVolumeLabelValue:self.envVolumeLabel toVolumeValue:configEnvVolume];
}

@end
