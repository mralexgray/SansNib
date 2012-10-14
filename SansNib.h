/*
 *		NiblessDevelopmentExample
 *		AppDelegate.h
 *		Created by Casper B. Hansen on 9/7/10.
 *		Revised by Casper B. Hansen on 9/7/10.
 *		Copyright 2010, Casper B. Hansen. All rights reserved.
 *
 */
#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import <AtoZ/AtoZ.h>

#define aRect 		 NSInsetRect( [[NSScreen mainScreen]frame], 500, 300)
#define standardMask NSTitledWindowMask | NSResizableWindowMask | NSClosableWindowMask

@interface SansNib : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) NSWindow  *window;
@property (strong, nonatomic) NSView    *view;
@property (strong, nonatomic) CALayer  	*layer;

@end

