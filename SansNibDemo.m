
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
//#import <AtoZ/AtoZ.h>
#import <SansNib/SansNib.h>


static void __attribute__ ((constructor)) setProjectName(void) { setenv("PROJECT_NAME", "SansNib", 0); }

int main(int argc, char *argv[]){

//  [SansNib sansNib];
  [SansNib titleBarButton:[NSImage imageNamed:NSImageNameAddTemplate] action:^{ [SansNib split]; }];
  [SansNib titleBarButton:[NSImage imageNamed: NSImageNameColorPanel] action:^{

    [SansNib tableForArray:[NSWorkspace.sharedWorkspace.runningApplications valueForKey:@"localizedName"]]; }];

	[SansNib tableForArray:@[@"alpha", @"ebeta"]];

	[SansNib run];
	return 0;
}

//	[NSThread performBlock:^{
//	} afterDelay:5];
//	[SansNib tableForArray:NSIMG.monoIcons];
//	id x = [SansNib performSelector:NSSelectorFromString(@"simpleView")];
//	XX(x);  XX(NSStringFromClass([x class]));
//	[SansNib]
// From here to end of file added by Injection Plugin //

//#ifdef DEBUG
//static char _inMainFilePath[] = __FILE__;
//static const char *_inIPAddresses[] = {"127.0.0.1", "10.0.1.100", NULL};
//
//#define INJECTION_ENABLED
//#import "/Users/localadmin/Library/Application Support/Developer/Shared/Xcode/Plug-ins/InjectionPlugin.xcplugin/Contents/Resources/BundleInjection.h"
//#endif
