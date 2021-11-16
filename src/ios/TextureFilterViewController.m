//
//  TextureFilterViewController.m
//  sm64ios
//
//  Created by Christian Kosman on 9/30/21.
//

#import "TextureFilterViewController.h"
#import "src/pc/configfile.h"


@implementation TextureFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    for (size_t i = 0; i < 2; i++)
    {
        if (i == configFiltering)
        {
            self.lastSelected = i;
        }
    }

    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelected inSection:0]];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((unsigned int)indexPath.row != configFiltering)
    {
        UITableViewCell* old_cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelected inSection:0]];
        [old_cell setAccessoryType:UITableViewCellAccessoryNone];
        
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        configFiltering = (unsigned int)indexPath.row;
        configfile_save(configfile_name());
        
        self.lastSelected = indexPath.row;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
