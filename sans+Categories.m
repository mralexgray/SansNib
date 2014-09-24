
#import "sans.h"

static char ACTION_KEY;

@implementation NSMenu (Sans)
- (void) setItemArray:(NSArray*)items { for (NSMenuItem*m in items) [self addItem:m]; }
@end
@implementation NSMenuItem (Sans)
+ title:(NSString*)tit key:(NSString*)k action:(id)blk {

  NSMenuItem *menu = [[self allocWithZone:[NSMenu menuZone]] initWithTitle:tit action:@selector(act:) keyEquivalent:k];
  menu.target      = menu, menu.enabled = YES;
  if (blk) objc_setAssociatedObject(menu, ACTION_KEY, blk, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  return menu;
}
- (void) act:(id)act { void(^x)(id); if ((x = objc_getAssociatedObject(self,ACTION_KEY))) x(self);  }
@end

@implementation  NSView (SansNib)

- (NSSplitView*) bisect { NSSplitView *split = nil; @synchronized(self) {

    split = [NSSplitView.alloc initWithFrame:self.bounds];
    split.autoresizingMask  = self.autoresizingMask;
    split.vertical              = [self isKindOfClass:NSSplitView.class] ? !((NSSplitView*)self).isVertical : YES;
    split.dividerStyle          = NSSplitViewDividerStyleThick;
    __strong __typeof__(self) selfish = [self isKindOfClass:NSClipView.class] ? self.enclosingScrollView : self;
    [self isEqual:self.window.contentView] ? [self.window setContentView:split]
                                           : [self.superview addSubview:split];
    [split addSubview:selfish];
    [split addSubview:[NSBox.alloc initWithFrame:self.bounds]];
    //[AZSimpleView withFrame:self.bounds color:AtoZ.globalPalette.nextNormalObject]];
  }
 return split;
}

-        (WebView*) addWebviewWith:(NSString*)url {

  NSView * newv = self.bisect.subviews.lastObject; WebView *xx;
  [newv addSubview:xx = [WebView.alloc initWithFrame:newv.bounds]];
  xx.mainFrameURL = url; return xx;
}

- (NSTableView*) addTableWith:(id)a    {         NSView * newv = self.sans.split.subviews.lastObject;

  [self addSubview:                         ({   NSScrollView * 🆂;
    [🆂 = NSScrollView.new setDocumentView: ({    NSTableView * 𝖳;
    [𝖳 = NSTableView.new addTableColumn:    ({  NSTableColumn * 𐌎;

      [𐌎 = NSTableColumn.new setWidth:self.bounds.size.width]; 𐌎.resizingMask = NSTableColumnAutoresizingMask;
      [𐌎 bind:NSValueBinding toObject:[a isKindOfClass:NSArray.class] ? [NSArrayController.alloc initWithContent:a] : a
                           withKeyPath:@"arrangedObjects"               options:nil]; 𐌎; })];

    𝖳.frame = 🆂.frame = newv.bounds; 𝖳.headerView = nil;  𝖳.usesAlternatingRowBackgroundColors = YES;
    🆂.autoresizingMask = 𝖳.autoresizingMask = NSViewWidthSizable|NSViewHeightSizable; 𝖳; })]; 🆂; })];
}
@end
