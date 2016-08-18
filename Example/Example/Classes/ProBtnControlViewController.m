//----------------------------------------------//

#import "ProBtnControlViewController.h"
#import "ProBtn.h"

//----------------------------------------------//

@interface ProBtnControlViewController ()

@property(nonatomic, readwrite) BOOL isFullscreen;

@end

//----------------------------------------------//

@implementation ProBtnControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskAllButUpsideDown];
    } else {
        [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskAll];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return [self isFullscreen];
}

- (void)setIsFullscreen:(BOOL)isFullscreen {
    if(_isFullscreen != isFullscreen) {
        _isFullscreen = isFullscreen;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        }
        [[UIApplication sharedApplication] setStatusBarHidden:isFullscreen];
        [ProBtn setButtonWindowFullscreen:isFullscreen];
    }
}

#pragma mark - Outlets selectors

- (IBAction)openPressed:(id)sender {
    [ProBtn open];
}

- (IBAction)closePressed:(id)sender {
    [ProBtn close];
}

- (IBAction)showPressed:(id)sender {
    [ProBtn show];
}

- (IBAction)hidePressed:(id)sender {
    [ProBtn hide];
}

- (IBAction)showHintPressed:(id)sender {
    [ProBtn showHint];
}

- (IBAction)hideHintPressed:(id)sender {
    [ProBtn hideHint];
}

- (IBAction)showContentPressed:(id)sender {
    [ProBtn showContent];
}

- (IBAction)hideContentPressed:(id)sender {
    [ProBtn hideContent];
}

- (IBAction)toogleFullscreenPressed:(id)sender {
    if([self isFullscreen] == NO) {
        [[self fullscreenButton] setTitle:@"Turn fullscreen off" forState:UIControlStateNormal];
        [self setIsFullscreen:YES];
    } else {
        [[self fullscreenButton] setTitle:@"Turn fullscreen on" forState:UIControlStateNormal];
        [self setIsFullscreen:NO];
    }
}

- (IBAction)applyUserSettings1Pressed:(id)sender {
    id< ProBtnSettings > settings = [ProBtn userSettings];
    [settings setButtonSize:CGSizeMake(100.0f, 100.0f)];
    [settings setContentURL:[NSURL URLWithString:@"https://survey.probtn.com/5232e2caadae230200000001"]];
    [settings setButtonContentType: @"iframe"];
    [ProBtn setUserSettings:settings];
}

- (IBAction)applyUserSettings2Pressed:(id)sender {
    id< ProBtnSettings > settings = [ProBtn userSettings];
    [settings setButtonSize:CGSizeMake(180.0f, 180.0f)];
    [settings setContentURL:[NSURL URLWithString:@"https://probtn.com/"]];
    [settings setButtonContentType: @"iframe"];
    [ProBtn setUserSettings:settings];
}

- (IBAction)applyUserSettings3Pressed:(id)sender {
    id< ProBtnSettings > settings = [ProBtn userSettings];
    [settings setButtonSize:CGSizeMake(120.0f, 120.0f)];
    [settings setContentURL:[NSURL URLWithString:@"https://demo.probtn.com/video/1-simple_x264_001.mp4"]];
    [settings setButtonContentType: @"video"];
    [ProBtn setUserSettings:settings];
}

- (IBAction)resetUserSettingsPressed:(id)sender {
    [ProBtn setUserSettings:nil];
}

@end

//----------------------------------------------//
