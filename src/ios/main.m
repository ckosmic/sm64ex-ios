#include <SDL2/SDL.h>

#include "pc/cliopts.h"
#include "pc/pc_main.h"

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@interface MainViewController : UIViewController
-   (BOOL)prefersHomeIndicatorAutoHidden;
@end

@implementation MainViewController

-   (BOOL)prefersHomeIndicatorAutoHidden {
    return TRUE;
}

@end

@implementation AppDelegate

-   (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(id)options {
    CGRect mainScreenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:mainScreenBounds];
    MainViewController *viewController = [[MainViewController alloc] init];
    
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.view.frame = mainScreenBounds;
    
    UILabel *label = [[UILabel alloc] initWithFrame:mainScreenBounds];
    [label setText:@"Hello world"];
    [viewController.view addSubview: label];
    
    self.window.rootViewController = viewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

int main(int argc, char *argv[]) {
    parse_cli_opts(argc, argv);
    main_func();
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

