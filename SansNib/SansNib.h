
#import <Cocoa/Cocoa.h>

typedef void(^vBlock)(void);

@interface 	 SansNib : NSApplication
@property		NSWindow * window;
@property			NSView * view;
@property			NSMenu * aboutMenu,						* fileMenu,				* editMenu,  			* helpMenu,
										 * servicesMenu;
@property	NSMenuItem * aboutMenuItem,				* fileMenuItem,		* editMenuItem,		* helpMenuItem,
										 * aboutAppMenuItem,		* openMenuItem,											* helpMenuItemOne,
										 * preferencesMenuItem,	* saveMenuItem,
										 * servicesMenuItem,
										 * hideMenuitem,
										 * hideOthersMenuItem,
										 * showAllMenuItem,
										 * quitMenuItem;

+		      (void) run;
+     (SansNib*) sansNib;
+    (NSWindow*) window;
+      (NSView*) view;
+ (NSSplitView*) split;

+ (NSTableView*) tableForArray:(NSArray*)array;
+         (void) titleBarButton:(id)i action:(vBlock)b;

@end


CALayer     * AddLayer (NSView*);
NSSplitView * SplitView(NSView*);

@interface InjectionExtras : NSObject

@property  NSInteger   dynNum1,   dynNum2,   dynNum3,   dynNum4,   dynNum5;
@property    NSColor * dynCol1, * dynCol2, * dynCol3, * dynCol4, * dynCol5;


@property (readonly) NSAppleScript *openTunables;
@property (copy)		 NSString *project;

+ (instancetype) injectorForProject:(NSString*)proj inWindow:(NSWindow*)w;
- (void) activatePanel:(id)x;
@end


//#define OBSERVE(X,Y)										[NSNotificationCenter.defaultCenter addObserverForName:X object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) { Y }]
//#define SYN_(x)													@synthesize x = _##x

//+ (instancetype) sansNib;
//@property (readonly)      NSString * inString;
//@property	(readonly)  NSScrollView * scrlView;		//+ (NSMenu*) mainMenu;
//@property							 CATextLayer * textLayer;
//@property	(readonly)       CALayer * layer;
