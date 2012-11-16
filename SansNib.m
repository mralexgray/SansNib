/*
 *		NiblessDevelopmentExample
 *		AppDelegate.m
 *		Revised by Casper B. Hansen on 9/7/10.
 *		Copyright 2010, Casper B. Hansen. All rights reserved.
 */


#import "SansNib.h"
//#import "DynamicLayer.h"

@interface SansNib ()

@property (strong, nonatomic) NSApplication	*app;
@property (strong, nonatomic) NSMenuItem 	*menuItem;
@property (strong, nonatomic) NSMenu 		*menu,
											*mainMenu;
@end

@implementation SansNib

- (id)init
{
	if (!(self 	= [super  init])) return nil  ;
	_app 		= [NSAPP  sharedApplication ] ;
	_window 	= [[ NSW  alloc] initWithContentRect: kRect styleMask:kMask backing:NSBackingStoreBuffered defer:YES];
	_view 		= [BLKVIEW viewWithFrame:kRect opaque:YES drawnUsingBlock: ^(BLKVIEW *v, NSR dirty) {
				v.arMASK = NSSIZEABLE;
				  [[NSBP bezierPathWithRect:kRect] drawWithFill:[BLUE alpha:.5] andStroke:BLACK];   }];
	_root   	= [_view  setupHostView		] ;
				  [_root  setBackgroundColor  : [RED alpha:.5].CGColor];
	_window		.         contentView = _view ;
	[NSEVENTLOCALMASK:NSLeftMouseUpMask handler:^NSEvent *(NSEvent *e) {
//		CGF now= _layer.currentProgress; _layer.currentProgress = now + 20;
		[NSIV addImageViewWithImage:[[[NSIMG monoIcons]randomElement]coloredWithColor:RANDOMCOLOR]toView:_view];
		[_root blinkLayerWithColor:RANDOMCOLOR];  return e;
	}];
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	
	_menu 	  = [[NSMenu alloc] initWithProperties:@{ @"title" : @"Apple Menu" }];
	_menuItem = [[NSMenuItem alloc] initWithTitle:@"" action:nil keyEquivalent:@""];
	_mainMenu = [[NSMenu alloc] initWithTitle: @""];
	[_menu addItemWithTitle:@"Quit This Shit" action:@selector(terminate:) keyEquivalent:@"q"];
	[_menuItem setSubmenu:_menu];
	[_mainMenu addItem:_menuItem];
	[_app setMainMenu:_mainMenu];
	[NSAPP performString:@"setAppleMenu:" withObject:_mainMenu];	
	[_window makeKeyAndOrderFront:self];
}
- (void)dealloc {
	
    // don’t forget to release allocated objects!
    [@[_view, _window, _app, _menu]do:^(id obj) { [obj release]; }];
    [super dealloc];
}

@end


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