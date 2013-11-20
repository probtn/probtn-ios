//----------------------------------------------//

#import "LaunchViewController.h"
#import "Buttons.h"

//----------------------------------------------//
#if (KITCHENSINK_DEMO_MODE == KITCHENSINK_DEMO_MODE_FULL)
//----------------------------------------------//

@interface LaunchViewController () {
}

@property(nonatomic, weak) IBOutlet UIButton* openDemo;
@property(nonatomic, weak) IBOutlet UIButton* openVendor;

@end

//----------------------------------------------//

@implementation LaunchViewController

#pragma mark - Default

- (id)initWithWindow:(Window*)window {
    self = [super initWithWindow:window];
    if(self != nil) {
    }
    return self;
}

- (void)dealloc {
    FG_SAFE_DEALLOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES];
}

- (void)viewDidUnload {
    [self setOpenDemo:nil];
    [self setOpenVendor:nil];
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [super viewDidDisappear:animated];
}

#pragma mark - Public

- (void)showMainNavigationController {
    [[self window] showMainNavigationController];
}

#pragma mark - IBAction

- (IBAction)openDemoPressed:(id)sender {
    [self showMainNavigationController];
}

- (IBAction)openVendorPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.probtn.com"]];
}

@end

//----------------------------------------------//
#endif
//----------------------------------------------//
