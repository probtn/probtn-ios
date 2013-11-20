//----------------------------------------------//

#import "CoreNavigationController.h"

//----------------------------------------------//
#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
//----------------------------------------------//

@interface LaunchNavigationController : CoreNavigationController

@property(nonatomic, readonly) Window* window;

+ (id)controllerWithWindow:(Window*)window;

- (id)initWithWindow:(Window*)window;

@end

//----------------------------------------------//
#endif
//----------------------------------------------//
