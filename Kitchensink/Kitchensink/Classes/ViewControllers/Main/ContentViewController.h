//----------------------------------------------//

#import "CoreViewController.h"

//----------------------------------------------//

typedef NS_ENUM(NSInteger, ContentPreferenceType) {
    ContentPreferenceTypeSurvey,
    ContentPreferenceTypeShop,
    ContentPreferenceTypeAdvertising,
    ContentPreferenceTypeChicagoBulls1,
    ContentPreferenceTypeChicagoBulls2,
};

//----------------------------------------------//

@class ContentViewController;

//----------------------------------------------//

#define CONTENT_PREFERENCE_SENSITIVITY          20

//----------------------------------------------//

@interface ContentPreference : NSObject

@property(nonatomic, assign) ContentViewController* contentViewController;

@property(nonatomic, assign) ContentPreferenceType type;
@property(nonatomic, strong) NSString* backgroundUrl;

@property(nonatomic, readonly) UIImage* defaultButtonImage;
@property(nonatomic, strong) UIImage* buttonImage;
@property(nonatomic, strong) NSString* buttonImageUrl;
@property(nonatomic, strong) UIImage* buttonOpenImage;
@property(nonatomic, strong) NSString* buttonOpenImageUrl;
@property(nonatomic, assign) CGSize buttonSize;

@property(nonatomic, strong) NSString* contentUrl;
@property(nonatomic, assign) CGSize contentSize;

@property(nonatomic, strong) NSString* hintText;

+ (id)contentPreferenceWithType:(ContentPreferenceType)type;
- (id)initWithContentPreferenceType:(ContentPreferenceType)type;

- (void)applyPreference;

- (void)loadFromSetting;
- (void)saveToSetting;

@end

//----------------------------------------------//

@interface ContentViewController : CoreViewController

@property(nonatomic, strong) ContentPreference* contentPreference;

- (void)applyContentPreference;

- (void)showMainMenu;
- (void)showPreference;

@end

//----------------------------------------------//
