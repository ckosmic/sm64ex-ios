//
//  MenuViewController.h
//  sm64ios
//
//  Created by Christian Kosman on 9/26/21.
//

#ifndef MenuViewController_h
#define MenuViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel* m_version_label;

- (IBAction) dismissAboutViewController:(id)sender;

@end

#endif /* MenuViewController_h */
