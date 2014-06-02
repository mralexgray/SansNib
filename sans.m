

#import "sans.h"

#define SPLIT_CONTAINS(SPLIT,X) [[@#SPLIT componentsSeparatedByString:@"|"]containsObject:X]
#define PRIVATE(K,...) property (readonly) K __VA_ARGS__;

@interface Sans() <NSApplicationDelegate>

@PRIVATE( _List, handlers,
                 buttons)
@PRIVATE( _Main, window)
@PRIVATE( _Lens, layer)
@PRIVATE( _View, view)

@PRIVATE( _Menu, aboutM,            fileM,     editM,     helpM,
                 servicesM)
@PRIVATE( _SubM, aboutSubM,       fileSubM,  editSubM, helpSubM,
                 aboutAppSubM,    openSubM,            helpSubM1,
                 preferencesSubM, saveSubM,
                 servicesSubM,
                 hideSubM,
                 hideOthersSubM,
                 showAllSubM,
                 quitSubM)
@end

@implementation Sans static Sans *nibless; /** static singleton rules this house */

+ sans { return sans_APP, DISPATCHONCE([NSApp setMainMenu:MENUTITLED(@"")]; nibless = super.alloc; nibless = nibless.init;), SETPOLICY, nibless; }

- init {  return self = super.init && self == nibless ? ({ sans_APP.

    mainMenu.itemArray = @[  _aboutSubM = MENUITEM_NAMED(NULL,        placehoder, nil, _aboutM = MENUTITLED(About Sans)),
                              _fileSubM = MENUITEM_NAMED(File,        placehoder, nil,  _fileM = MENUTITLED(Work It!)),
                              _editSubM = MENUITEM_NAMED(Edit,        placehoder, nil,  _editM = MENUTITLED(Twerk It!)),
                              _helpSubM = MENUITEM_NAMED(Help,        placehoder, nil,  _helpM = MENUTITLED(Hates It!)) ];
  _aboutM.itemArray = @[  _aboutAppSubM = MENUITEMACTION(ABOUTRPROCESS,                       nil, NULL         /* self.aMenu*/), MENU_SEPERATOR,
                       _preferencesSubM = MENUITEMACTION(Beep!, @",", ^(NSMenuItem* item){ NSBeep();                              /* [AZTalker say:@"Preferences"]; */ }), MENU_SEPERATOR,
                          _servicesSubM = MENUITEM_NAMED(Services,    placehoder,             nil, nil),    MENU_SEPERATOR,
                              _hideSubM = MENUITEM_NAMED(Hide,        hide:,                  nil, nil),
                        _hideOthersSubM = MENUITEM_NAMED(Hide Others, hideOtherApplications:, nil,  nil),
                           _showAllSubM = MENUITEM_NAMED(Show All,    unhideAllApplications:, nil,  nil),   MENU_SEPERATOR,
                              _quitSubM = MENUITEM_NAMED(Quit,          terminate:,           @"q", nil)];
  _fileM.itemArray = @[       _openSubM = MENUITEM_NAMED(Open...,       openFile:,            @"o", nil),   MENU_SEPERATOR,
                              _saveSubM = MENUITEMACTION(Save, @"s",^(NSMenuItem*m){ /* [AZTalker say:[m.title withString:@" not implemented"]]; */ }) ];
  _editM.itemArray = @[                   MENUITEM_NAMED(Cut,          cut:,            @"x", nil),
                                          MENUITEM_NAMED(Copy,         copy:,           @"c", nil),
                                          MENUITEM_NAMED(Paste,        paste:,          @"v", nil),
                                          MENUITEM_NAMED(Select All,   selectAll:,      @"a", nil) ];
  _helpM.itemArray = @[      _helpSubM1 = MENUITEM_NAMED(Help!,        placehoder,      @"h", nil) ];

  [@[_hideSubM, _hideOthersSubM, _showAllSubM, _quitSubM] makeObjectsPerformSelector:@selector(setTarget:) withObject:NSApp];
  [NSApp setServicesMenu:_servicesSubM.submenu = _servicesM = MENUTITLED(Services)]; [NSApp setHelpMenu:_helpM];
  [_handlers  = NSArrayController.new setContent:NSMutableArray.new];
  [_buttons   = NSArrayController.new setContent:NSMutableArray.new]; _window = [objc_getClass("SansNibWindow") new];

  [sans_NCENTER addObserverForName:NSApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue
                        usingBlock:^(NSNotification *x) { setCuteIcon(); }];   [NSApp setDelegate:self]; nibless; }) : nil;
}

+ forwardingTargetForSelector:(SEL)s { _Text x = NSStringFromSelector(s); return

  SPLIT_CONTAINS(addButton:block:,             x) ? objc_getClass("SansNibWindowButton") :
  SPLIT_CONTAINS(addTableWith:|addWebviewWith:,x) ? self.view.subviews.lastObject ?: self.view : // was  lastSplitPane
  SPLIT_CONTAINS(handlers|buttons|window,      x) ? Sans.sans :
  SPLIT_CONTAINS(hitLayer|layer|view,          x) ? Sans.window : [super forwardingTargetForSelector:s];
}

+ (_Void) run                         { [SANS.window orderFrontRegardless]; [NSApp run]; }

- (BOOL)applicationShouldHandleReopen:(NSApplication*)a hasVisibleWindows:(BOOL)f { setCuteIcon(); [self.class window]; }

- (void(^)(NSMenuItem*)) aMenu {

 return // (void(^)(NSMenuItem*))
        ^(NSMenuItem*menu){ [sans_APP orderFrontStandardAboutPanelWithOptions:

@{@"Credits": @"c/o Steve Van Voorst via fbcocoa list\nvia Bernie Wylde / Ken Shmidheiser.",
  @"ApplicationName":@"AtoZ Nibless Demo",
  @"Version": @"0.1 alpha for list", @"Copyright":@"Copyright 2012",
  @"ApplicationIcon": [NSImage imageNamed:NSImageNameAddTemplate],
  @"ApplicationVersion":@"N/A"}];
};

//    [SHAREDAPP orderFrontStandardAboutPanelWithOptions: @{@"Credits": [@"c/o Steve Van Voorst via fbcocoa list\nvia Bernie Wylde / Ken Shmidheiser."  attributedWithFont:AtoZ.controlFont andColor:RED] ?: @"", @"ApplicationName":@"AtoZ Nibless Demo",   @"Version":@"0.1 alpha for list", @"Copyright":@"Copyright 2012", @"ApplicationIcon": [NSImage imageNamed:@"atoz"]?:[NSImage imageNamed:NSImageNameUser], @"ApplicationVersion":AZFWORKBUNDLE.infoDictionary[@"CFBundleVersion"]?:@"v.N/A"}]; };

//  };
}

+            addViewWithClass:(_Meta)k { _View v; return [self addViewWithSplit:v = k.new], v; }

+ (_Void) addViewWithSplit:(_View)v { _Splt s = [self.view.subviews.lastObject split];

  _View t = s.subviews[1]; v.frame = t.bounds; [t removeFromSuperview]; [s addSubview:v];
}
+ (_Void) setDockIcon:(_Pict)i      { NSImageView *iv;

  sans_DOCK_TILE.contentView  = iv = [NSImageView.alloc initWithFrame:(NSRect){0,0,512,512}];
  iv.imageScaling             = NSImageScaleProportionallyUpOrDown;
  iv.image                    = i;   [sans_DOCK_TILE display];
}
+ (_Splt) split                     {  _View v = self.view;  return v.subviews.lastObject ?: ({ NSBox*halve;

    [v addSubview:halve = [NSBox.alloc initWithFrame:v.bounds]];
    [halve setFillColor:NSColor.blueColor];
    [halve setAutoresizingMask:v.autoresizingMask];  halve; }).split;
}
@end

void setCuteIcon(void){ NSLog(@"seeting cute icon",nil); NSRect r; NSImage * i; NSMutableParagraphStyle *s;

  (s = NSParagraphStyle.defaultParagraphStyle.mutableCopy).alignment = NSCenterTextAlignment;
  [NSGraphicsContext saveGraphicsState];
  [Sans setDockIcon:({ [i = [NSImage.alloc initWithSize:(r = (NSRect){0,0,256,256}).size]lockFocus];
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
*/
