
#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import <AtoZ/AtoZ.h>

typedef void(^EventBlock)(NSEvent*e);

@interface SansNib : NSObject + (instancetype) sansNib; + (void) run; @end

@interface SansNib (Extras)

+       (NSWindow*) window;
+         (NSView*) view;
+        (CALayer*) layer;
+    (NSSplitView*) split;
+ (NSMutableArray*) eventBlocks;
+ (NSMutableArray*) buttons;
+    (NSTableView*) addTableForObjects:(NSArray*)arr;
+            (void) addButton:(id)i block:(VoidBlock)b;
+              (id) addViewWithClass:(Class)k;
+            (void) addViewWithSplit:(NSV*)v;
@end

@interface       SansList : NSView <ArrayLike>

@property BOOL onlyOneExpandedItem;
//@property (CP)  CGF(^span)   (id obj);
//@property (CP) void(^objectDrawBlock)(id obj, NSR r);

@end

@interface  DebugLayer : NSO
@property (NATOM)  NSC * color;
+ (INST)     addToLayer:(CAL*)l
                aligned:(AZPOS)a
                boundTo:(id)x
                    key:(NSS*)k;
@end

//@interface       SansList : NSView <ArrayLike>
//@property (NATOM)     CGF   rowHeight;
//@property (NATOM,CP) NSString*(^rowTitleForObject)      (id object);


//@property (RONLY) CGR  viewableRect;
//@property (NATOM) CGF  scrollOffset;
//       void     AvailableIcons();
//    CALayer *   AddLayer(NSView*);
//NSSplitView *  SplitView(NSView*);

#define  SETWITHSUPER(...) [[super kPfVAVfK:k] setByAddingObjectsFromArray:[NSA arrayWithObjects:__VA_ARGS__,nil]]
#define  SUPERSET [super kPfVAVfK:k]

#define SHAREDAPP                     [NSApplication      sharedApplication]
#define RESIZEABLE                    NSViewWidthSizable|NSViewHeightSizable
#define MENUALLOC										  [NSMenu						 		  ALLOCMENUZONE]
#define MENU_SEPERATOR								[NSMenuItem             separatorItem]
#define ALLOCMENUZONE									allocWithZone:       [NSMenu menuZone]

#define _NSSTRINGIFY_INNER(x) @#x
#define _NSSTRINGIFY(x) _NSSTRINGIFY_INNER(x)

#define TOSTRING(X)               [NSString stringWithUTF8String:X]  //   (NSString*)(X == NULL ? @"" : [NSString stringWithUTF8String:#X])

#define MENUTITLED(x)                 [[NSMenu ALLOCMENUZONE] initWithTitle:TOSTRING(#x)]
#define MENUITEMACTION(name,k,...)		[NSMenuItem menuWithTitle:[NSString stringWithUTF8String:#name] key:k ?: @"" action:(id)__VA_ARGS__]
#define MENUITEM_NAMED(x,y,z,SUBMENU)	 ({ id a = [[NSMenuItem ALLOCMENUZONE] initWithTitle:TOSTRING(#x) action:({ \
\
  id _ = _NSSTRINGIFY(y); XX($(@"^%@$",_)); ([_ length] && !SameString(_,@"placehoder")) ? @selector(y)  : NULL; \
}) keyEquivalent:(z ?: @"")]; if((SUBMENU)) [a setSubmenu:SUBMENU]; a; \
})
#define DISPATCHONCE(x)								({ static dispatch_once_t uno;	dispatch_once(&uno,^{ x; }); })
#define SETPOLICY                     [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular]
#define DISPATCHINIT                  DISPATCHONCE([NSApp setMainMenu:MENUTITLED(@"")];	nibless = [super alloc]; nibless = [nibless init];)
#define ABOUTRPROCESS                 ([[NSString stringWithFormat:@"About %@", NSProcessInfo.processInfo.processName] UTF8String])
#define SENDEVENT                     @selector(sendEvent:)
#define SANSNIB ((SansNib*)[[self class] sansNib]) /* ONLY CALL FROM subclassed SansNibs' */



/*
@interface InjectionExtras : NSObject

@property  NSInteger   dynNum1,   dynNum2,   dynNum3,   dynNum4,   dynNum5;
@property    NSColor * dynCol1, * dynCol2, * dynCol3, * dynCol4, * dynCol5;


@property (readonly) NSAppleScript *openTunables;
@property (copy)		 NSString *project;

+ (instancetype) injectorForProject:(NSString*)proj inWindow:(NSWindow*)w;
- (void) activatePanel:(id)x;
@end
*/

//#define OBSERVE(X,Y)										[NSNotificationCenter.defaultCenter addObserverForName:X object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) { Y }]
//#define SYN_(x)													@synthesize x = _##x

//+ (instancetype) sansNib;
//@property (readonly)      NSString * inString;
//@property	(readonly)  NSScrollView * scrlView;		//+ (NSMenu*) mainMenu;
//@property							 CATextLayer * textLayer;
//@property	(readonly)       CALayer * layer;
