//----------------------------------------------//

#import "NavigationBar.h"

//----------------------------------------------//

@interface NavigationBar () {
}

- (void)initializaze;

@end

//----------------------------------------------//

@implementation NavigationBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self initializaze];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self initializaze];
    }
    return self;
}

- (void)initializaze {
    if(FG_IOS_VERSION >= 7.0) {
        [self setBarStyle:UIBarStyleBlack];
        [self setBarTintColor:FG_COLOR_BYTE(120, 120, 120, 255)];
    } else if(FG_IOS_VERSION >= 5.0) {
        [self setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    }
    [self setTintColor:FG_COLOR_BYTE(120, 120, 120, 255)];
}

@end

//----------------------------------------------//
