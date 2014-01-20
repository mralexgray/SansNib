
#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import <AtoZ/AtoZ.h>
#import "SansNib.h"

#define MENUALLOC										  [NSMenu										ALLOCMENUZONE]
#define MENUSEPERATOR									[NSMenuItem               separatorItem]
#define ALLOCMENUZONE									allocWithZone:				 [NSMenu menuZone]
#define MENUTITLED(x)									[[NSMenu ALLOCMENUZONE] initWithTitle:x]
#define MENUITEMACTION(name,k,...)		[NSMenuItem menuWithTitle:name key:k action:(id)__VA_ARGS__]
#define MENUITEMNAMED(x,y,z,SUBMENU)	({ id a = [[NSMenuItem ALLOCMENUZONE] initWithTitle:x action:y keyEquivalent:z]; [a setSubmenu:SUBMENU]; a; })
#define DISPATCHONCE(x)								({ static dispatch_once_t uno;	dispatch_once(&uno,^{ x }); })
//#define SETPOLICY					[self.sharedApplication setActivationPolicy:NSApplicationActivationPolicyRegular]
#define DISPATCHINIT			[self sharedApplication]; DISPATCHONCE([NSApp setMainMenu:MENUTITLED(@"")];	nibless = self.alloc; nibless = nibless.init;)
#define ABOUTRPROCESS			[NSString stringWithFormat:@"About %@", NSProcessInfo.processInfo.processName]

@implementation  SansNib static SansNib * nibless;

+  (SansNib*) sansNib { DISPATCHINIT; /* SETPOLICY; */ return nibless; }
+      (void) run     { [self.window makeKeyAndOrderFront:nil];   [NSApp run]; }
+ (NSWindow*) window  { return self.sansNib.window;	}
+   (NSView*) view    { return self.sansNib.view;		}
-        (id) init    { if ((self = super.init) != nibless) return nibless; [self.class sharedApplication].mainMenu.itemArray =

												 @[     _aboutMenuItem = MENUITEMNAMED (@"",	   NULL, @"", _aboutMenu = MENUTITLED(@"About SansNib")),
														     _fileMenuItem = MENUITEMNAMED (@"File", NULL, @"",  _fileMenu = MENUTITLED(@"File")),
														     _editMenuItem = MENUITEMNAMED (@"Edit", NULL, @"",  _editMenu = MENUTITLED(@"Edit")),
															   _helpMenuItem = MENUITEMNAMED (@"Help", NULL, @"",  _helpMenu = MENUTITLED(@"Help")) ];
	_aboutMenu.itemArray = @[  _aboutAppMenuItem = MENUITEMACTION(ABOUTRPROCESS, @"" ,^(NSMI* menu){ [AZSHAREDAPP orderFrontStandardAboutPanelWithOptions: @{@"Credits": [@"c/o Steve Van Voorst via fbcocoa list\nvia Bernie Wylde / Ken Shmidheiser."	attributedWithFont:AtoZ.controlFont andColor:RED] ?: @"", @"ApplicationName":@"AtoZ Nibless Demo",	 @"Version":@"0.1 alpha for list", @"Copyright":@"Copyright 2012", @"ApplicationIcon": [NSImage imageNamed:@"atoz"]?:[NSImage imageNamed:NSImageNameUser], @"ApplicationVersion":AZFWORKBUNDLE.infoDictionary[@"CFBundleVersion"]?:@"v.N/A"}]; }),				MENUSEPERATOR,
													_preferencesMenuItem = MENUITEMACTION(@"Preferences (beeps for demo)...",							  @",",^(NSMI* item){ XX(item);	NSBeep(); [AZTalker say:@"Preferences"]; }), MENUSEPERATOR,
													   _servicesMenuItem = MENUITEMNAMED (@"Services",		NULL,															@"" , nil), MENUSEPERATOR,
																 _hideMenuitem = MENUITEMNAMED (@"Hide",				@selector(hide:),									@"" , nil),
													 _hideOthersMenuItem = MENUITEMNAMED (@"Hide Others",	@selector(hideOtherApplications:),@"" , nil),
															_showAllMenuItem = MENUITEMNAMED (@"Show All",		@selector(unhideAllApplications:),@"" , nil), MENUSEPERATOR,
															   _quitMenuItem = MENUITEMNAMED (@"Quit",				@selector(terminate:),						@"q", nil) ];
	_fileMenu.itemArray	= @[ 		   _openMenuItem = MENUITEMNAMED (@"Open...",			@selector(openFile:),							@"o", nil), MENUSEPERATOR,
													       _saveMenuItem = MENUITEMACTION(@"Save",           @"s",^(NSMI*m){ [AZTalker say:[m.title withString:@" not implemented"]]; }) ];
	_editMenu.itemArray = @[											 MENUITEMNAMED (@"Cut",					@selector(cut:),									@"x", nil),
																								 MENUITEMNAMED (@"Copy",				@selector(copy:),									@"c", nil),
																								 MENUITEMNAMED (@"Paste",				@selector(paste:),								@"v", nil),
																								 MENUITEMNAMED (@"Select All",	@selector(selectAll:),						@"a", nil) ];

	[@[_hideMenuitem, _hideOthersMenuItem, _showAllMenuItem, _quitMenuItem] makeObjectsPerformSelector:@selector(setTarget:) withObject:NSApp];
	[_helpMenu setItemArray:@[_helpMenuItemOne = [[NSMenuItem ALLOCMENUZONE] initWithTitle:@"Help Menu Item One..." action:NULL keyEquivalent:@"h"]]];
  [NSApp  setServicesMenu:_servicesMenuItem.submenu = _servicesMenu = MENUTITLED(@"Services")]; [NSApp setHelpMenu:_helpMenu];

  _view = (_window = [NSWindow.alloc initWithContentRect:AZScaleRect(AZScreenFrame(),.4)
                                               styleMask:0|1|2|8 backing:NSBackingStoreBuffered defer:NO]).contentView;

  return [NSEVENTLOCALMASK:NSLeftMouseUp handler:^NSEvent *(NSEvent *e)  { CALayer *l = [SansNib.view.superview.layer hitTest:e.locationInWindow];
    void(^k)(); if ((k = [l vFK:@"theBlock"])) k(); return e;
  }], self;
}

+ (NSSplitView*) split { NSSplitView *x;

  NSView * v = self.view.subviews.count ? self.view.subviews[0] : (id)([self.view addSubview:v = [NSView.alloc initWithFrame:self.view.bounds]], v);
  if ((x = v.split) && x.subviews.count) [x.subviews each:^(id obj) { AddLayer(obj); }];  return [x setDividerStyle:NSSplitViewDividerStyleThin], x;
}

+ (void) titleBarButton:(id)imageOrIcon action:(vBlock)block { NSView *superV = SansNib.sansNib.view.superview; static NSUI ctr = 0;

  CALayer *box;
  [superV.layer ?: (CALayer*)(superV.wantsLayer = YES, superV.layer) addSublayer: box = CALayer.layer];

  box.frame             = (NSRect){ superV.width - 25 * (ctr +1), superV.height - 19, 20, 16 };
  box.contents          = [imageOrIcon imageWithMaxSize:18];
  box.contentsGravity   = kCAGravityResizeAspectFill;
  box.autoresizingMask  = kCALayerMinXMargin|kCALayerMinYMargin;

  [box setValue:block forKeyPath:@"theBlock"];  ctr++;
}

+ (NSTableView*) tableForArray:(NSArray*)a { NSView *v; NSScrollView *s; NSTableView *t; NSTableColumn *c; NSArrayController *x = [NSArrayController.alloc initWithContent:a];

  v = self.sansNib.view.subviews.lastObject ?: self.sansNib.view;
  [v isKindOfClass:NSSplitView.class] ? v = v.subviews[1] : nil;
  [v addSubview:      s =  NSScrollView.new];
  [s setDocumentView: t =   NSTableView.new];
  [t addTableColumn:  c = NSTableColumn.new];
  [c setResizingMask:            NSTableColumnAutoresizingMask];
  [s setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
  [t setUsesAlternatingRowBackgroundColors:YES];
  [t setHeaderView:nil];
  s.frame = t.frame = v.bounds;
  [c bind:NSValueBinding toObject:x withKeyPath:@"arrangedObjects" options:nil];  return t;
}
@end
//  [l setAssociatedValue:@2 forKey:@"savedBlock" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
//  NSLog(@"Daved: %@", [l valueForKey:@"savedBlock"]);
//  XX([block blockDescription]);
//  void(^runner)(void) = buttons[0];//[1];
//  runner();
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//  });
//  [buttons = buttons ?: NSMutableArray.new;
//  NSButton    * butt;
//  [self.view.superview addSubview: butt = [NSButton.alloc initWithFrame:upperRight]]; // [buttons addObject: butt];
//	butt.image = imageOrIcon;// imageWithMaxSize:16];//imageWithAlpha:.7];
//	butt.actionBlock = block;
//	[butt setBordered:NO];
//  [butt setFocusRingType:NSFocusRingTypeNone];
//	butt.autoresizingMask = NSViewMinYMargin|NSViewMinXMargin;
//  if (![self.window.contentView superview].layer) [self.window.contentView superview].wantsLayer = YES;
//  butt.wantsLayer = YES;


CALayer * AddLayer(NSView*v) { XX(v.className);

//  NSArray *colors = RANDOMPAL, *grad = [NSC gradientPalletteLooping:colors steps:100];

//  CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyframes:100 function:^id(double frac) { return (id)[[grad normal:floor(frac*100)]CGColor]; }];
//  ani.repeatCount = HUGE_VAL;	ani.duration = colors.count * 2.;
  CALayer *layer = v.layer ?: (id)(v.wantsLayer = YES, v.layer =  CALayer.new);
//  [v.layer = CALayer.new addAnimation:ani forKey:@"backgroundColor"]; v.wantsLayer = YES;
  layer.actions =   @{ @"position":NSNull.null, @"bounds":NSNull.null };
  layer.borderColor = cgRANDOMGRAY; layer.borderWidth = 3; layer.backgroundColor = cgRANDOMCOLOR; return layer;
}


//	CAGL *gL = [layer sublayerWithName:@"bar"] ?: ^{ CAGL *gLayer;
//
//		[layer addSublayer:gLayer= [CAGL layerNamed:@"bar"]];
//		gLayer.endPoint		= AZAnchorRight;
//		gLayer.startPoint = AZAnchorLeft;
//		gLayer.actions = @{ @"position":AZNULL, @"bounds":AZNULL};
//		[gLayer addConstraintsSuperSize];
//		[gLayer addConstraints:@[AZConstRelSuperScaleOff(kCAConstraintHeight,.2,0.), AZConstRelSuperScaleOff(kCAConstraintMinY,1.,0.)]];
//		return  gLayer;
//	}();
//	XX(gL);
//	gL.colors		 = [grad map:^id(id obj) { return (id)[obj CGColor]; }];
//	gL.locations = [[@0 to:@100] map:^id(id obj) { return @([obj floatValue]/100.); }];
//
//
//	self.textLayer = [CATXTL layerWithFrame:AZLeftEdge(layer.bounds, 300)];
//	[_textLayer bind:@"string" toObject:self withKeyPath:@"inString" options:nil];
//#ifdef INJECTION_ENABLED
//	_textLayer.bgC = [INColors[0]CGColor];
//#endif
//	[layer addSublayer:_textLayer];




//- (id) forwardingTargetForSelector:(SEL)aSelector
//- (id) valueForUndefinedKey:(NSString*)k {  NSLog(@"was asked for: %@", k);
//}
//+ (BOOL) resolveClassMethod:(SEL)sel { NSString *ssel; NSLog(@"Resolving method:%@", ssel = NSStringFromSelector(sel).lowercaseString);
//
//
//	if ([ssel rangeOfString:@"view"].location != NSNotFound) {
//		static NSA* subClasses = nil;  subClasses = subClasses ?: NSView.subclasses;
//
//		Class k = [subClasses filterOne:^BOOL(id object) {
//				return [NSStringFromClass(object).lowercaseString containsString:ssel];
//		}];
//		NSLog(@"found class.. %@", NSStringFromClass(k));
//		if (k && [k instancesRespondToSelector:@selector(initWithFrame:)]) {
//			NSView *v; [nibless.view addSubview:v = [[k alloc] initWithFrame:nibless.view.bounds]];
//			v.autoresizingMask = NSSIZEABLE;
//			objc_setAssociatedObject(nibless, sel, v, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//			XX(objc_getAssociatedObject(nibless, sel));
//			BOOL ok =	class_addMethod(self.class,sel,imp_implementationWithBlock(^NSView*(id self){ return objc_getAssociatedObject(nibless, sel); }),method_getTypeEncoding(class_getInstanceMethod(NSV.class,NSSelectorFromString(@"self"))));
//			XX(ok);
//			return ok;
//		} else return XX(@"instances dont respond"), NO;
//	}
//	else return [super resolveClassMethod:sel];
//}

//return [self respondsToSelector:sel] || [self instancesRespondToSelector:sel]; }


/**
- (void) fun {

	[InjectionExtras injectorForProject: @"SansNib" inWindow:_window];

	[NSEVENTLOCALMASK:NSLeftMouseUpMask handler:^NSEvent *(NSEvent *e) {
		CAL* newL; //		[self someMethodCallingSomeVerboseFunction];
		[self.view.zLayer blinkLayerWithColor:RANDOMCOLOR];
		[self.view.zLayer addSublayer: newL = [CAL layerWithFrame:AZRandomRectInRect(self.view.bounds)]];//NewLayerWithFrame(AZRandomRectinRect(kRect));
		newL.contents =  [NSIMG.randomMonoIcon coloredWithColor:RANDOMCOLOR];
		[self gradient];
		[AZSHAREDAPP activateIgnoringOtherApps:YES];
		return e;
	}];
	[self gradient];
	[AZSHAREDAPP activateIgnoringOtherApps:YES];
}
//	OBSERVE(NSApplicationDidBecomeActiveNotification, XX(AZPROCINFO.arguments[0]); );

//	CALayer*l = [CAL layerWithFrame:AZLeftEdge(layer.bounds,.3333*layer.boundsWidth)], *r= [CAL layerWithFrame:AZRightEdge(layer.bounds,.3333*layer.boundsWidth)],*c= [CAL layerWithFrame:AZRectExceptOriginX(AZLeftEdge(layer.bounds,.3333*layer.boundsWidth),.3333*layer.boundsWidth)];
//	l.arMASK = r.arMASK = c.arMASK = CASIZEABLE;
//	l.bgC = cgBLUE;
//	r.bgC = cgYELLOW;
//	c.bgC = [YELLOW blendedColorWithFraction:.5 ofColor:BLUE].CGColor;
//	[layer addSublayers:@[l, r, c]];

//	XX(bar);
//	[bar addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxX relativeTo:@"superlayer" attribute:kCAConstraintMaxX]];

//	, AZConstRelSuperScaleOff(kCAConstraintHeight, .2, 0)];

//	bar.bgC = cgYELLOW;

- (void) gradient {  	CAL *layer = self.view.zLayer; NSA* grad = [NSC gradientPalletteLooping:RANDOMPAL steps:100];




	//	[bubble observeTarget:layer keyPath:@"backgroundNSColor" options:nil block:^(MAKVONotification *notification) {

	//			XX(notification);
	//	[CABlockDelegate delegateFor:bubble ofType:CABlockTypeKVOChange withBlock:^(CAL* l,NSS* k){

	//	}];


}

//	[self.gradient eachWithIndex:^(id obj, NSInteger idx) {	CAL *swatch;
//		[bar addSublayer:swatch = CAL.new];
//		[swatch addConstraintsSuperSize];
//		[swatch addConstraints:@[AZConstRelSuperScaleOff(kCAConstraintWidth,.01,0), AZConstAttrRelNameAttrScaleOff(kCAConstraintMinX,@"superlayer", kCAConstraintWidth, idx/100.0,0)]];
//		swatch.bgC = [obj CGColor];
//		swatch.actions = @{ @"position":AZNULL, @"bounds":AZNULL};
//	}];



//- (NSScrollView*) scrlView {
//
//	[self.window.contentView addSubview:_scrlView = [NSScrollView.alloc initWithFrame:_window.contentRect]];
//	_scrlView.documentView				= _txtView	= [NSTextView.alloc initWithFrame:_window.contentRect];
//	_scrlView.hasHorizontalRuler  = _scrlView.hasVerticalScroller = _scrlView.rulersVisible	= YES;
//	[_window makeFirstResponder:_txtView];
//	_txtView.font									= AtoZ.controlFont;
//	[_txtView insertText:NSS.dicksonBible];
//	_scrlView.arMASK = _txtView.arMASK = NSSIZEABLE;
//	return _scrlView;
//}

@end


//int main(int argc, char *argv[]){ @autoreleasepool {	AZSHAREDAPP;
//
//		[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
//		[NSApp setMainMenu:[NSMenu.alloc initWithTitle: @""]];
//
//		SansNib *sansNib = SansNib.new;
//
//		[NSApp activateIgnoringOtherApps:YES];
//		[NSApp run];
//	}
//	return 0;
//}

// ***** Parse XML btn ***** //
//	NSButton *parseXMLBtn = [[NSButton alloc]
//													 initWithFrame:NSMakeRect( 130, 30, 120, 30 )];
//	[parseXMLBtn setBezelStyle:NSRoundedBezelStyle ];
//	[parseXMLBtn setTitle: @"Parse XML..." ];
//	[parseXMLBtn setTarget:sansNib];
//	[parseXMLBtn setAction:@selector(parseXML:)];
//	[[window contentView] addSubview: parseXMLBtn];
//	[parseXMLBtn release];
//
//	// ***** Print btn ***** //
//	NSButton *printBtn = [[NSButton alloc]
//												initWithFrame:NSMakeRect( 250, 30, 100, 30 )];
//	[printBtn setBezelStyle:NSRoundedBezelStyle ];
//	[printBtn setTitle: @"Print" ];
//	[printBtn setTarget:sansNib];
//	[printBtn setAction:@selector(printView:)];
//	[[window contentView] addSubview: printBtn];
//	[printBtn release];
//
//	// ***** Open btn ***** //
//	NSButton *openBtn = [[NSButton alloc]
//											 initWithFrame:NSMakeRect( 350, 30, 100, 30 )];
//	[openBtn setBezelStyle:NSRoundedBezelStyle ];
//	[openBtn setTitle: @"Open..." ];
//	[openBtn setTarget:sansNib];
//	[openBtn setAction:@selector(openFile:)];
//	[[window contentView] addSubview: openBtn];
//	[openBtn release];
//
//	// ***** Save btn ***** //
//	NSButton *saveBtn = [[NSButton alloc]
//											 initWithFrame:NSMakeRect( 450, 30, 100, 30 )];
//	[saveBtn setBezelStyle:NSRoundedBezelStyle ];
//	[saveBtn setTitle: @"Save" ];
//	[saveBtn setTarget:sansNib];
//	[saveBtn setAction:@selector(saveView:)];
//	[[window contentView] addSubview: saveBtn];
//	[saveBtn release];
//
//	// ***** Quit btn ***** //
//	NSButton *quitBtn = [[NSButton alloc]
//											 initWithFrame:NSMakeRect( _wndW - 130, 30, 95, 30 )];
//	[quitBtn setBezelStyle:NSRoundedBezelStyle ];
//	[quitBtn setTitle: @"Quit" ];
//	[quitBtn setAction:@selector(terminate:)];
//	[[window contentView] addSubview: quitBtn];
//	[quitBtn release];



*/
/*
 #define kRect NSInsetRect( [[NSScreen mainScreen]frame], 500, 300)
 #define kMask NSTitledWindowMask | NSResizableWindowMask | NSClosableWindowMask


 @interface SansNib : NSObject <NSApplicationDelegate>

 @property NSApplication	* app;
 @property    NSMenuItem * menuItem;
 @property				 NSMenu * menu,
 * mainMenu;
 @property					  NSW * window;
 @property					  NSV * view;


 @end


 int main(int argc, char *argv[]){ @autoreleasepool {

 NSApplication.sharedApplication.delegate = SansNib.new;

 } return 0; }

 @implementation SansNib

 - (id)init	{ self = super.init;


 _window		= [NSW.alloc initWithContentRect:kRect styleMask:kMask
 backing:NSBackingStoreBuffered defer:YES];
 _menu 	  = [NSMenu.alloc initWithProperties:@{ @"title" : @"Apple Menu" }];
 _menuItem = [NSMenuItem.alloc initWithTitle:@"menuItem" action:nil keyEquivalent:@""];
 _mainMenu = [NSMenu.alloc initWithTitle: @"mainMenu"];
 [_menu addItemWithTitle:@"Quit This Shit" action:@selector(terminate:) keyEquivalent:@"q"];
 [_menuItem setSubmenu:_menu];
 [_mainMenu addItem:_menuItem];
 [_app setMainMenu:_mainMenu];
 [NSApp performString:@"setAppleMenu:" withObject:_mainMenu];
 [_view	= _window.contentView zLayer].bgC = cgRED;
 [self.window makeKeyAndOrderFront:nil];
 [NSApp run];
 }

 //- (void)dealloc {
 //
 //    // don’t forget to release allocated objects!
 //    [@[_view, _window, _app, _menu]do:^(id obj) { [obj release]; }];
 //    [super dealloc];
 //}

 @end

 */
//- (void) animate
//{
//	@property (strong, nonatomic) DynamicView 	*dView;
//	@property (strong, nonatomic) DynamicLayer *dLayer;
//
//	CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"thickness"];
//	ba.toValue = [NSNumber numberWithFloat: 100.0];
//	ba.autoreverses = YES;
//	ba.duration = 10;
//	[_dView.root addAnimation:ba forKey:nil];
//}
//
//_dView 	= [[DynamicView alloc] 	initWithFrame:[_window.contentView frame]];
//_window.contentView = _dView;

//	NSDictionary *objDict = [_menu dictionaryWithValuesForKeys: [_menu allKeys]];
//	NSLog(@"%@", objDict); NSLog(@"%@", [_menu me ]) initWithTitle: @"Apple Menu"];
//	[app setmenu:menu];
//	[menuItem release];
//	[mainMenu release];
//	[menu release];
/*
 - (void) myLayerRoutine
 {
 _layer 	= [MyLayer   layer];
 [_layer setNeedsDisplay];
 //- (void)applicationWillFinishLaunching:(NSNotification *)notification {
 //	_layer.backgroundColor = cgBLUE;
 _view.layer 		= _layer;
 _view.wantsLayer 	= YES;
 // attach the view to the window
 _window.contentView	= _view;
 }
 */
//- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
//{
//	CGRect r = CGRectInset(_dView.bounds, 20, 20);
//    CGContextSetFillColorWithColor(ctx, cgORANGE);
//    CGContextFillRect(ctx, r);
//    CGContextSetLineWidth(ctx, _dView.root.thickness);
//    CGContextStrokeRect(ctx, r);
//}
//	_app				= [NSAPP sharedApplication];
//    return self;
//}

//- (void)applicationDidFinishLaunching:(NSNotification *)notification {


/*
 *		NiblessDevelopmentExample
 *		AppDelegate.m
 *		Revised by Casper B. Hansen on 9/7/10.
 *		Copyright 2010, Casper B. Hansen. All rights reserved.
 */

//#import "DynamicLayer.h"

//	_window.bgC = [BLUE alpha:.5];
//	[_window setContentView addSubview:_view = [NSView.alloc initWithFrame:_window.contentRect]];

/*	_view 		= [BLKVIEW viewWithFrame:kRect opaque:YES drawnUsingBlock: ^(BLKVIEW *v, NSR dirty) {
 v.arMASK     = NSSIZEABLE;
 [[NSBP bezierPathWithRect:kRect] drawWithFill:[BLUE alpha:.5] andStroke:BLACK];   }];
 */

//	_root	= _view.zLayer;//  setupHostView;
//		_root = _view.zLayer;

/*
 - (void)preferencesMenuHandler:(id)sender	{
 // For demo only
 NSBeep();
 [txtView setString:@"\nYou just clicked the Preferences menu."];
 }


 - (void)helpMenuOne:(id)sender
 {
 // For demo only
 NSBeep();
 [txtView setString:@"\nYou just clicked the Help Menu's first item."];
 }

 - (void)helpMenuTwo:(id)sender
 {
 // For demo only
 NSBeep();
 [txtView setString:@"\nYou just clicked the Help Menu's second item."];
 NSBeep();
 }


 - (void)saveView:(id)sender
 {

 NSSavePanel *sp = [NSSavePanel savePanel];
 [sp setTitle:@"Save TextView contents to file"];
 [sp setAllowedFileTypes:[NSArray arrayWithObject:@"txt"]];
 [sp setCanSelectHiddenExtension:YES];
 [sp setAllowsOtherFileTypes:YES];
 [sp setCanCreateDirectories:YES];

 [sp beginSheetModalForWindow:txtView.window completionHandler:^(NSInteger result) {
 //		NSInteger panelResult = [sp runModalForDirectory file:<#(NSString *)#> :nil file:@"Untitled.txt"];
 if ( result != NSFileHandlingPanelOKButton ) return;
 [txtView.textStorage.string writeToURL:sp.URL atomically:YES encoding:NSUTF8StringEncoding error:NULL];
 }];
 }

 - (void)openFile:(id)sender
 {
 NSOpenPanel *op = [NSOpenPanel openPanel];
 [op setTitle:@"Open generic text file"];
 [op setCanChooseFiles:YES];
 [op setCanChooseDirectories:NO];
 [op setAllowsMultipleSelection: NO];
 [op setAllowedFileTypes:[NSArray arrayWithObject:@"txt"]];

 if ( [op runModal] == NSOKButton )
 {
 NSURL *url = [op URL];
 NSString *fileStr = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
 [txtView setString:fileStr];
 [fileStr release];
 }
 else
 {
 // User cancelled
 }
 }

 - (void)parseXML:(id)sender
 {
 NSXMLDocument *xmlDoc;
 NSError *err = nil;
 // Get NSURL for http://www.w3schools.com/xml/plant_catalog.xml
 NSString *urlString = [@"http://www.w3schools.com/xml/plant_catalog.xml" stringByExpandingTildeInPath];
 [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 NSURL *url = [NSURL URLWithString:urlString];

 // Build NSXMLDocument from NSURL
 xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:url options:NSXMLDocumentTidyXML error:&err];
 // Identify XML root element
 NSXMLElement *rootElement = [xmlDoc rootElement];
 // Determine total number of nodes-- in this case for "PLANT" nodes
 NSUInteger totalElements = [[rootElement nodesForXPath:@"//CATALOG/PLANT" error:&err] count];
 // Build Xpath command string adding 1 to totalElements
 NSString *XpathCmdStr = [NSString stringWithFormat:@"%@%ld%@", @"/CATALOG/PLANT[position()<", totalElements + 1, @"]" ];
 */	/*
		 Build array of "PLANT" nodes using Xpath command string
		 Done manuually, the completed instruction would look like this:
		 NSArray *nodes = [xmlDoc nodesForXPath:@"/CATALOG/PLANT[position()<37]" error:&err];
		 */
/*
 NSArray *nodes = [xmlDoc nodesForXPath:XpathCmdStr error:&err];

 NSMutableString *xmlTreeStr = [[[NSMutableString alloc] init] autorelease];
 NSXMLElement *thisUser;

 int i = 1;
 for (  i = 0; i < [nodes count]; i++) {

 thisUser = [nodes objectAtIndex:i];

 [xmlTreeStr appendString:@"\nCommon Name: "];
 [xmlTreeStr appendString:[[thisUser childAtIndex:0 ] stringValue]];

 [xmlTreeStr appendString:@"\nBotanical Name: "];
 [xmlTreeStr appendString:[[thisUser childAtIndex:1 ] stringValue]];

 [xmlTreeStr appendString:@"\nZone: "];
 [xmlTreeStr appendString:[[thisUser childAtIndex:2 ] stringValue]];

 [xmlTreeStr appendString:@"\nNeeded Light: "];
 [xmlTreeStr appendString:[[thisUser childAtIndex:3 ] stringValue]];

 [xmlTreeStr appendString:@"\nPrice: "];
 [xmlTreeStr appendString:[[thisUser childAtIndex:4 ] stringValue]];

 [xmlTreeStr appendString:@"\nAvailability: "];
 [xmlTreeStr appendString:[[thisUser childAtIndex:5 ] stringValue]];

 [xmlTreeStr appendString:@"\n\n"];

 }
 // Set the resulting string into the TextView
 [txtView setString:xmlTreeStr];
 [xmlDoc release];
 }
 */ //interface

/*

 NSApplication still responds to setAppleMenu method, but for some reason
 -- probably because Xcode applications are expected to be xib-based-- the
 setAppleMenu method been omitted from Apple header files and documentation.

 This declaration fixes that in a way similar to adding a Toolbox function
 in FB.

 */
//@interface NSApplication(NiblessAdditions)
//- (void)setAppleMenu:(NSMenu *)menu;
//@end

//		[fileMenu addItem:openMenuItem];
//		ADDSEPERATOR(fileMenu);
//		NSMenuItem* parseXMLMenuItem = [MENUITEMALLOC initWithTitle:@"Parse XML..." action:@selector(parseXML:) keyEquivalent:@"g"];
//		[parseXMLMenuItem setEnabled:YES];
//		[parseXMLMenuItem setTarget:sansNib];
//		[fileMenu addItem:parseXMLMenuItem];
//		ADDSEPERATOR(fileMenu);
//		[fileMenu addItem:saveMenuItem];
// Menu separator
//		ADDSEPERATOR(fileMenu);
//		NSMenuItem* printMenuItem = [MENUITEMALLOC initWithTitle:@"Print" action:@selector(printView:) keyEquivalent:@"p"];
//		[printMenuItem setEnabled:YES];
//		[printMenuItem setTarget:sansNib];
//		[fileMenu addItem:printMenuItem];
//static int myOwnWriter( void *inFD, const char *buffer, int size)
//{
//	[SansNib.shared.textLayer setString:[NSString.alloc initWithBytes:buffer length:size encoding:NSUTF8StringEncoding]];
//	return size;
//}
//- (void)someMethodCallingSomeVerboseFunction
//{
//	File_Writer_t *originalFW = stderr->_write ;
//	stderr->_write = &myOwnWriter ;
//	printf("what a beautiful day! %s", $(@"%@",NSDate.date).UTF8String);
////	someRoutineWhichUsesFprinf( arg1, verbosity );
////	stderr->_write = originalFW ;
//}

//typedef void(^stringAction)(NSString*string);
//
//typedef int File_Writer_t(void *, const char *, int);


//#ifdef DEBUG
//static char _inMainFilePath[] = __FILE__;
//static const char *_inIPAddresses[] = {"127.0.0.1", "10.0.1.100", NULL};
//#define INJECTION_ENABLED
//#import "/Users/localadmin/Library/Application Support/Developer/Shared/Xcode/Plug-ins/InjectionPlugin.xcplugin/Contents/Resources/BundleInjection.h"
//#endif


//- (void) sendEvent:(NSEvent*)e { if (e.type == NSLeftMouseUp) {
//
//    CALayer *l = [SansNib.view.superview.layer hitTest:e.locationInWindow];
////    XX(l.uuid);
//    vBlock b = [l vFK:@"theBlock"];//buttons[l.uuid];
//    XX([b blockDescription]);
//    if (b) b();
//
//  }
////  id x = objc_getAssociatedObject(self, AZSELSTR.UTF8String);
////  XX(x);
////  if (!x) objc_setAssociatedObject(self,AZSELSTR.UTF8String, NSS.randomDicksonism, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
////  XX([self description]);associatedValueForKey:"popp" orSetTo:NSS.randomDicksonism]);
////  XX([self uuid]);
//  [super sendEvent:e]; }
