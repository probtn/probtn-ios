//----------------------------------------------//

#import "PreferenceViewController.h"
#import "ContentViewController.h"
#import "Buttons.h"

//----------------------------------------------//

#import "ProBtn.h"

//----------------------------------------------//

@interface PreferenceViewController () < UITextFieldDelegate, ProBtnDelegate > {
    dispatch_queue_t mQueue;
    ContentPreference* mContentPreference;
    FG_SAFE_UNRETAINED(UITextField*) mCurrentField;
}

@property(nonatomic, weak) IBOutlet UINavigationItem* customNavigationItem;

@property(nonatomic, weak) IBOutlet UIScrollView* scrollView;
@property(nonatomic, weak) IBOutlet UIView* rootView;
@property(nonatomic, weak) IBOutlet UIView* emptyView;

@property(nonatomic, weak) IBOutlet UITextField* backgroundUrl;

@property(nonatomic, weak) IBOutlet UISegmentedControl* buttonImageType;
@property(nonatomic, weak) IBOutlet UITextField* buttonImageUrl;
@property(nonatomic, weak) IBOutlet UITextField* buttonSizeW;
@property(nonatomic, weak) IBOutlet UITextField* buttonSizeH;
@property(nonatomic, weak) IBOutlet UIButton* buttonOpen;

@property(nonatomic, weak) IBOutlet UITextField* contentUrl;
@property(nonatomic, weak) IBOutlet UITextField* contentSizeW;
@property(nonatomic, weak) IBOutlet UITextField* contentSizeH;

@property(nonatomic, weak) IBOutlet UITextField* hintText;
@property(nonatomic, weak) IBOutlet UISwitch* hintState;

@end

//----------------------------------------------//

@implementation PreferenceViewController

@synthesize contentPreference = mContentPreference;

#pragma mark - Default

- (id)initWithWindow:(Window*)window {
    self = [super initWithWindow:window];
    if(self != nil) {
        mQueue = dispatch_queue_create(nil, nil);
    }
    return self;
}

- (void)dealloc {
    FG_SAFE_DISPATCH_RELEASE(mQueue);
    FG_SAFE_RELEASE(mContentPreference);
    FG_SAFE_DEALLOC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self customNavigationItem] setTitle:NSLocalizedString(@"Preference", nil)];
    
    if(FG_IPHONE) {
        [[self customNavigationItem] setRightBarView:[ButtonNavigationDone buttonWithTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside]];
    }

    CGRect rootRect = [[self rootView] frame];
    [[self scrollView] setContentSize:CGSizeMake(rootRect.origin.x + rootRect.size.width + rootRect.origin.x, rootRect.origin.y + rootRect.size.height + rootRect.origin.y)];
    
    [[self emptyView] setUserInteractionEnabled:NO];
}

- (void)viewDidUnload {
    [self setCustomNavigationItem:nil];
    [self setScrollView:nil];
    [self setRootView:nil];
    [self setEmptyView:nil];
    [self setBackgroundUrl:nil];
    [self setButtonImageType:nil];
    [self setButtonImageUrl:nil];
    [self setButtonSizeW:nil];
    [self setButtonSizeH:nil];
    [self setButtonOpen:nil];
    [self setContentUrl:nil];
    [self setContentSizeW:nil];
    [self setContentSizeH:nil];
    [self setHintText:nil];
    [self setHintState:nil];
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString* backgroundUrl = [mContentPreference backgroundUrl];
    UIImage* defaultButtonImage = [mContentPreference defaultButtonImage];
    UIImage* buttonImage = [mContentPreference buttonImage];
    NSString* buttonImageUrl = [mContentPreference buttonImageUrl];
    CGSize buttonSize = [mContentPreference buttonSize];
    NSString* contentUrl = [mContentPreference contentUrl];
    CGSize contentSize = [mContentPreference contentSize];
    NSString* hintText = [mContentPreference hintText];
    
    [[self backgroundUrl] setText:backgroundUrl];
    if(([buttonImageUrl length] > 0) && (buttonImage != defaultButtonImage)) {
        [[self buttonImageType] setSelectedSegmentIndex:1];
        [[self buttonImageUrl] setEnabled:YES];
    } else {
        [[self buttonImageType] setSelectedSegmentIndex:0];
        [[self buttonImageUrl] setEnabled:NO];
    }
    [[self buttonImageUrl] setText:buttonImageUrl];
    [[self buttonSizeW] setText:[NSString stringWithFormat:@"%0.1f", buttonSize.width]];
    [[self buttonSizeH] setText:[NSString stringWithFormat:@"%0.1f", buttonSize.height]];
    [[self buttonOpen] setEnabled:([ProBtn isOpened] == NO)];
    [[self contentUrl] setText:contentUrl];
    [[self contentSizeW] setText:[NSString stringWithFormat:@"%0.1f", contentSize.width]];
    [[self contentSizeH] setText:[NSString stringWithFormat:@"%0.1f", contentSize.height]];
    [[self hintText] setText:hintText];
    [[self hintState] setOn:[ProBtn isHintShowed] animated:NO];
    
    if(FG_IPHONE) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    }

    [ProBtn setDelegate:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [ProBtn setDelegate:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewDidDisappear:animated];
}

#pragma mark - Public

- (void)applyContentPreference {
    [mContentPreference applyPreference];
}

#pragma mark - NSNotification

- (void)keyboardShow:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    if(info != nil) {
        id keyboardKey = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        if(keyboardKey != nil) {
            CGRect keyboardRect = [keyboardKey CGRectValue];
            UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0f, 0.0f, keyboardRect.size.height, 0.0f);
            [[self scrollView] setScrollIndicatorInsets:contentInsets];
            [[self scrollView] setContentInset:contentInsets];
            
            if(mCurrentField != nil) {
                CGRect fieldRect = [mCurrentField convertRect:[mCurrentField bounds] toView:[self scrollView]];
                [[self scrollView] setContentOffset:CGPointMake(0.0f, fieldRect.origin.y - 20.f)
                                           animated:YES];
            }
        }
    }
}

- (void)keyboardHide:(NSNotification*)notification {
    [[self scrollView] setScrollIndicatorInsets:UIEdgeInsetsZero];
    [[self scrollView] setContentInset:UIEdgeInsetsZero];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField*)textField {
    [[self emptyView] setUserInteractionEnabled:YES];
    mCurrentField = textField;
}

- (void)textFieldDidEndEditing:(UITextField*)textField {
    [[self emptyView] setUserInteractionEnabled:NO];
    mCurrentField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    return [textField resignFirstResponder];
}

#pragma mark - ProBtnDelegate

- (void)proBtnDidOpen {
    [[self buttonOpen] setEnabled:NO];
}

- (void)proBtnDidClose {
    [[self buttonOpen] setEnabled:YES];
}

- (void)proBtnDidHintShow {
    [[self hintState] setOn:YES animated:YES];
}

- (void)proBtnDidHintHide {
    [[self hintState] setOn:NO animated:YES];
}

#pragma mark - IBAction

- (IBAction)donePressed:(id)sender {
    if(FG_IPHONE) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [mContentPreference saveToSetting];
    }
}

- (IBAction)onBackgroundUrl:(id)sender {
    [mContentPreference setBackgroundUrl:[[self backgroundUrl] text]];
    [mContentPreference applyPreference];
}

- (IBAction)onButtonImageType:(id)sender {
    switch([[self buttonImageType] selectedSegmentIndex]) {
        case 0: {
            UIImage* image = [mContentPreference defaultButtonImage];
            if(image != nil) {
                [mContentPreference setButtonImage:image];
                [mContentPreference applyPreference];
            }
            [[self buttonImageUrl] setEnabled:NO];
            break;
        }
        case 1: {
            [self onButtonImageUrl:sender];
            [[self buttonImageUrl] setEnabled:YES];
            break;
        }
    }
}

- (IBAction)onButtonImageUrl:(id)sender {
    NSString* buttonImageUrl = [[self buttonImageUrl] text];
    if([buttonImageUrl length] > 0) {
        NSURL* url = [NSURL URLWithString:buttonImageUrl];
        if(url != nil) {
            if([[self buttonImageUrl] leftView] == nil) {
                UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                if(activity != nil) {
                    [activity startAnimating];
                    [[self buttonImageUrl] setLeftViewMode:UITextFieldViewModeAlways];
                    [[self buttonImageUrl] setLeftView:activity];
                    
                    dispatch_async(mQueue, ^{
                        UIImage* image = nil;
                        NSData* imageData = [NSData dataWithContentsOfURL:url];
                        if(imageData != nil) {
                            image = [UIImage imageWithData:imageData scale:2.0f];
                        }
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            if(image != nil) {
                                [mContentPreference setButtonImageUrl:buttonImageUrl];
                                [mContentPreference setButtonImage:image];
                                [mContentPreference applyPreference];
                            } else {
                                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                message:NSLocalizedString(@"Error load image", nil)
                                                                               delegate:nil
                                                                      cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                                      otherButtonTitles:nil];
                                [alert show];
                            }
                            [activity stopAnimating];
                            [[self buttonImageUrl] setLeftView:nil];
                        });
                    });
                }
            }
        }
    }
}

- (IBAction)onButtonSize:(id)sender {
    NSString* buttonSizeW = [[self buttonSizeW] text];
    NSString* buttonSizeH = [[self buttonSizeH] text];
    if(([buttonSizeW length] > 0) && ([buttonSizeH length] > 0)) {
        CGFloat sizeW = [buttonSizeW floatValue];
        CGFloat sizeH = [buttonSizeH floatValue];
        if((sizeW > 0.0f) && (sizeH > 0.0f)) {
            [mContentPreference setButtonSize:CGSizeMake(sizeW, sizeH)];
            [mContentPreference applyPreference];
        }
    }
}

- (IBAction)onButtonOpen:(id)sender {
    [ProBtn open];
}

- (IBAction)onContentUrl:(id)sender {
    NSString* contentUrl = [[self contentUrl] text];
    [mContentPreference setContentUrl:contentUrl];
    [mContentPreference applyPreference];
}

- (IBAction)onContentSize:(id)sender {
    NSString* contentSizeW = [[self contentSizeW] text];
    NSString* contentSizeH = [[self contentSizeH] text];
    [mContentPreference setContentSize:CGSizeMake([contentSizeW floatValue], [contentSizeH floatValue])];
    [mContentPreference applyPreference];
}

- (IBAction)onHintText:(id)sender {
    [mContentPreference setHintText:[[self hintText] text]];
    [mContentPreference applyPreference];
}

- (IBAction)onHintState:(id)sender {
    if([[self hintState] isOn] == YES) {
        [ProBtn showHint];
    } else {
        [ProBtn hideHint];
    }
}

- (IBAction)onTapEmpty:(id)sender {
    if(mCurrentField != nil) {
        [mCurrentField resignFirstResponder];
    }
}

@end

//----------------------------------------------//
