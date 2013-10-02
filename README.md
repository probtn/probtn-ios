Profit Button - floating buttons lib
============

What the Profit Button is?
---------------------------

Profit Button is a floating interactive element that is used to show custom content inside your application. If the button is tapped then the window with WebView would open. The url in the WebView is set thorought settings on ProBtn server.

Real example:
-----
![ScreenShot](http://www.probtn.com/wp-content/uploads/2013/09/pizzagif2.gif)

How to use ProBtn SDK
-----

1. First you have to register on [http://admin.probtn.com](http://admin.probtn.com)
2. Register your app: create new application, select it's platform (iOs) and fill in your app's BundleId;
3. Choose the site to promote in your application.
4. Finally you have to embed ProBtn into your app.

Integrating ProBtn SDK into your ObjC iOs App
-----

1. First you are to clone repository or just download the archive to you computer.
2. Add file libProBtn-1.x.a to your project (Target -> Build Phases -> Link Binary With Libraries).
3. Add header files ProBtn.h and ProBtnVersion.h to you project.
4. Add  QuartzCore.framework, UIKit.framework, CoreGraphics.framework, CoreLocation.framework to your project Build Phases -> Link Binary With Libraries
5. Import the file ProBtn.h with the derictive #import "ProBtn.h"
6. After your app was initialised you have to call method [ProBtn open] 
7. By default all the screen orientations are supported. You can restrict anyone of them in any time by calling method  [ProBtn setAvailableOrientations:]
8. Feel free to control the button at any time by calling methods:  [ProBtn close], [ProBtn show], [ProBtn hide], [ProBtn setButtonWindowLevel:]

Example:

	@implementation AppDelegate
	
	// Code
	
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	    // Code
		
	    // Show button
	    [ProBtn open];

	    // Set supported orientations (by default - all orientations)
	    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
	        [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskkAllButUpsideDown];
	    } else {
	        [ProBtn setAvailableOrientations:ProBtnInterfaceOrientationMaskAll];
	    }
	    return YES;
	}
	
	// Code
	
Server side
---------------

All the settings are taken from the server so you can customize the appiarence of the button by simply changing the on the serverside. 
The server adress is [admin.probtn.com](http://admin.probtn.com). After all the data loaded from the server the button would appear automatically.


Parameters description for ProBtn
-------------------------------
	BundleID = BundleId of your application
	Settings = {
		BaseInsets = { // Distance from the edges of the screen including status bar
			T = 4.0
			B = 4.0
			L = 4.0
			R = 4.0
		}
	
		ButtonEnabled = true // Is active or not. It means could you move it or not
		ButtonVisible = true // Is visible or not
	
		// Visual settings of the button
	
		ButtonOpenInsets = { // Distance from the edges of the screen when WevbView is opened
			T = 32.0
			B = 32.0
			L = 32.0
			R = 32.0
		}
		ButtonPosition = { // Start position
			X = // By default it centers on the screen
			Y = // By default it centers on the screen
		}
		ButtonSize = { // Size
			W = 64.0
			H = 64.0
		}
		ButtonDragSize = { // Size of the button when its dragged
			W = 68.0
			H = 68.0
		}
		ButtonOpenSize = { // Button size when the WebView is opened
			W = 64.0
			H = 64.0
		}
		ButtonInactiveSize = { // Button size when its inactive
			W = 64.0
			H = 64.0
		}
		ButtonOpacity = 0.8 // Opacity
		ButtonDragOpacity = 1.0 // Opacity during movement
		ButtonOpenOpacity = 1.0 // Opacity of the button when WebView is opened
		ButtonInactiveOpacity = 0.5 // Opacity when button is inactive
		ButtonImage = // Link to image when the button is in normal state
		ButtonDragImage = // Link to image shown during movements
		ButtonOpenImage = // Link to image when the WebView is shown
		ButtonInactiveImage = // Link to image when it is in inactive state
	
		// Visial settings of the closing region
		
		ClosePosition = { // Position
			X = // By default it centers on the screen
			Y = // By default it centers on the screen
		}
		CloseSize = { // Size
			W = 64.0
			H = 64.0
		}
		CloseActiveSize = { // Size of the closing region in active state
			W = 72.0
			H = 72.0
		}
		CloseOpacity = 0.6 // Opacity
		CloseActiveOpacity = 1.0 // Opacity in active state
		CloseImage = // Link to image
		CloseActiveImage = // Link to image in active state
	
		// Hint visual settings
	
		HintInsets = { // Distance from the screen edges
			T = 4.0
			B = 4.0
			L = 4.0
			R = 4.0
		}
		HintLabelInsets = { // Offcets for text
			T = 4.0
			B = 4.0
			L = 4.0
			R = 4.0
		}
		HintImageInsets = { // Borders for backgroud image
			T = 8.0
			B = 8.0
			L = 8.0
			R = 8.0
		}
		HintText = This is HintButton // Text
		HintFont = { // Font parameters
			Family = Arial
			Size = 18
		}
		HintFontColor = { // Font color
			R = 1.0
			G = 1.0
			B = 1.0
			A = 1.0
		}
		HintOpacity = 0.8 // Opacity
		HintImage = // Link to image
	
		HintArrowSize = { // Arrow size
			W = 8.0
			H = 8.0
		}
		HintArrowOffset = { // Overlap of the arrow and button
			T = 0.0
			B = 0.0
			L = 0.0
			R = 0.0
		}
		HintArrowImageT = // Link to image
		HintArrowImageB = // Link to image
		HintArrowImageL = // Link to image
		HintArrowImageR = // Link to image
	
		// Content visual settings
	
		ContentInsets = { // Distance from the screen edges
			T = -2.0
			B = -2.0
			L = -2.0
			R = -2.0
		}
		ContentWebViewInsets = { // Offset for WebView
			T = 12.0
			B = 12.0
			L = 12.0
			R = 12.0
		}
		ContentImageInsets = { // Borders for image
			T = 32.0
			B = 32.0
			L = 32.0
			R = 32.0
		}
		ContentURL = http://probtn.com // Link to site to promote
		ContentOpacity = 1.0 // Content opacity
		ContentActivityColor = { // Loading indicator color
			R = 0.0
			G = 0.0
			B = 0.0
			A = 1.0
		}
		ContentImage = // Link to image
	
		ContentArrowSize = { // Content arrow size
			W = 14.0
			H = 14.0
		}
		ContentArrowOffset = { // // Overlap of the arrow and content
			T = 8.0
			B = 8.0
			L = 9.0
			R = 9.0
		}
		ContentArrowImageT = // Link to image with arrow for content
		ContentArrowImageB = // Link to image with arrow for content
		ContentArrowImageL = // Link to image with arrow for content
		ContentArrowImageR = // Link to image with arrow for content
	
		// Animation settings
	
		DefaultDuration = 0.1 // Defaul duration of the animation
		DefaultDelay = 0.0 // Defaul delay of the animation
	
		OpenDuration = 0.2 // Duration for the "Open" animation
		OpenDelay = 0.5 // Delay for the "Open" animation
		CloseDuration = 0.2 // Duration for the "Close" animation
		CloseDelay = 0.5 // Delay for the "CLose" animation
	
		ButtonShowDuration = 0.2 // Duration for the "Show" animation
		ButtonShowDelay = 0.0 // Delay for the  "Show" animation
		ButtonHideDuration = 0.2 // Duration for the "Hide" animation
		ButtonHideDelay = 0.0 // Delay for the "Hide" animation
		ButtonDragDuration = 0.1 // Duration for the "Start moving" animation
		ButtonDragDelay = 0.0 // Delay for the "Start moving" animation
		ButtonUndragDuration = 0.2 //Duration for the "Stop moving" animation
		ButtonUndragDelay = 0.0 // Delay for the "Stop moving" animation
		ButtonInactiveDuration = 0.1 //Duration for the "Inactive" animation 
		ButtonInactiveDelay = 5.0 // The time before the button would switch to "Inactive"
		ButtonInertiaSpeed = 512.0 // The speed of the "Inertion" animation
		ButtonInertiaSpeedMin = 32.0 // The maximum speed of "Inertion" animation
		ButtonInertiaSpeedMax = 1024.0 // The minimum speed of the "Inertion" animation
		ButtonInertiaFactor = 6.0 // Factor for the "Inertion" animation
	
		CloseShowDuration = 0.1 // Duration for the "Show closing area" animation
		CloseShowDelay = 0.0 // Delay for the "Show closing area" animation
		CloseHideDuration = 0.2 // Duration for the "Open closing area" animation
		CloseHideDelay = 0.0 // Delay for the "Open closing area" animation
		CloseActiveDuration = 0.1 // Duration for the "Activate closing area" animation
		CloseActiveDelay = 0.0 // Delay for the "Activate closing area" animation
		CloseUnactiveDuration = 0.1 //Duration for the "Deactivate closing area" animation
		CloseUnactiveDelay = 0.0 // Delay for the "Deactivate closing area" animation
	
		HintLaunchDuration = 3.0 // Duration for the "Show hint at start" animation
		HintLaunchDelay = 0.0 // Delay for the  "Show hint at start" animation
		HintShowDuration = 0.1 // Duration for the "Show hint" animation
		HintShowDelay = 0.0 // Delay for the "Show hint" animation
		HintHideDuration = 0.2 // Duration for the "Hide hint" animation
		HintHideDelay = 0.0 // Delay for the "Hide hint" animation
	
		ContentShowDuration = 0.1 // Duration for the "Show content" animation
		ContentShowDelay = 0.0 // Delay for the "Show content" animation
		ContentHideDuration = 0.2 // Duration for the "Hide content" animation
		ContentHideDelay = 0.0 // Delay for the "Hide content" animation
	}

Screenshots
---------------
![ScreenShot](http://www.probtn.com/wp-content/uploads/2013/09/button1.png)
![ScreenShot](http://www.probtn.com/wp-content/uploads/2013/09/button2.png)

License
---------------
Licenced under [LGPL](http://opensource.org/licenses/LGPL-3.0)