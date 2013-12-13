//----------------------------------------------//

#import "MainNavigationController.h"
#import "MainMenuController.h"
#import "CoreNavigationController.h"

//----------------------------------------------//

@interface MainNavigationController () {
    FG_SAFE_UNRETAINED(Window*) mWindow;
}

@end

//----------------------------------------------//

@implementation MainNavigationController

@synthesize window = mWindow;

#pragma mark - Default

+ (id)controllerWithWindow:(Window*)window {
    return [[self alloc] initWithWindow:window];
}

- (id)initWithWindow:(Window*)window {
    MainMenuController* menuController = [MainMenuController controllerWithWindow:window];
    self = [super initWithMenuViewController:menuController contentViewController:[menuController clearViewController]];
    if(self != nil) {
        mWindow = window;
#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_LITE)
        [self openMenu];
#endif
    }
    return self;
}

- (void)dealloc {
    FG_SAFE_DEALLOC;
}

#pragma mark - Public

- (MainMenuController*)mainMenuController {
    if([[self menuViewController] isKindOfClass:[MainMenuController class]] == YES) {
        return (MainMenuController*)[self menuViewController];
    }
    return nil;
}

@end

//----------------------------------------------//
