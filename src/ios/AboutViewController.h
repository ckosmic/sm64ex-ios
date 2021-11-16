//
//  SettingsViewController.h
//  sm64ios
//
//  Created by Christian Kosman on 9/26/21.
//

#ifndef AboutViewController_h
#define AboutViewController_h

@interface AboutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel* versionLabel;

- (IBAction) dismissAboutViewController:(id)sender;

@end

#endif /* SettingsViewController_h */
