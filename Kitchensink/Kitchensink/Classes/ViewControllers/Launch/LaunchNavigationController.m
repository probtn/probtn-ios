//----------------------------------------------//

#import "LaunchNavigationController.h"

//----------------------------------------------//
#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
//----------------------------------------------//

#import "LaunchViewController.h"

//----------------------------------------------//

@interface LaunchNavigationController () {
    FG_SAFE_UNRETAINED(Window*) mWindow;
}

@end

//----------------------------------------------//

@implementation LaunchNavigationController

+ (id)controllerWithWindow:(Window*)window {
    return [[self alloc] initWithWindow:window];
}

- (id)initWithWindow:(Window*)window {
    LaunchViewController* controller = [LaunchViewController controllerWithWindow:window];
    if(controller != nil) {
        self = [super initWithRootController:controller];
        if(self != nil) {
            mWindow = window;
        }
    } else {
        FG_SAFE_DEALLOC;
    }
    return self;
}

- (void)dealloc {
    FG_SAFE_DEALLOC;
}

@end

//----------------------------------------------//
#endif
//----------------------------------------------//
