
#import <AtoZ/AtoZ.h>
#import "SansNib.h"

@interface SansNib ()
@property (readonly)   NSWindow * window;
@property (readonly)    CALayer * layer;
@property (readonly)     NSView * view;
@property (readonly)     NSMenu * aboutMenu,              * fileMenu,      * editMenu,      * helpMenu,
                                * servicesMenu;
@property (readonly) NSMenuItem * aboutMenuItem,          * fileMenuItem, * editMenuItem, * helpMenuItem,
                                * aboutAppMenuItem,    * openMenuItem,                      * helpMenuItemOne,
                                * preferencesMenuItem, * saveMenuItem,
                                * servicesMenuItem,
                                * hideMenuitem,
                                * hideOthersMenuItem,
                                * showAllMenuItem,
                                * quitMenuItem;

@property (readonly) NSMutableArray * eventBlocks, * buttons;
@end

@implementation SansNib static SansNib *nibless; /** static singleton rules this house */

+  (instancetype) sansNib                       { SHAREDAPP; DISPATCHINIT; SETPOLICY; return nibless; }
+          (void) run                           { [SANSNIB.window orderFrontRegardless]; [NSApp run]; }

- (id) init {  if ((self = super.init) != nibless) return nil; SHAREDAPP.

    mainMenu.itemArray = @[     _aboutMenuItem = MENUITEM_NAMED(NULL, placehoder, nil, _aboutMenu = MENUTITLED(About SansNib)),
                                 _fileMenuItem = MENUITEM_NAMED(File, placehoder, nil,  _fileMenu = MENUTITLED(FileCACA)),
                                 _editMenuItem = MENUITEM_NAMED(Edit, placehoder, nil,  _editMenu = MENUTITLED(Edit)),
                                 _helpMenuItem = MENUITEM_NAMED(Help, placehoder, nil,  _helpMenu = MENUTITLED(Help)) ];
  _aboutMenu.itemArray = @[  _aboutAppMenuItem = MENUITEMACTION(ABOUTRPROCESS, nil, ^(NSMI*menu){ [AZSHAREDAPP orderFrontStandardAboutPanelWithOptions: @{@"Credits": [@"c/o Steve Van Voorst via fbcocoa list\nvia Bernie Wylde / Ken Shmidheiser."  attributedWithFont:AtoZ.controlFont andColor:RED] ?: @"", @"ApplicationName":@"AtoZ Nibless Demo",   @"Version":@"0.1 alpha for list", @"Copyright":@"Copyright 2012", @"ApplicationIcon": [NSImage imageNamed:@"atoz"]?:[NSImage imageNamed:NSImageNameUser], @"ApplicationVersion":AZFWORKBUNDLE.infoDictionary[@"CFBundleVersion"]?:@"v.N/A"}]; }), MENU_SEPERATOR,
                          _preferencesMenuItem = MENUITEMACTION(Beep!, @",", ^(NSMI* item){ NSBeep(); [AZTalker say:@"Preferences"]; }), MENU_SEPERATOR,
                             _servicesMenuItem = MENUITEM_NAMED(Services, placehoder, nil , nil), MENU_SEPERATOR,
                                 _hideMenuitem = MENUITEM_NAMED(Hide, hide:,  nil, nil),
                           _hideOthersMenuItem = MENUITEM_NAMED(Hide Others, hideOtherApplications:, nil, nil),
                              _showAllMenuItem = MENUITEM_NAMED(Show All,    unhideAllApplications:, nil, nil),    MENU_SEPERATOR,
                                 _quitMenuItem = MENUITEM_NAMED(Quit,          terminate:,           @"q", nil)];
  _fileMenu.itemArray = @[       _openMenuItem = MENUITEM_NAMED(Open...,       openFile:,            @"o", nil),
                                                 MENU_SEPERATOR,
                                 _saveMenuItem = MENUITEMACTION(Save, @"s",^(NSMI*m){ [AZTalker say:[m.title withString:@" not implemented"]]; }) ];
  _editMenu.itemArray = @[                       MENUITEM_NAMED(Cut,          cut:,            @"x", nil),
                                                 MENUITEM_NAMED(Copy,         copy:,           @"c", nil),
                                                 MENUITEM_NAMED(Paste,        paste:,          @"v", nil),
                                                 MENUITEM_NAMED(Select All,   selectAll:,      @"a", nil) ];
  _helpMenu.itemArray = @[    _helpMenuItemOne = MENUITEM_NAMED(Help!,        placehoder,      @"h", nil) ];

  [@[_hideMenuitem, _hideOthersMenuItem, _showAllMenuItem, _quitMenuItem] makeObjectsPerformSelector:@selector(setTarget:) withObject:NSApp];
  [NSApp setServicesMenu:_servicesMenuItem.submenu = _servicesMenu = MENUTITLED(Services)]; [NSApp setHelpMenu:_helpMenu];
  _eventBlocks  = [NSMutableArray new];
  _buttons      = [NSMutableArray new];
  _window       = [objc_getClass("SansNibWindow") new];
  return nibless;
}


@end

//+          (void) addEventBlock:(EventBlock)blk { [SANSNIB setValue:[SANSNIB.eventBlocks ?: @[] arrayByAddingObject:[blk copy]] forKey:@"eventBlocks"]; }


/*
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