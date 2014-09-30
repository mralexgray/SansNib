//
//  JJMenuPopulator.h
//  NiblessLeopard
//
//  Created by Jeffrey Johnson on 11/22/07.
//  Copyright 2007 Lap Cat Software. All rights reserved.
//

@import AppKit;

@interface JJMenuPopulator : NSObject


+(void) populateMainMenu;

+(void) populateApplicationMenu:(NSMenu *)aMenu;
+(void) populateDebugMenu:(NSMenu *)aMenu;
+(void) populateEditMenu:(NSMenu *)aMenu;
+(void) populateFileMenu:(NSMenu *)aMenu;
+(void) populateFindMenu:(NSMenu *)aMenu;
+(void) populateHelpMenu:(NSMenu *)aMenu;
+(void) populateSpellingMenu:(NSMenu *)aMenu;
+(void) populateViewMenu:(NSMenu *)aMenu;
+(void) populateWindowMenu:(NSMenu *)aMenu;

@end
