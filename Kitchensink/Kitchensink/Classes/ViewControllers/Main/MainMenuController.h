//----------------------------------------------//

#import "CoreViewController.h"
#import "Buttons.h"

//----------------------------------------------//

#import "FGAccordionView.h"

//----------------------------------------------//

@class CoreNavigationController;

//----------------------------------------------//

@interface MainMenuController : CoreViewController

@property(nonatomic, readonly) CoreNavigationController* surveyViewController;
@property(nonatomic, readonly) CoreNavigationController* shopViewController;
@property(nonatomic, readonly) CoreNavigationController* advertisingViewController;

@property(nonatomic, readonly) CoreNavigationController* currentViewController;

- (void)openController:(UIViewController*)controller;

@end

//----------------------------------------------//
