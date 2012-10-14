/*
 *		NiblessDevelopmentExample
 *		AppDelegate.m
 *		
 *		Revised by Casper B. Hansen on 9/7/10.
 *		
 *		Copyright 2010, Casper B. Hansen. All rights reserved.
 *
 */


#import "SansNib.h"

@interface SansNib ()
@property (strong, nonatomic) NSApplication	*app;
@property (strong, nonatomic) NSMenu 		*menu, *mainMenu;
@end

@implementation SansNib
//@synthesize window, view, menu, app;

- (id)init {
	
    if ( self = [super init] ) {

		_layer 	= [CALayer   layer];
		_app 	= [NSApplication sharedApplication];
        _view 	= [[NSView 	 alloc] initWithFrame:aRect];
        _window = [[NSWindow alloc] initWithContentRect:aRect
											  styleMask:standardMask
												backing:NSBackingStoreBuffered
												  defer:YES];
	}
    return self;
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {

	_layer.backgroundColor = cgBLUE;
	_view.layer 		= _layer;
	_view.wantsLayer 	= YES;

    // attach the view to the window
	_window.contentView	= _view;

}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	
	_menu = [[NSMenu alloc] initWithProperties:@{@"title":@"Apple Menu"}];
	NSDictionary *objDict = [_menu dictionaryWithValuesForKeys: [_menu allKeys]];
	NSLog(@"%@", objDict);
	NSLog(@"%@", [_menu me ])
//								 initWithTitle: @"Apple Menu"];
	[_menu addItemWithTitle:@"Quit This Shit" action:@selector(terminate:) keyEquivalent:@"q"];
	NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:@"" action:nil keyEquivalent:@""];
	NSMenu *mainMenu = [[NSMenu alloc] initWithTitle: @""];
	[menuItem setSubmenu:_menu];
	[mainMenu addItem:menuItem];
	[_app setMainMenu:mainMenu];
//	[app setmenu:menu];
//	[menuItem release];
//	[mainMenu release];
//	[menu release];
	[_window makeKeyAndOrderFront:self];
}
- (void)dealloc {
	
    // don’t forget to release allocated objects!
    [@[_view, _window, _app, _menu]do:^(id obj) { [obj release]; }];
    [super dealloc];
}

@end