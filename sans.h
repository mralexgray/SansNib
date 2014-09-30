@import ObjectiveC; @import QuartzCore; @import WebKit; @import ExtObjC;

@import CloudKit;

    /*! Simplified blockpropertydeclaration, with proper auto completion.

    @param v            LOWERCASE of ONLY the FIRST character of the generated property's name
    @param V            UPPERCASE of ONLY the FIRST character of the generated property's name
    @param arname       the generated property's name WITHOUT the FIRST character
    @param TYPENAME     this name will define (typedef) a new block type
    @param RET_TYPE     this is the blocks return type
    @param PARAMETERS   a single, or variadic list of parameters which should be passed to the block

    USAGE: BlockPropTDef ( p,P,ropertyName, NewBlockType, void, id x, NSError* err); ->

      typedef void(^NewBlockType)(id x,NSError* err);
      @property (nonatomic,copy) NewBlockType propertyName;
      - (void) setPropertyName:(NewBlockType)_;

    */  #define BlockPropTDef(v,V,arname,TYPENAME,RET_TYPE,PARAMETERS...) typedef RET_TYPE(^TYPENAME)(PARAMETERS); @property (nonatomic,copy) TYPENAME v##arname; - (void)  set##V##arname:(TYPENAME)_

    /*! Use this for declarations/subsequent declarations where the correct block type already exists.
        USAGE: @code BlockPropType (p,P,ropertyName, PredefinedBlockType);

      @property (nonatomic,copy) PredefinedBlockType propertyName;
      - (void) setPropertyName:(PredefinedBlockType)_;

    */  #define BlockPropType(v,V,arname,TYPENAME) @property (nonatomic,copy) TYPENAME v##arname; - (void)  set##V##arname:(TYPENAME)_

    /*  Use this when you just want simple, untyped block property
      USAGE: @code BlockProp(u,U,ntyped,void,);

        @property (nonatomic,copy) void(^untyped)();
      - (void) setUntyped:(void(^)())_;

    */  #define BlockProp(v,V,arname,RET_TYPE,PARAMETERS) @property (nonatomic,copy) RET_TYPE(^v##arname)(PARAMETERS); - (void)  set##V##arname:(RET_TYPE(^)(PARAMETERS))_






/*! Sans is a dialect of Objective-C. It strives to be..
  
  Concise ... 

  All types/classes are prefixed with an \c _ and are/should be exactly 4 characters long

     id     in ObjC
     _ObjC  in Sans

  Method paramaters / return values can be used without parenthesis by adding an \c _

    - (Class) classOfObject:(id)object;        in ObjC
    - _Meta_  classOfObject: _ObjC_ object;    in Sans

  Common classes are typedefed to NOT require an explicit pointer.

  
*/

typedef                id   _ObjC;
#define             _ObjC_ (_ObjC)
typedef             Class   _Meta;
#define             _Meta_ (_Meta)

typedef              void   _Void;
#define             _Void_ (_Void)

typedef           CGFloat   _Flot;
#define             _Flot_ (_Flot)
typedef        NSUInteger   _UInt;
#define             _UInt_ (_UInt)
typedef         NSInteger   _SInt;
#define             _SInt_ (_SInt)
typedef              BOOL   _IsIt;
#define             _IsIt_ (_IsIt)

typedef           CALayer * _Layr;
#define             _Layr_ (_Layr)
typedef           NSArray * _List;
#define             _List_ (_List)
typedef          NSBundle * _Bndl;
#define             _Bndl_ (_Bndl)
typedef           NSColor * _Colr;
#define             _Colr_ (_Colr)
typedef           NSError * _Errr;
#define             _Errr_ (_Errr)
typedef           NSEvent * _Evnt;
#define             _Evnt_ (_Evnt)
typedef           NSImage * _Pict;
#define             _Pict_ (_Pict)
typedef            NSMenu * _Menu;
#define             _Menu_ (_Menu)
typedef        NSMenuItem * _SubM;
#define             _SubM_ (_SubM)
typedef     NSOutlineView * _OutV;
#define             _OutV_ (_OutV)
typedef       NSSplitView * _Splt;
#define             _Splt_ (_Splt)
typedef          NSString * _Text;
#define             _Text_ (_Text)
typedef     NSTableColumn * _TCol;
#define             _TCol_ (_TCol)
typedef       NSTableView * _TblV;
#define             _TblV_ (_TblV)
typedef            NSView * _View;
#define             _View_ (_View)
typedef          NSWindow * _Wind;
#define             _Wind_ (_Wind)
typedef           WebView * _WebV;
#define             _WebV_ (_WebV)

typedef NSArrayController * XList;
#define             XList_ (XList)


typedef          void(^_VBlk)();

//typedef          _Void(^)() _VBlk;
#define             _VBlk_ (_VBlk)


#define _Kind instancetype
#define _Ivar @property
#define _RONLY _Ivar (readonly)

@protocol SansPlugin + GO; @end
@protocol       Sans       @optional


// Sans protocol conveniences.  A multipurpose window, etc for testing and good fortunes

typedef id<Sans>  Sans_;
#define   _Sans_ (Sans_)

_Ivar     _Wind window;     /// Look boss, ze window!
_Ivar     _View view;       /// So perfect and young.
_Ivar     _Layr layer,      /// Peel it back, slowly.
                hitLayer;   /// No always means no...
_Ivar     _Splt split;      /// Gotta Keepm separated
_Ivar     XList handlers,   /// who/when + where/what
                buttons,
                plugins;    /// little bunndles o'fun

- _Void_               run;
- _TblV_      addTableWith: _ObjC_ stuff;
- _WebV_    addWebviewWith: _Text_ addrs;
- _Void_  addViewWithSplit: _Splt_ v;
- _Void_         addButton: _ObjC_ thing
                     block: _VBlk_ b;
- _Void_       setDockIcon: _Pict_ i;
-         addViewWithClass: _Meta_ k;
@end

extern id <Sans> Sans();

#define CATEGORY_IS(K,...) @interface K (Sans) __VA_ARGS__; @end

CATEGORY_IS (NSObject,   - (Sans_) sans)
CATEGORY_IS (NSView,     - (_View) bisect:(_ObjC)with;
                         - (_Splt) split)
CATEGORY_IS (NSMenuItem, + (_ObjC) title:(_Text)t key:(_Text)k action:(_ObjC)blk)
CATEGORY_IS (NSMenu,     - (_Void) setItemArray:(_List)x)


typedef union { struct { _Flot x, y; };
                struct { _Flot expanded, unexpanded; };
} _Dims;

typedef _Dims _ExSz;


@protocol SansItem <NSObject>
_RONLY       _IsIt exandable;
_RONLY       _ExSz expandedSizes;
@end
@interface            SansList : NSScrollView
//@property                _IsIt   onlyOneExpandedItem;
//@property (nonatomic)    _Flot   scrollOffset;//, drawOffset;
//@property     CATransformLayer * list;
//@property                _Layr   info;
@end

typedef void(^EventBlock)(_Evnt e);

_Void AvailableIcons(_Void);
_Void    setCuteIcon(_Void);

#ifndef ATOZ
#define NSLog(fmt...) ((void)printf("%s %s\n",__PRETTY_FUNCTION__,[[NSString.alloc initWithFormat:fmt]UTF8String]))
#endif

#define sans_RANDOMCOLOR [NSColor colorWithCalibratedRed:arc4random()%100/100. green:arc4random()%100/100. blue:arc4random()%100/100. alpha:1]

#define sans_DOCK_TILE  ((NSDockTile*)NSApplication.sharedApplication.dockTile)

#define  SETWITHSUPER(...) [[super kPfVAVfK:k] setByAddingObjectsFromArray:[NSA arrayWithObjects:__VA_ARGS__,nil]]
#define  SUPERSET [super kPfVAVfK:k]

#define     _UDEFS      [NSUserDefaults  standardUserDefaults]
#define     _FILEM      [NSFileManager         defaultManager]
#define     _NCNTR      [NSNotificationCenter   defaultCenter]
#define     _NSAPP      [NSApplication      sharedApplication]
#define     _FLEX       NSViewWidthSizable|NSViewHeightSizable
#define     _MENUALLOC	[NSMenu						 		  ALLOCMENUZONE]
#define     _MENU_DIV		[NSMenuItem             separatorItem]
#define _ALLOCMENUZONE	allocWithZone:       [NSMenu menuZone]


#define _NSSTRINGIFY_INNER(x)                              @#x
#define       _NSSTRINGIFY(x)             _NSSTRINGIFY_INNER(x)

#define     _MENU_NAMED(x)              ({ _Menu i = [[NSMenu _ALLOCMENUZONE] initWithTitle:@#x]; [i setAutoenablesItems:NO]; i; })
#define MENUITEMACTION(name,k,...)      [NSMenuItem title:@#name key:k ?: @"" action:__VA_ARGS__]
#define _SUBM_NAMED(x,y,z,SUBMENU)   ({ \
\
  id newMenu = [[NSMenuItem _ALLOCMENUZONE] initWithTitle:@#x action:({\
  \
    id _ = @#y; [_ length] && ![_ isEqualToString:@"placeholder"] ? NSSelectorFromString(_) : NULL; \
    \
  }) keyEquivalent:(z ?: @"")]; \
  \
  if((SUBMENU)) [newMenu setSubmenu:SUBMENU]; \
\
newMenu; })

#define DISPATCHONCE(x)								({ static dispatch_once_t uno;	dispatch_once(&uno,^{ x; }); })
#define SETPOLICY                     [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular]

#define ABOUT_                 ([[NSString stringWithFormat:@"About %@", NSProcessInfo.processInfo.processName] UTF8String])
#define SENDEVENT                     @selector(sendEvent:)
#define SANS ({ _ _S = [[self class] sans]; _S; }) /* ONLY CALL FROM subclassed SansNibs' */


/*
@interface       SansList : NSView <ArrayLike>
@property (NATOM)     CGF   rowHeight;
@property (NATOM,CP) NSString*(^rowTitleForObject)      (id object);


//#define           TOSTRING(X) [NSString stringWithUTF8String:X]  //   (NSString*)(X == NULL ? @"" : [NSString stringWithUTF8String:#X])

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


#define _Sans(name,X,ret) + (ret) name; // usage CLASSMETHOD_RETURNS(window, _Main)

_Sans( window, returns_the, _Main )  ! Look boss, ze window! 
_Sans(   View, returns_the, _View )  ! So perfect and young. 
_Sans(  layer, returns_the, _Lens )  ! Peel it back, slowly. 

#define implemented optional
@implemented
*/

//#define ALIAS_CLASS_POINTER_WITH(X,Y)ALIAS_CLASS_POINTER_WITH(X,Y);
//typedef NSObject _NSO_;

