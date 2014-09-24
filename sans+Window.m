
#import "sans.h"
@import AtoZ;


@interface SansNibWindowButton : NSObject
@property         CAShapeLayer * box;
@property              CALayer * icon;
@end

typedef NS_ENUM(int,DBDragMode)
{
  DragModeNone,               DragModeMove,
	DragModeResizeFromTop,      DragModeResizeFromRight,
  DragModeResizeFromTopRight, DragModeResizeFromBottomRight
};

@interface       SansNibWindow : NSWindow

//@property (nonatomic)	BOOL		snapsToEdges;		/* whether or not the window snaps to edges */
//@property (nonatomic)	CGFloat		snapTolerance,	/* distance from edge within which snapping occurs */
//                                padding,minWidth;
//@property (nonatomic)	 BOOL		snapping;		/* whether we're currently snapping to an edge */
//@property (nonatomic)	 NSPoint		dragStartLocation;	/* keeps track of last drag's mousedown point */
//@property (nonatomic)	NSSize		clickDistanceFromWindowEdge;
//@property (nonatomic)	DBDragMode	currentDragMode;
//@property (unsafe_unretained)	id			controller;

//- (void) saveFrame;
//- (void) loadFrame;
//
//	/* Accessor methods */
//- (void) setOnScreen: (BOOL) flag;
//- (void) setSticky:(BOOL)flag;

@property               NSView * userview;
//@property              CAShapeLayer * mask;
@property              CALayer * userlayer,
                               * hitLayer;
@property              CGFloat   barHeight,    // this is the fake "title bar"
                                 cornerRadius;
@end
//@interface         SansNibView : NSView @end
//@implementation SansNibView
//- (BOOL)acceptsFirstMouse:(NSEvent *)e { return YES; }
//- (void) drawRect:(NSRect)d { [NSColor.redColor set]; NSRectFill(d); [super drawRect:d]; }
//@end
@implementation SansNibWindow

- (BOOL) acceptsFirstResponder { return YES; }
- (BOOL)canBecomeKeyWindow { return YES; }
- (BOOL) canBecomeMainWindow {return YES; }

-          (id) init {

  self = [super initWithContentRect:NSInsetRect(NSScreen.mainScreen.frame,300,200) styleMask:0|8 backing:2 defer:NO];
//  self.contentView                = .new;
//  self.acceptsFirstResponder      =
  self.acceptsMouseMovedEvents    =
  self.movableByWindowBackground  = YES;
  self.opaque                     = NO;
  self.backgroundColor            = NSColor.clearColor;
  
  self.minSize                    = (NSSize){200,100};
  _barHeight                      = 30;
  _cornerRadius                   = 10;                                                                       // round those corners, girl
  NSRect r = [self.contentView frame];
  [self.contentView addSubview:_userview =
  [NSView.alloc initWithFrame:(NSRect){r.origin, r.size.width, r.size.height - _barHeight}]];

  CALayer *l = CALayer.layer;
  l.frame = [self.contentView bounds];
  l.delegate = self;
  [l setNeedsDisplay];

  [self.contentView   setLayer:l];
  [self.contentView setWantsLayer:YES];
  _userlayer  = CALayer.layer;
  _userlayer.arMASK = CASIZEABLE;
//  CASHLA *_mask          = [CASHLA layerNamed:@"SansNibWindowMask"];
//  [_mask setPathForRect:^NSBezierPath *(id shp) { return [NSBP bezierPathWithRoundedRect:[shp bounds] cornerRadius:_cornerRadius inCorners:OSBottomLeftCorner|OSBottomRightCorner]; }];
//  CASHLA *mask          = [CASHLA layerNamed:@"SansNibWindowMask"];
//  [mask setPathForRect:^NSBezierPath *(id shp) { return [NSBP bezierPathWithRoundedRect:[shp bounds] cornerRadius:_cornerRadius inCorners:OSBottomLeftCorner|OSBottomRightCorner]; }];
//  _mask.fillColor        = NSColor.blackColor.CGColor;
//  _mask.strokeColor    /  = NSColor.clearColor.CGColor;
//  _userlayer.mask           = _mask;

  _userlayer.backgroundColor            = NSColor.orangeColor.CGColor;
  _userview.layer           = _userlayer;
  _userview.wantsLayer      =
  _userview.layerUsesCoreImageFilters = YES;
  [_userlayer setCompositingFilter:[CIFilter filterWithName:@"CIOverlayBlendMode"]];


  [NSEvent addLocalMonitorForEventsMatchingMask:NSMouseMovedMask|NSLeftMouseUpMask|NSLeftMouseDownMask|NSScrollWheelMask handler:^NSEvent*(NSEvent *ev) {

//    XX([_view hitTest:ev.locationInWindow]);
//    [Lasso enabled] && !!(self.hitLayer = [_layer hitTestSubs:ev.locationInWindow]) ? [Lasso rope:_hitLayer] : [Lasso setFree];

    if (ev.type == NSLeftMouseUp) {
      CALayer *z = [self.windowLayer hitTest:ev.locationInWindow];
      //XX(z);
      CALayer* box = [z.sublayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [[evaluatedObject vFK:@"name"]rangeOfString:@"box"].location != NSNotFound;
      }]][0];
      //XX(box.owner);
      void(^r)(NSEvent*);
      if (box && (r    = [box valueForKey:@"eventBlock"]))  r(ev);
//            [box blinkLayerWithColor:BLACK];

//        box.owner.selected = !box.owner.selected;
//      }
    }
    for (EventBlock i in self.sans.handlers.arrangedObjects) i(ev);
    return ev;
  }];
  return self;
}
- (void) setFrame:(NSRect)r display:(BOOL)f {
  [super setFrame:r display:f];

//  [NSBP bezierPathWithRoundedRect:[shp bounds] cornerRadius:_cornerRadius inCorners:OSBottomLeftCorner|OSBottomRightCorner]; }];

}
/*
- init { self = [super initWithContentRect:NSInsetRect(NSScreen.mainScreen.frame,300,200) styleMask:0|8 backing:2 defer:NO];
// AZScaleRect(AZScreenFrame(),.4) styleMask:0|8 backing:2 defer:NO];
  self.contentView                = SansNibView.new;
  self.acceptsMouseMovedEvents    =
  self.movableByWindowBackground  = YES;
  self.opaque                     = NO;
  self.backgroundColor            = NSColor.clearColor;//greenColor;
  self.minSize                    = (NSSize){200,100};
  _barHeight                      = 30;
  _cornerRadius                   = 10;                                                                       // round those corners, girl
  NSRect r = [self.contentView frame];
  [self.contentView addSubview:_userview =
  [NSView.alloc initWithFrame:(NSRect){r.origin, r.size.width, r.size.height - _barHeight}]];

  CALayer *framelayer             = CALayer.new,
          *mask                   = CALayer.new;
  _userview.layer = _userlayer    = CALayer.new;
  framelayer.frame                = _userview.bounds;
  framelayer.delegate             = self;         [framelayer setNeedsDisplay];
  [self.contentView setLayer:framelayer];
//  [self.contentView setWantsLayer:
  id fvie'w = [self.contentView superview];
  _Lens flayer =  CALayer.new; flayer.backgroundColor = NSColor.redColor.CGColor;
  [fview setWantsLayer:YES];
  [fview setWantsLayer:_userview.layerUsesCoreImageFilters = YES];
//  _view.wantsLayer         = ;r
  _userlayer.borderColor        = NSColor.yellowColor.CGColor;
  _userlayer.borderWidth        = 8;
  mask.frame                    = _userlayer.bounds;
  _userlayer.autoresizingMask   = kCALayerWidthSizable| kCALayerHeightSizable;
  mask.autoresizingMask         = kCALayerWidthSizable| kCALayerMinYMargin;
  mask.backgroundColor          = NSColor.blackColor.CGColor;
  _userlayer.backgroundColor    = NSColor.orangeColor.CGColor;
  _userlayer.mask               = mask;
  _userlayer.compositingFilter  = [CIFilter filterWithName:@"CIOverlayBlendMode"];
  [self setSticky:YES];
  [sans_NCENTER addObserverForName:NSApplicationWillBecomeActiveNotification object:NSApp queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) {
    [self setOnScreen:YES];
  }];
//  CASHLA *mask          = [CASHLA layerNamed:@"SansNibWindowMask"];
//  [mask setPathForRect:^NSBezierPath *(id shp) { return [NSBP bezierPathWithRoundedRect:[shp bounds] cornerRadius:_cornerRadius inCorners:OSBottomLeftCorner|OSBottomRightCorner]; }];
  //[NSBP bezierPathWithRoundedRect:[shp bounds] cornerRadius:_cornerRadius inCorners:OSBottomLeftCorner|OSBottomRightCorner]; }];
//  mask.strokeColor      = NSColor.blackColor.CGColorcgCLEARCOLOR;
  return self;
}
*/
- (void) drawLayer:(CALayer*)l inContext:(CGContextRef)ctx {  // draws window's "background"

   [NSGraphicsContext saveGraphicsState];
   [NSGraphicsContext  setCurrentContext:[NSGraphicsContext graphicsContextWithGraphicsPort:ctx flipped:NO]];
 NSBezierPath *p = [NSBezierPath bezierPathWithRoundedRect:l.bounds xRadius:_cornerRadius yRadius:_cornerRadius]; // Draw a purty gradient
  [[NSGradient.alloc initWithColorsAndLocations:[NSColor colorWithDeviceWhite:212/255. alpha:1], 0,[NSColor colorWithDeviceWhite:182/255. alpha:1],.5,[NSColor colorWithDeviceWhite:151/255. alpha:1], 1, nil]
                               drawInBezierPath:p angle:270];
    [NSGraphicsContext  restoreGraphicsState];

  [p bezel]; // bezel it for even prettier edges!
}
-        (BOOL) performKeyEquivalent:(NSEvent*)e { return YES; }


	/*
*****************************
The DeskBrowse source code is the legal property of its developers, Joel Levin and Ian Elseth
*****************************

@synthesize controller, currentDragMode, dragStartLocation;
@synthesize snapTolerance, snapping, snapsToEdges, clickDistanceFromWindowEdge, minWidth, padding;

typedef NSInteger CGSConnection, CGSWindow;
extern CGSConnection _CGSDefaultConnection();
extern OSStatus CGSGetWindowTags  (const CGSConnection cid, const CGSWindow wid, NSInteger *tags, NSInteger thirtyTwo);
extern OSStatus CGSSetWindowTags  (const CGSConnection cid, const CGSWindow wid, NSInteger *tags, NSInteger thirtyTwo);
extern OSStatus CGSClearWindowTags(const CGSConnection cid, const CGSWindow wid, NSInteger *tags, NSInteger thirtyTwo);

- (void)setSticky:(BOOL)flag
{
	CGSConnection connectionID = _CGSDefaultConnection();
	CGSWindow winNumber = [self windowNumber];
	NSInteger allTags[0];
	NSInteger theTags[2] = {0x0002, 0};
	if(!CGSGetWindowTags(connectionID, winNumber, allTags, 32)) {
		if (flag)	CGSSetWindowTags(connectionID, winNumber, theTags, 32);
		else		CGSClearWindowTags(connectionID, winNumber, theTags, 32);
	}
}

#pragma mark -

//- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
//{
//		if (!(self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO])) return nil;
//  [self setLevel:NSNormalWindowLevel];
//  [self setOpaque:YES];
//	[self setBackgroundColor:[NSColor redColor]];
//	[self setAlphaValue:1.0];
//	[self setHasShadow:YES];
//	minWidth = 400.0;
//	 return self;
//}



 * 
 *	Mouse event handlers
 *	Since we don't have a titlebar, we handle window-dragging ourselves.
 *
(*/
- (void) sendEvent:(NSEvent *)e { // NSMouseMovedMask|NSLeftMouseUpMask|NSLeftMouseDownMask|NSScrollWheelMask
//    XX([_view hitTest:ev.locationInWindow]);
//    [Lasso enabled] && !!(self.hitLayer = [_layer hitTestSubs:ev.locationInWindow]) ? [Lasso rope:_hitLayer] : [Lasso setFree];
//    if (e.type == NSLeftMouseUp) {
      CALayer *z = [self.windowLayer hitTest:e.locationInWindow];
      NSLog(@"%@", z);

    static BOOL s = NO;
//    e.type == NSLeftMouseUp && e.clickCount == 3 ? [self setOnScreen:s =!s] : nil;
      //XX(z); CAL* box = [z sublayerWithNameContaining:@"box"];XX(box.owner);
//    if (box){ [box blinkLayerWithColor:BLACK]; void(^r)(NSE*) = box [@"eventBlock"];  r(ev);
//        box.owner.selected = !box.owner.selected;
//      }
//  }
  for (EventBlock i in Sans().handlers.arrangedObjects) i(e);
  [super sendEvent:e];
}
/*
- (void) mouseDown: (NSEvent*) theEvent { NSLog(@"%@", NSStringFromSelector(_cmd));

  currentDragMode		= DragModeNone;
  dragStartLocation	= [theEvent locationInWindow];
	NSPoint origin		= self.frame.origin;
	NSSize size   		= self.frame.size;
		
	if ((origin.x + dragStartLocation.x < (origin.x + size.width - 15) && (origin.x + dragStartLocation.x >= origin.x) && ((origin.y + dragStartLocation.y <= origin.y + 70))))
    currentDragMode = DragModeMove; 	// Moving
	else if (origin.y + dragStartLocation.y >= (origin.y + size.height) - 8)
	{
		if (origin.x + dragStartLocation.x >= (origin.x + size.width) - 8)
		{
			// Resizing from top right
			
			currentDragMode						= DragModeResizeFromTopRight;
			clickDistanceFromWindowEdge.width	= (origin.x + size.width) - (origin.x + dragStartLocation.x);
			clickDistanceFromWindowEdge.height	= (origin.y + size.height) - (origin.y + dragStartLocation.y);
		}
		else
		{
			// Resizing from top
			
			currentDragMode						= DragModeResizeFromTop;
			clickDistanceFromWindowEdge.height	= (origin.y + size.height) - (origin.y + dragStartLocation.y);
		}
	}
	else if (origin.x + dragStartLocation.x >= (origin.x + size.width) - 15)
	{
		if (origin.x + dragStartLocation.x >= (origin.x + size.width) - 8)
		{
			// Resizing from right
			
			currentDragMode						= DragModeResizeFromRight;
			clickDistanceFromWindowEdge.width	= (origin.x + size.width) - (origin.x + dragStartLocation.x);
		}
		
		if (origin.y + dragStartLocation.y <= origin.y + 15)
		{
			// Resizing from bottom right
						
			currentDragMode						= DragModeResizeFromBottomRight;
			clickDistanceFromWindowEdge.width	= (origin.x + size.width) - (origin.x + dragStartLocation.x);
			clickDistanceFromWindowEdge.height	= dragStartLocation.y;
		}
	}
}

- (void)mouseDragged:(NSEvent *)theEvent
{
	 if ([theEvent type] == NSLeftMouseDragged) {
		  NSPoint origin;
		NSSize	size;
		NSSize	minSize;
		  NSPoint newLocation;
		
		NSRect		screenRect			= [[self screen] frame];
		
		NSRect		newFrameRect		= [self frame];
		NSPoint		newOrigin			= [self frame].origin;
		NSSize		newSize				= [self frame].size;
		
		  origin							= [self frame].origin;
		size							= [self frame].size;
		minSize							= [self minSize];
		  newLocation						= [theEvent locationInWindow];
		
		NSSize		distanceMouseMoved = NSMakeSize(newLocation.x - size.width + clickDistanceFromWindowEdge.width, newLocation.y - clickDistanceFromWindowEdge.height);
		
		  
		switch (currentDragMode)
		{
			case DragModeMove:
			{
				// Move window
				
				newOrigin.x = origin.x;
				newOrigin.y	= origin.y + newLocation.y - dragStartLocation.y;
				
				
				// Make sure we don't move past the menu bar
								
				if (newOrigin.y > origin.y)
				{
					if ((newOrigin.y + size.height) > ((screenRect.origin.y + screenRect.size.height) - 22))
					{
						newOrigin.y = ((screenRect.origin.y + screenRect.size.height) - 22) - size.height;
					}
				}
				
				break;
			}
			case DragModeResizeFromTop: // Resize from top -- CHANGED TO MOVE FROM TOP
			{
				// Move window
				
				newOrigin.x = origin.x;
				newOrigin.y	= origin.y + newLocation.y - dragStartLocation.y;
				
				
				// Make sure we don't move past the menu bar
				
				if (newOrigin.y > origin.y)
				{
					if ((newOrigin.y + size.height) > ((screenRect.origin.y + screenRect.size.height) - 22))
					{
						newOrigin.y = ((screenRect.origin.y + screenRect.size.height) - 22) - size.height;
					}
				}
				
				break;
			}
			case DragModeResizeFromTopRight: // Resize from top right
			{
				// Resize horizontally
				
				newSize.width = size.width + distanceMouseMoved.width;
				
				if (origin.x + newSize.width > screenRect.size.width)
				{
					newSize.width = screenRect.size.width - origin.x;
				}
				
				if (newSize.width < minSize.width)
				{
					newSize.width	= minSize.width;
				}
				
				
				// Resize vertically
				
				distanceMouseMoved.height	= (newLocation.y - newSize.height) + clickDistanceFromWindowEdge.height;
				newSize.height				= size.height + distanceMouseMoved.height;
				
				if (newSize.height < minSize.height)
				{
					newSize.height	= minSize.height;
				}
				
				
				// Make sure we don't resize past the menu bar
				
				if (newOrigin.y + newSize.height > (screenRect.origin.y + screenRect.size.height) - 22)
				{
					newSize.height = ((screenRect.origin.y + screenRect.size.height) - 22) - newOrigin.y;
				}
				
				break;
			}
			case DragModeResizeFromRight: // Resize from right
			{
				// Resize horizontally
				
				newSize.width = size.width + distanceMouseMoved.width;
				
				if (origin.x + newSize.width > screenRect.size.width)
				{
					newSize.width = screenRect.size.width - origin.x;
				}
				
				if (newSize.width < minSize.width)
				{
					newSize.width	= minSize.width;
				}
				
				break;
			}
			case DragModeResizeFromBottomRight: // Resize from bottom right
			{
				// Resize horizontally
				
				newSize.width = size.width + distanceMouseMoved.width;
				
				if (origin.x + newSize.width > screenRect.size.width)
				{
					newSize.width = screenRect.size.width - origin.x;
				}
				
				if (newSize.width < minSize.width)
				{
					newSize.width	= minSize.width;
				}
				
				
				// Resize vertically
				
				newSize.height	= size.height - distanceMouseMoved.height;
				newOrigin.y		= origin.y + distanceMouseMoved.height;
				
				if (newSize.height < minSize.height)
				{
					newOrigin.y		= newOrigin.y - (minSize.height - newSize.height);
					newSize.height	= minSize.height;
				}
				
				break;
			}
			default:
			{
			}
		}
		
		newFrameRect.origin		= newOrigin;
		newFrameRect.size		= newSize;
		
		[self setFrame: newFrameRect display: YES];
	 }
}

- (void) mouseUp: (NSEvent*) theEvent
{
	[self saveFrame];
	
	currentDragMode	= DragModeNone;
}


#pragma mark -

- (void) saveFrame{
	[sans_PREFS setFloat:self.frame.origin.y forKey:@"slideY"];
	[sans_PREFS setFloat:self.frame.size.width forKey:@"slideW"];
  [sans_PREFS setFloat:self.frame.size.height forKey:@"slideH"];
}

- (void) loadFrame {
	
	[self setFrame:(NSRect){[sans_PREFS floatForKey:@"slideW"],
                          [sans_PREFS floatForKey:@"slideY"],
                          [sans_PREFS floatForKey:@"slideW"],
                          [sans_PREFS floatForKey:@"slideH"]}
                          display: YES animate: NO];
}

*/
#pragma mark -

/* Accessor methods */
/*
- (void) setOnScreen: (BOOL) flag
{
	NSRect	frame		= [self frame];
	NSRect	newFrame	= NSZeroRect;
	NSPoint	origin		= frame.origin;
	NSSize	size		= frame.size;
	
	if (flag)
	{
		// Show window
		
		newFrame = NSMakeRect(0, origin.y, size.width, size.height);
		[self setIsVisible: flag];
		[self setFrame: newFrame display: YES animate: YES];
	}
	else
	{
		// Hide window
				
		newFrame = NSMakeRect(-size.width, origin.y, size.width, size.height);
		
		[self setFrame: newFrame display: YES animate: YES];
		[self setIsVisible: flag];
	}
}
*/
@end

@implementation SansNibWindowButton
- (id) forwardingTargetForSelector:(SEL)s {
  return [self.box respondsToSelector:s] ? self.box : [super forwardingTargetForSelector:s];
}
+        (void) addButton:(id)x block:(void(^)())blk   {

  static NSRect bRect = (NSRect){0,2,22,22}; // AZSTATIC_OBJ(NSA,feng,NSC.fengshui.jumbled);
/*
  SansNibWindowButton *new = self.new;
  NSC *color   = AtoZ.globalPalette.nextNormalObject;
  NSR buttF    = (NSR){ SansNib.view.width - 33 * (SansNib.buttons.count + 1) -10, SansNib.window.height - 26, 22, 22 };
  new.box      = [CASHL layerWithFrame:buttF mask:kCALayerMinXMargin|kCALayerMinYMargin];                // box.anchorPoint = AZAnchorBottomLeft;// AZAnchorTopRight;// AZTopRightPoint(buttFrame);//
//  new.box.shouldRasterize = YES;
  new.box.owner = new;
//  [new b:@"selected" toKP:@"box.selected"];
  new.box.path = ({ NSBP *s = [NSBP bezierPathRoundedRectOfSize:bRect.size]; s; }).CGPath;// bezierPathWithPaths:@[bRect[NSBP withR:  AZLeftEdge (bRect,2)],
                                      //       [NSBP withR: AZRightEdge (bRect,2)],
                                        //     [NSBP withR: AZLowerEdge (bRect,2)]]].CGPath;

  CATXTL *l    = (id)(new.icon = [CATXTL noHitLayerWithFrame:buttF mask:kCALayerMinXMargin|kCALayerMinYMargin]);
  l.string     = x ?: NSS.randomWord.firstLetter;
  l.fontSize        = ((NSS*)x).isEmoji ? 12 : 18;
  l.font       = AtoZ.cfFont;
  l.frame      = AZCenterRectInRect(l.dimensions, AZInsetRect(new.box.frame,10));
  new.box.fillColor = color.CGColor;
  l.fgC        = color.contrastingForegroundColor.CGColor;
  new.box.lineWidth = 1.4;
  [new.box b:@"strokeColor" tO:new wKP:@"selected" t:^id(id value) {
    return [value bV] ? (id) cgBLACK : (id)cgWHITE;
  }];
  new.box.name        = [x withString:@"(box)"];
  new.box[@"eventBlock"]  = blk;
  new.box.filterName  = @"CIOverlayBlendMode";
  [[SansNib.window.contentView layer] addSublayers:@[new.box, l]];
  [SansNib.buttons addObject:new];
  */
}
@end

void        AvailableIcons(void) {

#pragma mark - disabled for migration


/*
  NSSplitView *splitter = SansNib.split;
  NSSCRLV *sv 	= [NSSCRLV viewWithFrame:[splitter.firstSubview bounds]];
  sv.autoresizingMask = NSSIZEABLE;
  NSIMG* i	= [NSImage contactSheetWith:NSIMG.monoIcons inFrame:AZRectExceptHigh([splitter.firstSubview bounds], ((NSV*)splitter.firstSubview).height)];
  NSIV *iv  	= [NSIV viewWithFrame:AZRectFromSize(i.size)];
  iv.image 	= i;
  sv.hasVerticalScroller = YES;
  sv.documentView = iv;
  [splitter.subviews.lastObject addSubview:sv];
  */
}

//              ?: [[self.contentView layer] hitTest:ev.locationInWindow];
//    NSLog(@"%@ : %@ - %@",x, AZEventToString(ev.type), AZString(ev.locationInWindow));

//CALayer * AddLayer(NSView*v) { XX(v.className);
//
//  CALayer *layer        = v.guaranteedLayer;
//  layer.borderColor     = cgRANDOMGRAY;
//  layer.borderWidth     = 3;
//  layer.backgroundColor = cgRANDOMCOLOR;
//  return layer;
//}

// ?: (id)(v.wantsLayer = YES, v.layer =  CALayer.new);
  //  NSArray *colors = RANDOMPAL, *grad = [NSC gradientPalletteLooping:colors steps:100];
  //  CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyframes:100 function:^id(double frac) { return (id)[[grad normal:floor(frac*100)]CGColor]; }];
  //  ani.repeatCount = HUGE_VAL;	ani.duration = colors.count * 2.;
  //  [v.layer = CALayer.new addAnimation:ani forKey:@"backgroundColor"]; v.wantsLayer = YES;
//  layer.actions =   @{ @"position":NSNull.null, @"bounds":NSNull.null };//  NSView * v = toSplit.subviews.count ? toSplit.firstSubview : [NSView viewWithFrame:toSplit.bounds];
//  if (!toSplit.subviews.count) [toSplit addSubview:v];
//  NSSplitView * x;  if ((x = v.split) && x.subviews.count) [x.subviews each:^(id obj) { AddLayer(obj); }];  return [x setDividerStyle:NSSplitViewDividerStyleThin], x;
//  [self.contentView               = [BLKV viewWithFrame:self.contentRect drawBlock:^(NSView * v, NSRect r) {
//    [GRAYGRAD drawInBezierPath:self.windowPath angle:270];
//    [self.windowPath bezel];
//  }] addSubview:
//  [NSAS.alloc initWithString:x attributes:@{ 
//        NSForegroundColorAttributeName: (id)cgWHITE,
//        NSStrokeWidthAttributeName:@(2.),
//        NSStrokeColorAttributeName : (id)cgBLACK}] : NSS.randomWord.firstLetter;
//    [[NSBP bezierPathWithRoundedRect:l.bounds cornerRadius:30 inCorners:OSBottomLeftCorner|OSBottomRightCorner] fillWithColor:RED];
//    [[NSBP bezierPathWithRoundedRect:self.contentRect cornerRadius:30] fillWithColor:WHITE];
//  d.position = (NSP){self.frameMidX, 0};
//  d.anchorPoint = AZAnchorBottom;
//  [self.contentView layer].masksToBounds = YES;
//   [CAL layerWithFrame:self.contentRect drawnUsingBlock:^(CALayer *l) {
////    NSLog(@"drawing in context, %@", AZString(self.contentRect));
//    [[NSBP bezierPathWithRoundedRect:self.contentRect cornerRadius:30 inCorners:OSBottomLeftCorner|OSBottomRightCorner] fillWithColor:RED];
//  }];
//- (NSTableView*) encloseNew:(Class)tableOrOutline { }

//  t.dataSource = self;

//}
//
//- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
//    return 3;
//}
//
//- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    return [NSString stringWithFormat:@"%ld", row];
//}
//  _layer.contents       = NSIMG.randomWebImage;