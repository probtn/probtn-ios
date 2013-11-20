//----------------------------------------------//

#import "FGSlideNavigation.h"

//----------------------------------------------//

@class Window;
@class MainMenuController;

//----------------------------------------------//

@interface MainNavigationController : FGSlideNavigation

@property(nonatomic, readonly) Window* window;
@property(nonatomic, readonly) MainMenuController* mainMenuController;

+ (id)controllerWithWindow:(Window*)window;
- (id)initWithWindow:(Window*)window;

@end

//----------------------------------------------//
