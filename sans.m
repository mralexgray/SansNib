

#import "sans.h"

#define SPLIT_CONTAINS(SPLIT,X) [[@#SPLIT componentsSeparatedByString:@"|"]containsObject:X]


@interface SansFactory : NSObject <NSApplicationDelegate,Sans> @end

//typedef Sans* _; + (_) sans; + (_Void) run; @end

#define BUNDLEDIR @"~/Library/Bundles".stringByStandardizingPath

id<Sans> Sans() { return [SansFactory sans]; }

@implementation SansFactory
{
 _Menu aboutM, fileM, editM, helpM, servicesM;
_SubM aboutSubM, fileSubM, editSubM, helpSubM, aboutAppSubM, openSubM, helpSubM1, preferencesSubM, saveSubM, servicesSubM, hideSubM, hideOthersSubM, showAllSubM, quitSubM;
}
@synthesize plugins, handlers, buttons, window, layer, view;
//{
//
// XList plugins, handlers, buttons; _Main window; _Lens layer; _View view; _Menu aboutM, fileM, editM, helpM, servicesM;
//_SubM aboutSubM, fileSubM, editSubM, helpSubM, aboutAppSubM, openSubM, helpSubM1, preferencesSubM, saveSubM, servicesSubM, hideSubM, hideOthersSubM, showAllSubM, quitSubM;

//}
  static SansFactory* sans; /** static singleton rules this house */

- (XList) plugins { return plugins = plugins ?: ({

    [plugins = NSArrayController.new setContent:@[].mutableCopy];

    for (_Text p in [_FILEM contentsOfDirectoryAtPath:BUNDLEDIR error:nil]) {  _Bndl b; _Errr e; BOOL x;

      [p hasSuffix:@"sans"] && (b = [NSBundle bundleWithPath:[BUNDLEDIR stringByAppendingPathComponent:p]])
        ? (x = [b preflightAndReturnError:&e]) && !e   ? [plugins addObject:b]
        : NSLog(@"Problem preflighting %@.. %@", p, e) : nil;
    }
    NSLog(@"SansNib plugins:%lu [%@]", [plugins.arrangedObjects count], [[plugins.arrangedObjects valueForKeyPath:@"principalClass"]componentsJoinedByString:@","]);

  plugins; });

}
+ (_Kind) sans { return sans = sans ?: ({  _NSAPP, DISPATCHONCE([NSApp setMainMenu:_MENU_NAMED(@"")]; sans = super.alloc; sans = [sans _init];), SETPOLICY, sans; }); }

- _init {  return self = super.init && self == sans ? ({ _NSAPP.

    mainMenu.itemArray = @[  aboutSubM = _SUBM_NAMED(NULL,        placehoder, nil, aboutM = _MENU_NAMED(About Sans)),
                              fileSubM = _SUBM_NAMED(File,        placehoder, nil,  fileM = _MENU_NAMED(Work It!)),
                              editSubM = _SUBM_NAMED(Edit,        placehoder, nil,  editM = _MENU_NAMED(Twerk It!)),
                              helpSubM = _SUBM_NAMED(Help,        placehoder, nil,  helpM = _MENU_NAMED(Hates It!)) ];
  aboutM.itemArray = @[   aboutAppSubM = MENUITEMACTION(ABOUT_,                       nil, NULL         /* self.aMenu*/), _MENU_DIV,
                       preferencesSubM = MENUITEMACTION(Beep!, @",", ^(NSMenuItem* item){ NSBeep();                              /* [AZTalker say:@"Preferences"]; */ }), _MENU_DIV,
                          servicesSubM = _SUBM_NAMED(Services,    placehoder,             nil, nil),    _MENU_DIV,
                              hideSubM = _SUBM_NAMED(Hide,        hide:,                  nil, nil),
                        hideOthersSubM = _SUBM_NAMED(Hide Others, hideOtherApplications:, nil,  nil),
                           showAllSubM = _SUBM_NAMED(Show All,    unhideAllApplications:, nil,  nil),   _MENU_DIV,
                              quitSubM = _SUBM_NAMED(Quit,          terminate:,           @"q", nil)];
  fileM.itemArray = @[        openSubM = _SUBM_NAMED(Open...,       openFile:,            @"o", nil),   _MENU_DIV,
                              saveSubM = MENUITEMACTION(Save, @"s",^(NSMenuItem*m){ /* [AZTalker say:[m.title withString:@" not implemented"]]; */ }) ];
  editM.itemArray = @[                   _SUBM_NAMED(Cut,          cut:,            @"x", nil),
                                         _SUBM_NAMED(Copy,         copy:,           @"c", nil),
                                         _SUBM_NAMED(Paste,        paste:,          @"v", nil),
                                         _SUBM_NAMED(Select All,   selectAll:,      @"a", nil) ];
  helpM.itemArray = @[       helpSubM1 = _SUBM_NAMED(Help!,        placehoder,      @"h", nil) ];

  [@[hideSubM, hideOthersSubM, showAllSubM, quitSubM] makeObjectsPerformSelector:@selector(setTarget:) withObject:NSApp];
  [NSApp setServicesMenu:servicesSubM.submenu = servicesM = _MENU_NAMED(Services)]; [NSApp setHelpMenu:helpM];
  [handlers = NSArrayController.new setContent:@[].mutableCopy];
  [buttons  = NSArrayController.new setContent:@[].mutableCopy]; window = [objc_getClass("SansNibWindow") new];

  for (_Bndl b in self.plugins.arrangedObjects) { id x;
      [fileM addItem:x = [[NSMenuItem _ALLOCMENUZONE] initWithTitle:b.bundleIdentifier action:@selector(GO) keyEquivalent:@""]];
    [x setTarget:[b principalClass]];
  }
  [_NCNTR addObserverForName:NSApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue
                  usingBlock:^(NSNotification *x) { setCuteIcon(); }];
                  [NSApp setDelegate:(id)self]; sans; }) : nil;
}

- forwardingTargetForSelector:(SEL)s { _Text x = NSStringFromSelector(s); return

  SPLIT_CONTAINS(addButton:block:,             x) ? objc_getClass("SansNibWindowButton") :
  SPLIT_CONTAINS(addTableWith:|addWebviewWith:,x) ? self.view.subviews.lastObject ?: self.view : // was  lastSplitPane
//  SPLIT_CONTAINS(handlers|buttons|window,      x) ? self.sans :
//  SPLIT_CONTAINS(hitLayer|layer|view,          x) ? self.sans.window :
  [super forwardingTargetForSelector:s];
}

- (_Void) run                         { [[self window] orderFrontRegardless]; [NSApp run]; }

- (BOOL)applicationShouldHandleReopen:(NSApplication*)a hasVisibleWindows:(BOOL)f { setCuteIcon(); [self window]; }

- (void(^)(NSMenuItem*)) aMenu {

 return // (void(^)(NSMenuItem*))
        ^(NSMenuItem*menu){ [_NSAPP orderFrontStandardAboutPanelWithOptions:

@{@"Credits": @"c/o Steve Van Voorst via fbcocoa list\nvia Bernie Wylde / Ken Shmidheiser.",
  @"ApplicationName":@"AtoZ Nibless Demo",
  @"Version": @"0.1 alpha for list", @"Copyright":@"Copyright 2012",
  @"ApplicationIcon": [NSImage imageNamed:NSImageNameAddTemplate],
  @"ApplicationVersion":@"N/A"}];
};

//    [SHAREDAPP orderFrontStandardAboutPanelWithOptions: @{@"Credits": [@"c/o Steve Van Voorst via fbcocoa list\nvia Bernie Wylde / Ken Shmidheiser."  attributedWithFont:AtoZ.controlFont andColor:RED] ?: @"", @"ApplicationName":@"AtoZ Nibless Demo",   @"Version":@"0.1 alpha for list", @"Copyright":@"Copyright 2012", @"ApplicationIcon": [NSImage imageNamed:@"atoz"]?:[NSImage imageNamed:NSImageNameUser], @"ApplicationVersion":AZFWORKBUNDLE.infoDictionary[@"CFBundleVersion"]?:@"v.N/A"}]; };

//  };
}

-            addViewWithClass:(_Meta)k { _View v; return [self addViewWithSplit:v = k.new], v; }

- (_Void) addViewWithSplit:(_View)v { _Splt s = [self.view.subviews.lastObject split];

  _View t = s.subviews[1]; v.frame = t.bounds; [t removeFromSuperview]; [s addSubview:v];
}
- (_Void) setDockIcon:(_Pict)i      { NSImageView *iv;

  sans_DOCK_TILE.contentView  = iv = [NSImageView.alloc initWithFrame:(NSRect){0,0,512,512}];
  iv.imageScaling             = NSImageScaleProportionallyUpOrDown;
  iv.image                    = i;   [sans_DOCK_TILE display];
}
- (_Splt) split                     {  _View v = self.view;  return v.subviews.lastObject ?: ({ NSBox*halve;

    [v addSubview:halve = [NSBox.alloc initWithFrame:v.bounds]];
    [halve setFillColor:NSColor.blueColor];
    [halve setAutoresizingMask:v.autoresizingMask];  halve; }).split;
}
@end

void setCuteIcon(void){ NSLog(@"seeting cute icon",nil); NSRect r; NSImage * i; NSMutableParagraphStyle *s;

  (s = NSParagraphStyle.defaultParagraphStyle.mutableCopy).alignment = NSCenterTextAlignment;
  [NSGraphicsContext saveGraphicsState];
  [Sans() setDockIcon:({ [i = [NSImage.alloc initWithSize:(r = (NSRect){0,0,256,256}).size]lockFocus];
  [sans_RANDOMCOLOR set]; NSRectFill(r);
  [[NSProcessInfo.processInfo.processName.uppercaseString substringToIndex:1] ?: @"A"
      drawAtPoint:NSZeroPoint                               withAttributes:@{
     NSForegroundColorAttributeName : sans_RANDOMCOLOR,
         NSStrokeWidthAttributeName : @(-3),
         NSStrokeColorAttributeName : NSColor.whiteColor,
                NSFontAttributeName : [NSFont fontWithName:@"Ultramagnetic" size:500]}];
    [i unlockFocus]; [NSGraphicsContext restoreGraphicsState]; i;
  })];
}
@implementation  NSObject (Sans)
- (id<Sans>)sans { return [SansFactory sans]; }
@end

//+          (void) addEventBlock:(EventBlock)blk { [SANSNIB setValue:[SANSNIB.eventBlocks ?: @[] arrayByAddingObject:[blk copy]] forKey:@"eventBlocks"]; }


/*
// NSShadowAttributeName : [NSShadow shadowWithBlurRadius:20 offset:(NSSize){-20,-20}],                     NSParagraphStyleAttributeName : s,

- (void)windowDidMove:(NSNotification*)n {

    if (self.window.isVisible == true) {
        NSWindow *theWindow = n.object;
        id edgeObject;
        NSArray *frames = [[NSApp windows] arrayByAddingObjectsFromArray:NSScreen.screens];
        BOOL hDidChange = NO, vDidChange = NO;
        float gravity = 46.0;

        NSRect frame, myFrame = [theWindow frame];
        NSEnumerator *e = frames.objectEnumerator;
        if ([[NSApp currentEvent] modifierFlags] & NSAlternateKeyMask) return;

        while (edgeObject = [e nextObject]) {
            if ((edgeObject != theWindow && ([edgeObject respondsToSelector:@selector(isVisible)] && [edgeObject isVisible])) || [edgeObject isKindOfClass:[NSScreen class]]) {
                frame = [edgeObject frame];

                // horizontal magnet /
                if (!hDidChange && fabs(NSMinX(frame) - NSMinX(myFrame)) <= gravity) {
                    //NSLog(@"NSMinX(frame) - NSMinX(myFrame)");
                    myFrame.origin.x = frame.origin.x;
                    hDidChange = YES;
                } if (!hDidChange && fabs(NSMinX(frame) - NSMaxX(myFrame)) <= gravity) {
                    //NSLog(@"NSMinX(frame) - NSMaxX(myFrame)");
                    myFrame.origin.x += NSMinX(frame) - NSMaxX(myFrame);
                    hDidChange = YES;
                } if (!hDidChange && fabs(NSMaxX(frame) - NSMinX(myFrame)) <= gravity) {
                    //NSLog(@"NSMaxX(frame) - NSMinX(myFrame)");
                    myFrame.origin.x = NSMaxX(frame);
                    hDidChange = YES;
                } if (!hDidChange && fabs(NSMaxX(frame) - NSMaxX(myFrame)) <= gravity) {
                    //NSLog(@"NSMaxX(frame) - NSMaxX(myFrame)");
                    myFrame.origin.x += NSMaxX(frame) - NSMaxX(myFrame);
                    hDidChange = YES;
                }

                // vertical magnet /
                if (!vDidChange && fabs(NSMinY(frame) - NSMinY(myFrame)) <= gravity) {
                    //NSLog(@"NSMinY(frame) - NSMinY(myFrame)");
                    myFrame.origin.y = frame.origin.y;
                    vDidChange = YES;
                } if (!vDidChange && fabs(NSMinY(frame) - NSMaxY(myFrame)) <= gravity) {
                    //NSLog(@"NSMinY(frame) - NSMaxY(myFrame)");
                    myFrame.origin.y += NSMinY(frame) - NSMaxY(myFrame);
                    vDidChange = YES;
                } if (!vDidChange && fabs(NSMaxY(frame) - NSMinY(myFrame)) <= gravity) {
                    //NSLog(@"NSMaxY(frame) - NSMinY(myFrame)");
                    myFrame.origin.y = NSMaxY(frame);
                    vDidChange = YES;
                } if (!vDidChange && fabs(NSMaxY(frame) - NSMaxY(myFrame)) <= gravity) {
                    //NSLog(@"(NSMaxY(frame) - NSMaxY(myFrame)");
                    myFrame.origin.y += NSMaxY(frame) - NSMaxY(myFrame);
                    vDidChange = YES;
                }
            }
            [theWindow setFrame:myFrame display:YES];
        }
    }
}

#define PRIVATE(K,...) property (readonly) K __VA_ARGS__;

//@PRIVATE( _Main, window)  @PRIVATE( _Lens, layer) @PRIVATE( _View, view)
//
//@PRIVATE( _Menu, aboutM,          fileM,     editM,     helpM,
//                 servicesM)
//@PRIVATE( _SubM, aboutSubM,       fileSubM,  editSubM, helpSubM,
//                 aboutAppSubM,    openSubM,            helpSubM1,
//                 preferencesSubM, saveSubM,
//                 servicesSubM,
//                 hideSubM,
//                 hideOthersSubM,
//                 showAllSubM,
//                 quitSubM)
//@PRIVATE( _List, handlers,
//                 buttons)

*/


