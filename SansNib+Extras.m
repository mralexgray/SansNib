
#import <AtoZ/AtoZ.h>
#import <SansNib.h>

void AvailableIcons(void);

@interface SansNibWindowButton : NSObject
@property  CASHL *box;
@property  CAL * icon;
@end
@interface SansNibWindow :NSWindow
@property CGFloat barHeight, cornerRadius;
@property NSView * view;
@property CALayer* layer;
@end

@implementation SansNib (Implementation)

+ (id) forwardingTargetForSelector:(SEL)s {
   return s == @selector(addButton:block:)
             ? SansNibWindowButton.class
        : s == @selector(buttons) || s == @selector(window) || s == @selector(eventBlocks)
             ? SansNib.sansNib
        : s == @selector(view) || s == @selector(layer)
             ? SansNib.window : nil;
}

+ (id) addViewWithClass:(Class)k { NSV * v = [k new]; [self addViewWithSplit:v]; return v; }

+ (void) addViewWithSplit:(NSV*)v { NSSplitView * s = [self.view.lastLastSubview split];

  NSV * t = s.subviews[1]; v.frame = t.bounds; [t removeFromSuperview]; [s addSubview:v];
}

+ (NSSPLTV*) split {  NSV * v = self.view;

  return ((NSV*)v.lastSubview ?: ^{ NSV*halve;
    [v addSubview:halve = [AZSimpleView withFrame:v.bounds color:BLUE]];
    [halve setAutoresizingMask:v.autoresizingMask];  return halve; }()
  ).split;
}
+    (NSTV*) addTableForObjects:(NSA*)a                 { NSView *v; NSScrollView *s; NSTableView *t; NSTableColumn *c;

  v = SansNib.view.subviews.lastObject ?: SansNib.view;
  v = [v isKindOfClass:NSSplitView.class] ? v.subviews.lastObject : v;
  NSLog(@"adding it to %@", v);
  [v addSubview:                          s =  NSScrollView.new];
  [s setDocumentView:                     t =   NSTableView.new];
  [t addTableColumn:                      c = NSTableColumn.new];
  [c setResizingMask:             NSTableColumnAutoresizingMask];
  [s setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
  [t setUsesAlternatingRowBackgroundColors:                 YES];
  [t setHeaderView:                                         nil];
  s.frame = t.frame = v.bounds;
  [c bind:NSValueBinding toObject:[NSArrayController.alloc initWithContent:a] withKeyPath:@"arrangedObjects" options:nil];  return t;
}
@end

@implementation SansNibWindow

- (id) init {

  self = [super initWithContentRect:AZScaleRect(AZScreenFrame(),.4) styleMask:0|8 backing:2 defer:NO];  // Our "windowView" is just the contentView.

  self.acceptsFirstResponder      =
  self.acceptsMouseMovedEvents    =
  self.movableByWindowBackground  = YES;
  self.opaque                     = NO;
  self.backgroundColor            = NSColor.clearColor;
  self.minSize                    = (NSSize){200,100};
  _barHeight                      = 32;
  _cornerRadius                   = 10;
  [self.contentView addSubview:_view = [NSV viewWithFrame:AZRectTrimmedOnTop(self.contentRect,_barHeight)]];
  CAL *d = [CAL layerWithFrame:self.view.bounds drawnUsingBlock:^(CALayer *l) {
    NSBP *p = [NSBP bezierPathWithRoundedRect:l.bounds cornerRadius:_cornerRadius];
    [GRAYGRAD drawInBezierPath:p angle:270];
    [p bezel];
  }];
  [self.contentView setLayer:d];// addSublayer:d];
  [self.contentView setWantsLayer:YES];
  _layer                = CAL.layer;
  CASHLA *mask = [CASHLA layer];

  [mask setPathForRect:^NSBezierPath *(id shp) { return [NSBP bezierPathWithRoundedRect:[shp bounds] cornerRadius:_cornerRadius inCorners:OSBottomLeftCorner|OSBottomRightCorner]; }];
  mask.fillColor = cgBLACK;
  mask.strokeColor = cgCLEARCOLOR;
  _layer.mask = mask;
  _layer.contents  = NSIMG.randomWebImage;
  _view.layer           = _layer;
  _view.wantsLayer      = YES;
  _layer.filterName     = @"CIOverlayBlendMode";

  [NSEVENTLOCALMASK:NSMouseMovedMask|NSLeftMouseUpMask|NSLeftMouseDownMask|NSScrollWheelMask handler:^(NSE *ev) {

//    XX([_view hitTest:ev.locationInWindow]);
//    CALayer *x = [_layer hitTestSubs:ev.locationInWindow];
//    x ? [Lasso rope:x] : [Lasso setFree];

    if (ev.type == NSLeftMouseUp) {
      CALayer *z = [[self.contentView layer] hitTest:ev.locationInWindow];
      z.eventBlock ? [z blinkLayerWithColor:BLACK], z.eventBlock(ev) : nil;
    }
    for (EventBlock i in SansNib.eventBlocks) i(ev);
    return ev;
  }];
  return self;
}
@end
//              ?: [[self.contentView layer] hitTest:ev.locationInWindow];
//    NSLog(@"%@ : %@ - %@",x, AZEventToString(ev.type), AZString(ev.locationInWindow));

@implementation SansNibWindowButton

+ (void) addButton:(id)x block:(VoidBlock)blk   { AZSTATIC(NSR,bRect,((NSR){0,0,22,22})); AZSTATIC_OBJ(NSA,feng,NSC.fengshui.jumbled);

  SansNibWindowButton *new = self.new;

  NSR buttFrame   = (NSRect){ SansNib.view.width - 33 * (SansNib.buttons.count + 1) -10, SansNib.window.height - 22, 22, 22 };
  new.box         = [CASHL layerWithFrame:buttFrame mask:kCALayerMinXMargin|kCALayerMinYMargin];                // box.anchorPoint = AZAnchorBottomLeft;// AZAnchorTopRight;// AZTopRightPoint(buttFrame);//
  new.box.bgC     = [feng.nextObject CGColor];
  new.box.path    = [NSBP bezierPathWithPaths:@[[NSBP bezierPathWithRect:AZLeftEdge (bRect,2)],
                                                    [NSBP bezierPathWithRect:AZRightEdge(bRect,2)]]].CGPath;

  CATXTL *l       = (id)(new.icon = [CATXTL noHitLayerWithFrame:buttFrame mask:kCALayerMinXMargin|kCALayerMinYMargin]);
  l.string        = x ?: NSS.randomWord.firstLetter;
  l.fontSize      = 18;
  l.font          = AtoZ.cfFont;
  l.frame             = AZCenterRectInRect(l.dimensions, AZInsetRect(new.box.frame,10));
  l.fgC               = cgBLACK;
  new.box.fillColor   = cgWHITE;
  new.box.name        = [x withString:@"(BOX)"];
  new.box.eventBlock  = blk;
  new.box.filterName  = @"CIOverlayBlendMode";
  [[SansNib.window.contentView layer] addSublayers:@[new.box, l]];
  [SansNib.buttons addObject:new];
}
@end

void        AvailableIcons(void) {

  NSSplitView *splitter = SansNib.split;
  NSSCRLV *sv 	= [NSSCRLV viewWithFrame:[splitter.firstSubview bounds]];
  sv.autoresizingMask = NSSIZEABLE;
  NSIMG* i	= [NSImage contactSheetWith:NSIMG.monoIcons inFrame:AZRectExceptHigh([splitter.firstSubview bounds], ((NSV*)splitter.firstSubview).height)];
  NSIV *iv  	= [NSIV viewWithFrame:AZRectFromSize(i.size)];
  iv.image 	= i;
  sv.hasVerticalScroller = YES;
  sv.documentView = iv;
  [splitter.subviews.lastObject addSubview:sv];
}

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
