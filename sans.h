//#define ALIAS_CLASS_POINTER_WITH(X,Y)ALIAS_CLASS_POINTER_WITH(X,Y);

@import ObjectiveC; @import QuartzCore; @import WebKit;


#define _alias(X,Y) typedef X Y;

_alias( Class,     _Meta )
_alias( void,      _Void )
_alias( id,        _ObjC )

_alias( NSString*, _Text ) _alias( WebView*, _WebV ) _alias( NSArrayController*, _List )
_alias( NSWindow*, _Main ) _alias( CALayer*, _Lens ) _alias( NSTableView*,       _TblV )
_alias( NSImage*,  _Pict ) _alias( NSView*,  _View ) _alias( NSSplitView*,       _Splt )
_alias( NSMenu*,   _Menu )
_alias( NSMenuItem*,   _SubM )

_alias( NSArray*,  Array )
_alias( NSEvent*,  Event )


#define implemented optional
#define _PERKS(X,...) @protocol X __VA_ARGS__
#define returns_the NULL
#define _Sans(name,X,ret) + (ret) name; // usage CLASSMETHOD_RETURNS(window, _Main)


_PERKS( Sans, @implemented)

//_Sans( window, returns_the, _Main )  /*! Look boss, ze window! */
//_Sans(   View, returns_the, _View )  /*! So perfect and young. */
//_Sans(  layer, returns_the, _Lens )  /*! Peel it back, slowly. */

+ (_Main)   window;  /*! Look boss, ze window! */
+ (_View)     view;  /*! So perfect and young. */
+ (_Lens)    layer;  /*! Peel it back, slowly. */


+ (_Lens) hitLayer;  /*! No always means no... */
+ (_Splt)    split;  /*! Gotta Keepm separated */

+ (_List) handlers;  /*! who/when + where/what */
+ (_List)  buttons;  /*! little bunndles o'fun */

+ (_TblV)      addTableWith:(_ObjC)stuff;
+ (_WebV)    addWebviewWith:(_Text)addrs;
+ (_Void)         addButton:(_ObjC)thing
                      block:(_Void(^)())b;

+ (_Void)       setDockIcon:(_Pict)i;
+          addViewWithClass:(_Meta)k;
+ (_Void)  addViewWithSplit:(_View)v;
@end

@interface Sans : NSObject <Sans> + sans; + (_Void) run; @end  _alias(Sans,_)

#define CATEGORY(K,...) @interface K (Sans) __VA_ARGS__; @end

CATEGORY( NSView,     - (_View) bisect:(_ObjC)with; -(_Splt)split)

CATEGORY( NSMenuItem, + (_ObjC) title:(_Text)t key:(_Text)k action:(_ObjC)blk)

CATEGORY( NSMenu,     - (_Void) setItemArray:(Array)x)


@interface            SansList : NSView
@property                 BOOL   onlyOneExpandedItem;
@property (nonatomic)  CGFloat   scrollOffset;//, drawOffset;
@property     CATransformLayer * list;
@property                _Lens   info;
@end

typedef void(^EventBlock)(Event e);

void AvailableIcons(void);
void    setCuteIcon(void);

#ifndef ATOZ
#define NSLog(fmt...) ((void)printf("%s %s\n",__PRETTY_FUNCTION__,[[NSString.alloc initWithFormat:fmt]UTF8String]))
#endif

#define sans_RANDOMCOLOR [NSColor colorWithCalibratedRed:arc4random()%100/100. green:arc4random()%100/100. blue:arc4random()%100/100. alpha:1]

#define sans_DOCK_TILE  ((NSDockTile*)NSApplication.sharedApplication.dockTile)

#define  SETWITHSUPER(...) [[super kPfVAVfK:k] setByAddingObjectsFromArray:[NSA arrayWithObjects:__VA_ARGS__,nil]]
#define  SUPERSET [super kPfVAVfK:k]

#define sans_PREFS                   [NSUserDefaults standardUserDefaults]
#define sans_NCENTER                   [NSNotificationCenter defaultCenter]
#define sans_APP                     [NSApplication      sharedApplication]
#define RESIZEABLE                    NSViewWidthSizable|NSViewHeightSizable
#define MENUALLOC										  [NSMenu						 		  ALLOCMENUZONE]
#define MENU_SEPERATOR								  [NSMenuItem             separatorItem]
#define ALLOCMENUZONE									allocWithZone:       [NSMenu menuZone]

#define _NSSTRINGIFY_INNER(x)                              @#x
#define       _NSSTRINGIFY(x)             _NSSTRINGIFY_INNER(x)
//#define           TOSTRING(X) [NSString stringWithUTF8String:X]  //   (NSString*)(X == NULL ? @"" : [NSString stringWithUTF8String:#X])

#define     MENUTITLED(x)               [[NSMenu ALLOCMENUZONE] initWithTitle:@#x]
#define MENUITEMACTION(name,k,...)      [NSMenuItem title:@#name key:k ?: @"" action:__VA_ARGS__]
#define MENUITEM_NAMED(x,y,z,SUBMENU)   ({ id newMenu = [[NSMenuItem ALLOCMENUZONE] initWithTitle:@#x action:({\
\
  id _ = @#y; [_ length] && ![_ isEqualToString:@"placeholder"] ? NSSelectorFromString(_) : NULL; \
}) keyEquivalent:(z ?: @"")]; if((SUBMENU)) [newMenu setSubmenu:SUBMENU]; newMenu; \
})
#define DISPATCHONCE(x)								({ static dispatch_once_t uno;	dispatch_once(&uno,^{ x; }); })
#define SETPOLICY                     [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular]

#define ABOUTRPROCESS                 ([[NSString stringWithFormat:@"About %@", NSProcessInfo.processInfo.processName] UTF8String])
#define SENDEVENT                     @selector(sendEvent:)
#define SANS ((Sans*)[[self class] sans]) /* ONLY CALL FROM subclassed SansNibs' */


/*
@interface       SansList : NSView <ArrayLike>
@property (NATOM)     CGF   rowHeight;
@property (NATOM,CP) NSString*(^rowTitleForObject)      (id object);


@property (RONLY) CGR  viewableRect;
@property (NATOM) CGF  scrollOffset;
       void     AvailableIcons();
    CALayer *   AddLayer(NSView*);
NSSplitView *  SplitView(NSView*);

@interface InjectionExtras : NSObject

@property  NSInteger   dynNum1,   dynNum2,   dynNum3,   dynNum4,   dynNum5;
@property    NSColor * dynCol1, * dynCol2, * dynCol3, * dynCol4, * dynCol5;


@property (readonly) NSAppleScript *openTunables;
@property (copy)		 NSString *project;

+ (instancetype) injectorForProject:(NSString*)proj inWindow:(NSWindow*)w;
- (void) activatePanel:(id)x;
@end
/! // (_Splt) split; addTableWith... if array or array controller, table - (_WebV) addWebviewWith:(_Text)url;                           )* /

#define OBSERVE(X,Y)										[NSNotificationCenter.defaultCenter addObserverForName:X object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) { Y }]
#define SYN_(x)													@synthesize x = _##x

+ (instancetype) sansNib;
@property (readonly)      NSString * inString;
@property	(readonly)  NSScrollView * scrlView;		//+ (NSMenu*) mainMenu;
@property							 CATextLayer * textLayer;
@property	(readonly)       CALayer * layer;
@property (CP)  CGF(^span)   (id obj);
@property (CP) void(^objectDrawBlock)(id obj, NSR r);
#import <AtoZ/AtoZ.h>

*/
