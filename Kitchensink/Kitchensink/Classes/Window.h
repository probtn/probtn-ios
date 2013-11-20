//----------------------------------------------//

#import "FGUIKit.h"

//----------------------------------------------//

#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
@class LaunchNavigationController;
#endif
@class MainNavigationController;

//----------------------------------------------//

@interface Window : UIWindow

#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
@property(nonatomic, readonly) LaunchNavigationController* launchNavigationControler;
#endif
@property(nonatomic, readonly) MainNavigationController* mainNavigationControler;

#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
- (void)showLaunchNavigationController;
- (void)showMainNavigationController;
#endif

@end

//----------------------------------------------//
