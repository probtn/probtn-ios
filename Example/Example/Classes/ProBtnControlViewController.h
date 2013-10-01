//----------------------------------------------//

#import <UIKit/UIKit.h>

//----------------------------------------------//

@class ProBtnRootViewController;

//----------------------------------------------//

@interface ProBtnControlViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *fullscreenButton;

- (IBAction)openPressed:(id)sender;
- (IBAction)closePressed:(id)sender;
- (IBAction)showPressed:(id)sender;
- (IBAction)hidePressed:(id)sender;
- (IBAction)showHintPressed:(id)sender;
- (IBAction)hideHintPressed:(id)sender;
- (IBAction)showContentPressed:(id)sender;
- (IBAction)hideContentPressed:(id)sender;
- (IBAction)toogleFullscreenPressed:(id)sender;

@end

//----------------------------------------------//
