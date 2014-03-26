
#import <AtoZ/AtoZ.h>
#import <SansNib.h>

@interface   SansList   ()
@property (NATOM) CGF   scrollOffset, drawOffset;
@property    AZOrient   orientation;
@property     AZRange   visibleRange;
@end

CLANG_IGNORE_PROTOCOL
@implementation SansList { NSMA *_visibleRects; }

-   (id) initWithFrame:(NSR)frame       { SUPERINITWITHFRAME;

  _onlyOneExpandedItem    = YES;
  _orientation            = AZOrientVertical;
  [NSEVENTLOCALMASK:NSScrollWheelMask | NSLeftMouseUpMask handler:^NSE *(NSE *e) {
    e.type == NSScrollWheel ? ^{ self.scrollOffset += 3 * (_orientation == AZOrientVertical ? e.deltaY : e.deltaX); }() :
    e.type == NSLeftMouseUp ? ^{
      if (e.clickCount == 2) self.orientation = _orientation == AZOrientVertical ? AZOrientHorizontal : AZOrientVertical;
      else {
        id x = [self hit:e.locationInWindow];
        if(x) {
          [x toggleBoolForKey:@"expanded"];
          [self setNeedsDisplay:YES];
          XX(((NSC*)x).name);
        }
      }
    }() : nil;
    return e;
  }];
  [self setNeedsDisplayForKeys:@[@"scrollOffset",@"storage",@"orientation"]];
  return self;
}
- (CGF) spanOfObjectAtIndex:(NSI)i { return ((NSO*)[self.storage normal:i]).span; }

- (void) setScrollOffset:(CGF)scrollOffset { CGF nudge;

  if (!(nudge = _scrollOffset - scrollOffset)) return; _drawOffset += nudge;

  while (_drawOffset > (nudge = [self spanOfObjectAtIndex:_visibleRange.location]))
      _visibleRange.location++, _drawOffset -= nudge, XX(@"remove");
//  while (_drawOffset < (nudge = [self spanOfObjectAtIndex:_visibleRange.location]))
//      _drawOffset += nudge, _visibleRange.location--, XX(@"ADD");
  _scrollOffset = scrollOffset;
}

- (id) hit:(NSP)p  { return [self.storage normal:_visibleRange.location + [_visibleRects indexOfObjectPassingTest:^BOOL(NSVAL*r, NSUI i, BOOL *s) { return *s = NSPointInRect(p,r.rectValue); }]]; }


- (NSA*) visibleRects { _visibleRects = NSMA.new;

  NSI loc = _visibleRange.location;
  CGF span = [self spanOfObjectAtIndex:loc];
  NSR dRect = _orientation == AZOrientVertical ? (NSR){            0, self.height - span + _drawOffset, self.width,       span}
                                               : (NSR){ -_drawOffset,                         0,       span, self.height };
  while (_orientation == AZOrientVertical ? dRect.origin.y + dRect.size.height > 0 : dRect.origin.x + dRect.size.width < self.width) {

    [_visibleRects addObject:AZVrect(dRect)];
    span = [self spanOfObjectAtIndex:loc];
    if (_orientation == AZOrientVertical) { dRect.size.height = span;  dRect.origin.y -= span; }
    else                                  { dRect.size.width = span;  dRect.origin.x += span; }

    loc++;
  }
   _visibleRange.length = _visibleRects.count;
  return _visibleRects;
}
- (void) drawRect:(NSR)r { IF_RETURN(!self.count); [self visibleRects];

//  XX(_visibleRects);
  [_visibleRects eachWithIndex:^(NSVAL*rVal, NSI idx) { NSO* drawObj;

    void(^dBlk)(id,NSR) = (drawObj = [self.storage normal:_visibleRange.location+idx]).drawBlock;
    dBlk ? dBlk(drawObj,rVal.rectValue) : NSLog(@"missing drawBlock %@ for %@", AZStringFromRect(rVal.rectValue),drawObj);
    NSAS *info = $(@"drawIdx:%ld span:%f expanded:%@", idx, rVal.rectValue.size.height, StringFromBOOL(drawObj.expanded)).attributedWithDefaults;
    NSR iR = AZCornerRectPositionedWithSize(rVal.rectValue, AZBtmRgt, info.size);
    NSRectFillWithColor(iR, BLACK);
    [info drawAtPoint:iR.origin];
  }];
  NSAS *info = $(@"_drawOffset:%.0f  %.0f %@",_drawOffset,_scrollOffset,AZString(_visibleRange)).attributedWithDefaults;
  NSR iR = AZCornerRectPositionedWithSize(r, AZTopRgt, info.size);
  NSRectFillWithColor(iR, BLACK);
  [info drawAtPoint:iR.origin];
}
@end
CLANG_POP



//  while (!NSIntersectsRect(r1,self.bounds)) {
//
//    if (delta < 0) {  _visibleRange.location--;
//      r1.origin.y += r1.size.height;
//      r1.size.height = [self sizeOfObjectAtIndex:_visibleRange.location].height;
//    }
//    else { _visibleRange.location++;
//      r1.size.height = [self sizeOfObjectAtIndex:_visibleRange.location].height;
//      r1.origin.y -= r1.size.height;
//    }
//    XX(r1);
//  }
//  XX(r1);
//  _drawOffset = self.height - r1.origin.y;
//- (RNG) visibleRange {
//
//  __block NSR r1 = (NSR){0, self.height + _drawOffset, self.width, [self spanOfObjectAtIndex:_visibleRange.location]};
//  __block NSR r2 = AZRectVerticallyOffsetBy(r1, _scrollOffset - scrollOffset);
//
//
//  VoidBlock goFwd = ^{ r1.origin.y -= r1.size.height; _visibleRange.location++; },
//            goBck = ^{ r1.origin.y += r1.size.height; _visibleRange.location--; };
//
//  while (r1.origin.y < self.height)  goBck();
//  while (rr.origin.y > 0) {
//    while (!NSIntersectsRect(rr,self.bounds)) goFwd();
//    while ( NSIntersectsRect(rr,self.bounds)) {
//
//  return _visibleRange;
//}
/*
- (void) drawLayer:(CAL*)l inContext:(CGContextRef)ctx {
  [NSGC drawInContext:ctx flipped:NO actions:^{
    NSRectFillWithColor(l.bounds, RED);
  }];
}
- (void) layoutSublayersOfLayer:(CAL*)l {

  NSR(^midList)() = ^NSR(){ return (NSR){0,self.height - _scrollOffset, self.width,0}; };

  [CATRANNY immediately:^{

  NSUI   subsWereLayedOut = 0;
  BOOL    mainListVisible = _scrollOffset <= 0 || (_scrollOffset > 0 && ABS(_scrollOffset) < self.height);
  BOOL inifiniListVisible = !mainListVisible   || (mainListVisible   &&     _scrollOffset  < self.height);


  NSR r = midList();

  if (!mainListVisible) goto Infinite;
  for (CAL*s in l.sublayers) {
    r.origin.y -= (r.size.height = s.height);
    if ((s.hidden =! NSIntersectsRect(self.bounds,r))) continue;
    s.frame = r; subsWereLayedOut++; NSLog(@"I placed layer %lu, from the FRONT!", s.siblingIndex);
  }

  Infinite: IF_RETURN(!inifiniListVisible); r = midList();

//  for (CAL*s in [l.sublayers.reversed subarrayToIndex:l.sublayers.count - subsWereLayedOut]) {           //    [infinity doUntil:^BOOL(CAL* s) {
//  for (CAL*z in [l.sublayers subarrayFromIndex:subsWereLayedOut].reversed) {           //    [infinity doUntil:^BOOL(CAL* s) {
    NSA* rev = l.sublayers.reversed;
    for (int i = 0; i < l.sublayers.count - subsWereLayedOut; i++) {
    CAL *z = rev[i];
    r.origin.y   += r.size.height;
    r.size.height = z.height;
    if (!NSIntersectsRect(self.bounds,r)) continue;//NSIntersectsRect(AZRectVerticallyOffsetBy(self.bounds,_scrollOffset),r))) continue;
    z.hidden = NO;
    z.frame = r; subsWereLayedOut++;
    NSLog(@"I placed layer %lu, from the BACK (subsWereLayedOut:%lu)!", z.siblingIndex, subsWereLayedOut);
  }
  NSLog(@"%lu/%lu were lain out, for offset %.0f", subsWereLayedOut, l.sublayers.count, _scrollOffset);

  }];
}
*/
//            if ((s.hidden =! NSIntersectsRect(AZRectExceptOriginY(self.bounds, _scrollOffset),r))) continue;
//       !s.hidden ? [s setFrameImmediately:r], subsWereLayedOut++, r.origin.y += r.size.height, subsWereLayedOut < l.sublayers.count : NO;  }];
//      if (subsWereLayedOut >= l.sublayers.count || !) break;
//    if (!NSIntersectsRect(self.bounds,r) return !NSIntersectsRect(self.bounds,r) ? NO : subsWereLayedOut++, subsWereLayedOut < l.sublayers.count;    }];
//subsWereLayedOut >= l.sublayers.count ||
//  NSA *infinity =  [l.sublayers subarrayFromIndex:subsWereLayedOut]; infinity = infinity ? infinity.reversed : nil;
//  if (inifiniListVisible && infinity && infinity.count) {
//AZRectVerticallyOffsetBy(midList(),-self.height);
  //  r = (NSR){0,self.height - _scrollOffset, self.width,0};

//+ (SET*) kPfVAVfK:(NSS*)k { return SameString(k, @"debugString") ? SETWITHSUPER(@"listLayer.position") : SUPERSET; }  // , @"listLayer.bounds", @"scrollOffset"  SameString(k, @"viewableRect") ? NSSET(@"scrollOffset") ;


@implementation DebugLayer { @public CAL *layer; CATXTL * debugText; }

+ (INST) addToLayer:(CAL*)l aligned:(AZPOS)a boundTo:(id)x key:(NSS*)k  { DebugLayer * new = self.class.new;

  [l addSublayer:new->layer       = [CAL noHitLayerWithFrame:AZRectBy(100,100)]];//AZCornerRectPositionedWithSize(l.bounds,a,(NSSZ){100,100})]];
  new->layer.position               = (NSP){l.boundsMaxX,0};
  new->layer.anchorPoint          = AZAnchorBottomRight;
  new->layer.arMASK               = AZPositionToAutoresizingMask(a);
//  new->layer.alignment            = a;
  new->layer.sublayers            = @[new->debugText = [CATXTL noHitLayerWithFrame:AZInsetRect(new->layer.bounds, 10)]];
  new->debugText.fontSize         = 14;
  new->debugText.foregroundColor  = cgWHITE;
//  new->debugText.alignment        = a;
  new->debugText.font             = (__bridge CGFontRef)@"UbuntuMono-Bold";
  [new->debugText b:@"bounds" tO:new->debugText wKP:@"stringBounds" o:nil];
  [new->layer     b:@"bounds" tO:new->debugText wKP:@"bounds" t:^id(id value) { return AZVrect(AZScaleRect([value rectValue], 1.3)); }];
  [new->debugText b:@"string" tO:x wKP:k o:nil];

  return new;
//  [_debugInfo adjustBoundsToFit];  selfLayer.frame = _debugInfo.bounds;
}
- (void) setColor:(NSColor *)color { layer.backgroundNSColor = color; }
@end

/*
    l.boundsHeight = MAX(ABS(r.origin.y), l.boundsHeight);
    if (CGRectIsEmpty(NSIntersectionRect(self.viewableRect, r)))  return;
- (void) drawLayer:(CAL*)l inContext:(CGCREF)ctx  {

  [NSGC drawInContext:ctx flipped:NO actions:^{

    NSRectFillWithColor(AZCenterRectOnPoint(AZRectFromDim(40), l.position), RED);
    NSFrameRectWithWidthWithColor(l.bounds, 8, WHITE);
  }];
}

 [x setBrightness:.3]; CGF h = 2 * [v iV] * _rowHeight; return AZVrectMake(0, -h, self.width,h); }]
- (NSUI) index { return !self.representedObject || !self.list ? NSNotFound : [self.list.storage indexOfObject:self.representedObject]; }
- (SansList*) list { return (SansList*)self.hostView; }
- (void) setRepresentedObject:(id)x { [super setRepresentedObject:x];
   [self b:@"name" tO:self.list wKP:@"storage.@count" t:^id(id v){ return @(self.index).sV;  }];
}
- (void) didMoveToSuperlayer { self.boundsHeight = self.list.rowHeight;  XX(self.boundsHeight); }
+ (BOOL) needsDisplayForKey:(NSS*)k {
  BOOL superNeeds = [super needsDisplayForKey:k];
  NSLog(@"key:%@ SuperNeeds:%@",k, StringFromBOOL(superNeeds));
  return SameString(k, @"boundsHeight") ?:superNeeds;
}
+ (id) defaultValueForKey:(NSS*)k { return SameString(k, @"anchorPoint") ? AZVpoint(AZAnchorTop) : [super defaultValueForKey:k]; }
- (void) drawInContext:(CGCREF)x { AZLOGCMD; [NSGC drawInContext:x flipped:NO actions:^{


}
  self.layer.sublayers      = @[_scrollLayer  = [CASCRLL layerWithFrame:self.bounds mask:CASIZEABLE]];
  _scrollLayer.scrollMode   = kCAScrollVertically;
  _scrollLayer.bgC          = LINEN.CGColor;
  _listLayer.position           = (NSP){self.boundsMidX, self.boundsHeight};// AZAnchorPointOfActualRect(_scrollLayer.bounds, AZTop);
  _listLayer.anchorPoint        = AZAnchorTop;
  [_listLayer enableDebugBordersRecursively:YES];
  [_listLayer setNeedsDisplay];
  _listLayer.nDoBC          = YES;
    obj.listLayer.boundsHeight += obj.rowHeight;                                              // Adjust list layer to accomodate new layer
    [new addConstraintsSuperSizeHorizontal];
    new.index ? [new addConstraint:AZConstRelAttr(kCAConstraintMaxY,@(new.index -1).sV,kCAConstraintMinY)]
              : [new addConstraintsRelSuper:kCAConstraintMaxY];
  [AZNOTCENTER observeName:NSWindowDidEndLiveResizeNotification usingBlock:^(NSNOT*n) { [_listLayer setNeedsLayout]; }];
    if (s.selected)
      [s setDrawInContextBlk:^(id l) { specialH = [self drawObject:obj]; }];
    if (!s.selected && s.blockDelegate) s.blockDelegate = nil;
    XX(specialH);
    r = AZRectExtendedOnBottom(r, specialH);
    r.size.height = _rowHeight;
    r.origin.y   -= _rowHeight;


- (void) setScrollOffset:(CGF)off                     { AZSTATIC(CGF , stepper, 0); stepper = _scrollOffset + off;

  _scrollOffset = MIN(0, off);
  if (stepper > _rowHeight || stepper < -_rowHeight)  { stepper = 0; [_listLayer setNeedsLayout]; }
//    [_scrollLayer scrollToPoint:(NSP){0,_scrollOffset}]; }

}
-  (CGR) viewableRect { return AZRectExceptOriginY(self.bounds , _scrollOffset); }

- (void) drawRect:(NSRect)d {}

  NSR actual = CGContextGetClipBoundingBox(ctx);
  NSLog(@"actual: %@, myGuess:%@", AZStringFromRect(actual),AZStringFromRect(layer.visibleRect));
//  XX(self.storage);
  __block NSRect r = AZUpperEdge(layer.bounds,0);
  [NSGC drawInContext:ctx flipped:NO actions:^{

    if (self.inLiveResize) return NSRectFillWithColor(self.bounds, [BLACK alpha:.5]);

    DrawBluePrintInRectWithScale(layer.bounds, 16);
    [self.storage enumerateObjectsUsingBlock:^(NSC *x, NSUInteger idx, BOOL *stop) {
      r.size.height  = _rowHeight;
      r.size.height += x.expanded ? _rowHeight : 0.;
      r.origin.y    -= r.size.height;
      NSRectFillWithGradient(r,[x gradient]);
      [$(@"%@ %lu", Emoji.random, idx) drawAtPoint:AZPointOffsetBy(r.origin, 20,5) withAttributes:NSAS.defaults];
    }];
  }];
}

[_listLayer addObserverForKeyPath:@"bounds" task:^(id obj){ XX(AZStringFromRect([obj visibleRect])); }];

*/
//  self.setupHostView.bgC    = LINEN.CGColor;
//  self.layer.sublayers      = @[list = CAL.new]; //WithFrame:AZRectBy(self.width,0)]];
//  list.loM                  = self;
//  list.delegate             = self;
//  list.implicitResize       = NO;

//  [self observeFrameChangeUsingBlock:^{ list.needsDisplay = YES; }];
//  [self addObserverForKeyPath:@"storage" task:^(id sender) { [sender setNeedsDisplay:YES]; }];
//      SansListItem *new     = [SansListItem layerWithFrame:AZRectBy(_self.width,_self.rowHeight)];  // mask:kCALayerNotSizable];
//      new.backgroundNSColor =
//    NSO *new; new.representedObject = chng[@"new"][0];                              // Set its object rep + In this case, bind background color to the objectRep */
//      [list addSublayer:new];                                                                  //      [new b:@"boundsWidth" tO:_self wKP:@"width" o:nil];
//  }];


//@interface    SansListItem : NSO @property (CP) DrawBlock collapsedDrawBlock, expandedDrawBlock;
// (RONLY) NSS *titleString;
// @end @implementation SansListItem

//- (id) init { SUPERINIT;
//
////  self.anchorPoint    = AZAnchorTop;
////  self.actions        = @{@"hidden":AZNULL};
////  self.implicitResize = NO;
////  self.sublayers      = @[[[CATXTL noHitLayerWithFrame:self.bounds mask:CASIZEABLE]
////                                  objectBySettingValue:@14 forKey:@"fontSize"]];
//  [self addObserverForKeyPaths:@[@"expanded", @"siblingIndex",@"position", @"bounds"]
//                          task:^(SansListItem* obj, NSS *kP) { [obj titleString];  }];
//  return self;
//}
//- (NSS*) titleString {  return ((CATXTL*)self.sublayers[0]).string =
//
//  $(@"%@ pos:%@ %@ EXP:%@", self.name ?: @(self.siblingIndex).sV, AZStringFromPoint(self.position), AZStringFromRect(self.frame), StringFromBOOL(self.expanded));
//}
//- (void) setExpanded:(BOOL)x { IF_RETURN(x == self.expanded); [super setExpanded:x];
//
//  NSLog(@"self.expanded: %@", StringFromBOOL(self.expanded));
//
//  self.boundsHeight = x ? 2 * self.boundsHeight : .5 * self.boundsHeight;
//  self.debug = x;
//  [self setNeedsDisplay];
//  [Lasso setEnabled:YES];
//  [Lasso rope:self];
//}
//@end
//+ (NSSet*) kPfVAVfK:(NSS*)k { return SameString(k,@"titleString") ? NSSET(@"siblingIndex",@"position", @"bounds") : [super kPfVAVfK:k]; }
//  _listLayer.debug                = YES;
//  _listLayer.orientation          = AZTopLft;
//  _listLayer.anchorPoint        = AZAnchorBottomLeft;
//  self.layer.needsLayoutForKeys   = @[@"position"];
// MAX(0, // aka 0 is the minimum
//  _listLayer.positionY + -3*e.deltaY); // aka move posY up (negating a stupidly neg delta.
// case NSLeftMouseUp: { CAL * hit; XX(hit = [_listLayer hitTest:e.locationInWindow]); [hit toggleBoolForKey:@"expanded"]; break; }
//  [Lasso      setEnabled:NO];
//@property       NSRNG   visibleRange;
//  [DebugLayer addToLayer:self.layer aligned:AZAlignBottomRight boundTo:self key:@"debugString"].color = BLUE;

//  [self addObserverForKeyPath:@"storage" task:^(SansList *_self) { [_self setNeedsDisplay:YES]; }];
