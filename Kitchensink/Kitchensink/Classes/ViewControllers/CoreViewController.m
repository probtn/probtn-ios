//----------------------------------------------//

#import "CoreViewController.h"

//----------------------------------------------//

@interface CoreViewController () {
    FG_SAFE_UNRETAINED(Window*) mWindow;
}

@end

//----------------------------------------------//

@implementation CoreViewController

@synthesize window = mWindow;

+ (id)controllerWithWindow:(Window*)window {
    return [[self alloc] initWithWindow:window];
}

- (id)initWithWindow:(Window*)window {
    self = [super initWithNibName:[UINib nibNameByClass:[self class]] bundle:nil];
    if(self != nil) {
        mWindow = window;
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

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    switch(UI_USER_INTERFACE_IDIOM()) {
        case UIUserInterfaceIdiomPhone:
            return UIInterfaceOrientationMaskPortrait;
        case UIUserInterfaceIdiomPad:
            return UIInterfaceOrientationMaskAll;
    }
    return 0;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    switch(UI_USER_INTERFACE_IDIOM()) {
        case UIUserInterfaceIdiomPhone:
            if(toInterfaceOrientation == UIInterfaceOrientationPortrait) {
                return YES;
            }
            break;
        case UIUserInterfaceIdiomPad:
            return YES;
    }
    return NO;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[self view] setNeedsLayout];
}

@end

//----------------------------------------------//
