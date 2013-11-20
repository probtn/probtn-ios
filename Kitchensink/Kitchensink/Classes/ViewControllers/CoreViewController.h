//----------------------------------------------//

#import "Window.h"

//----------------------------------------------//

@interface CoreViewController : UIViewController

@property(nonatomic, readonly) Window* window;

+ (id)controllerWithWindow:(Window*)window;

- (id)initWithWindow:(Window*)window;

@end

//----------------------------------------------//
