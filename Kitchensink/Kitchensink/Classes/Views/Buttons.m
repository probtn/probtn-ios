//----------------------------------------------//

#import "Buttons.h"

//----------------------------------------------//

@interface Button () {
}

+ (CGRect)buttonDefaultRect;

+ (UIImage*)buttonBasicImage;

- (void)initializaze;

@end

//----------------------------------------------//

@implementation Button

+ (CGRect)buttonDefaultRect {
    return CGRectMake(0, 0, 24, 44);
}

+ (UIImage*)buttonBasicImage {
    return [[UIImage imageNamed:@"button_basic"] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
}

+ (id)buttonWithTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    return [self buttonWithFrame:[self buttonDefaultRect] target:target action:action forControlEvents:controlEvents];
}

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
    [self setTitleColor:FG_COLOR_BYTE(255, 255, 255, 200) forState:UIControlStateNormal];
    [self setTitleColor:FG_COLOR_BYTE(255, 255, 255, 255) forState:UIControlStateHighlighted];
    [self setTitleColor:FG_COLOR_BYTE(255, 255, 255, 255) forState:UIControlStateSelected];
    [self setTitleColor:FG_COLOR_BYTE(255, 255, 255, 127) forState:UIControlStateDisabled];
}

@end

//----------------------------------------------//

@implementation ButtonBasic

- (void)initializaze {
    [super initializaze];
    
    [self setBackgroundImage:[Button buttonBasicImage] forState:UIControlStateNormal];
}

@end

//----------------------------------------------//

@implementation ButtonMenu

- (void)initializaze {
    [super initializaze];
    
    [self setBackgroundImage:[UIImage imageNamed:@"button_menu_normal"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"button_menu_select"] forState:UIControlStateSelected];
}

@end

//----------------------------------------------//

@implementation ButtonNavigation

+ (CGRect)buttonDefaultRect {
    return CGRectMake(0, 0, 44, 44);
}

@end

//----------------------------------------------//

@implementation ButtonNavigationMenu

- (void)initializaze {
    [super initializaze];
    
    [self setImage:[UIImage imageNamed:@"navbar_menu"] forState:UIControlStateNormal];
}

@end

//----------------------------------------------//

@implementation ButtonNavigationPreference

- (void)initializaze {
    [super initializaze];
    
    [self setImage:[UIImage imageNamed:@"navbar_preference"] forState:UIControlStateNormal];
}

@end

//----------------------------------------------//

@implementation ButtonNavigationDone

+ (CGRect)buttonDefaultRect {
    return CGRectMake(0, 0, 62, 31);
}

- (void)initializaze {
    [super initializaze];
    
    [[self titleLabel] setFont:[UIFont boldSystemFontOfSize:14.0f]];
    
    [self setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [self setBackgroundImage:[Button buttonBasicImage] forState:UIControlStateNormal];
}

@end

//----------------------------------------------//
