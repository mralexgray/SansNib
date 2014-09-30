//
//  JJApplication.m
//  NiblessLeopard
//
//  Created by Jeffrey Johnson on 11/22/07.
//  Copyright 2007 Lap Cat Software. All rights reserved.
//

#import "JJApplication.h"
#import "JJMenuPopulator.h"

@implementation JJApplicationDelegate

#pragma mark NSApplication delegate

-(void) applicationWillFinishLaunching:(NSNotification *)aNotification
{
	[JJMenuPopulator populateMainMenu];
	
	[[NSDocumentController sharedDocumentController] noteNewRecentDocumentURL:[NSURL fileURLWithPath:@"/Developer/About Xcode Tools.pdf"]];
}

-(void) applicationWillTerminate:(NSNotification *)aNotification
{
	[NSApp setDelegate:nil];
}

@end



@implementation JJApplication

#pragma mark NSObject

-(id) init
{
	self = [super init];
	if (self != nil)
	{
		[self setDelegate:(id)JJApplicationDelegate.new];
	}
	return self;
}

@end



#import <objc/runtime.h>
#import "NSBundleJJAdditions.h"

int main(int argc, char *argv[], char**argp ){	@autoreleasepool {

      Class bundleClass = [NSBundle class];
      Method originalMethod = class_getClassMethod(bundleClass, @selector(loadNibNamed:owner:));
      Method categoryMethod = class_getClassMethod(bundleClass, @selector(JJ_loadNibNamed:owner:));
      method_exchangeImplementations(originalMethod, categoryMethod);

  }
  return NSApplicationMain(argc, (const char **)argv) ?: EXIT_SUCCESS;
}



NSAPp