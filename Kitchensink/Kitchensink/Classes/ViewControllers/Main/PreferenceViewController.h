//----------------------------------------------//

#import "CoreViewController.h"

//----------------------------------------------//

@class ContentPreference;

//----------------------------------------------//

@interface PreferenceViewController : CoreViewController

@property(nonatomic, strong) ContentPreference* contentPreference;

- (void)applyContentPreference;

@end

//----------------------------------------------//
