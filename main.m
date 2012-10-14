/*
 *		NiblessDevelopmentExample
 *		main.m
 *		
 *		Revised by Casper B. Hansen on 9/7/10.
 *		
 *		Copyright 2010, Casper B. Hansen. All rights reserved.
 *
 */


#import <Cocoa/Cocoa.h>
#import "SansNib.h"

int main(int argc, char *argv[])
{
    // create an autorelease pool
//    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	@autoreleasepool {

		// make sure the application singleton has been instantiated
		NSApplication * application = [NSApplication sharedApplication];
		
		// instantiate our application delegate
		SansNib * applicationDelegate = [[SansNib alloc] init];// autorelease];
		[application setDelegate:(id)applicationDelegate];				// assign our delegate to the NSApplication

		
		// call the run method of our application
		[application run];
	
    // drain the autorelease pool
	}
//    [pool drain];

    // execution never gets here ..
    return 0;
}