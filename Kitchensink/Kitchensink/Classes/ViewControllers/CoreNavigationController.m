//----------------------------------------------//

#import "CoreNavigationController.h"
#import "NavigationBar.h"

//----------------------------------------------//

@interface CoreNavigationController () {
}

@end

//----------------------------------------------//

@implementation CoreNavigationController

+ (id)controllerWithRootController:(CoreViewController*)controller {
    return [[self alloc] initWithRootController:controller];
}

- (id)initWithRootController:(CoreViewController*)controller {
    self = [super initWithNavigationBarClass:[NavigationBar class] toolbarClass:nil];
    if(self != nil) {
        [self setViewControllers:@[controller]];
    }
    return self;
}

- (void)dealloc {
    FG_SAFE_DEALLOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(FG_IOS_VERSION >= 7.0) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[self view] setNeedsLayout];
}

@end

//----------------------------------------------//
