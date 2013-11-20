//----------------------------------------------//
/*                                                  */
/*  Author:         Alexander Trifonov              */
/*  Contact:        fgengine@gmail.com              */
/*                                                  */
//----------------------------------------------//

#import "FGUIKit.h"

//----------------------------------------------//

typedef enum {
	FGSlideNavigationDirectionLeft = 0,
	FGSlideNavigationDirectionRight
} FGSlideNavigationDirection;

//----------------------------------------------//

@interface FGSlideNavigation : UIViewController

@property(nonatomic, assign) FGSlideNavigationDirection direction;
@property(nonatomic, strong, readonly) UIViewController* menuViewController;
@property(nonatomic, strong, readonly) UIViewController* contentViewController;
@property(nonatomic, assign) CGFloat menuViewWidth;

+ (id)slideNafigationWithMenuViewController:(UIViewController*)menuViewController contentViewController:(UIViewController*)contentViewController;
- (id)initWithMenuViewController:(UIViewController*)menuViewController contentViewController:(UIViewController*)contentViewController;

- (void)changeContentViewController:(UIViewController*)contentViewController closeMenu:(BOOL)closeMenu;
- (void)changeMenuViewController:(UIViewController*)menuViewController closeMenu:(BOOL)closeMenu;

- (void)toggleMenu;
- (void)openMenu;
- (void)closeMenu;

@end

//----------------------------------------------//
