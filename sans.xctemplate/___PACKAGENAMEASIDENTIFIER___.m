//
//  ___FILENAME___
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//___COPYRIGHT___
//

#import "___FILEBASENAMEASIDENTIFIER___.h"

@implementation ___FILEBASENAMEASIDENTIFIER___
CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(___FILEBASENAMEASIDENTIFIER___);// Create easy singleton. Thanks http://cocoawithlove.com/2008/11/singletons-appdelegates-and-top-level.html
+ (void)load {
  ___FILEBASENAMEASIDENTIFIER___ *controller = [___FILEBASENAMEASIDENTIFIER___ sharedController];
  [controller swizzle];
}

- (void)swizzle {
  
}
@end
