//----------------------------------------------//

#import "CoreViewController.h"

//----------------------------------------------//

@interface CoreNavigationController : UINavigationController

+ (id)controllerWithRootController:(CoreViewController*)controller;

- (id)initWithRootController:(CoreViewController*)controller;

@end

//----------------------------------------------//
