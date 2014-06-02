//  _list.masksToBounds = NO; _list.scrollMode = kCAScrollVertically;  _list.alignment = AZTop;

#import "sans.h"

@interface  DebugLayer : NSObject
//@property (NATOM)  NSC * color;
//+ (INST)     addToLayer:(CAL*)l
//                aligned:(AZPOS)a
//                boundTo:(id)x
//                    key:(NSS*)k;
@end

@interface SansList  () // <ArrayLike>
//@property (NATOM)  RNG * visibleRange;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignore "-Wprotocol"

@implementation SansList
/*
-   (id) initWithFrame:(NSRect)f       { SUPERINITWITHFRAME(f); AZBlockSelf(_me); _visibleRange = RNG.new;

  self.setupHostView.sublayers  = @[_list = [CATransformLayer  layerWithFrame:f mask:CASIZEABLE],
                                    _info = [CAL noHitLayerWithFrame:f mask:CASIZEABLE]];
  _list.loM                     = AZLAYOUTMGR; //  _list.nDoBC = YES;


  _list.backgroundNSColor       = LINEN;
//  _list.borderColor             = cgYELLOW;   _list.borderWidth = 10; 
  _list.debug                   = YES;
  _info.drawBlock               = ^(CAL*l) {
  
    NSAS *info = $(@"listSubs:%lu _list.subs.frameMinY:%.0f _list.frameMinY:%.0f  vRange:%@",
                  _me.list.sublayers.count, _me.list.lastSublayer.y, _me.list.y, 
                  _me.visibleRange).attributedWithDefaults;
    [info drawInRect:AZCornerRectPositionedWithSize(l.bounds, AZTopLft, info.size) withBackground:BLACK];
    NSFrameRectWithWidthWithColor(l.bounds,2, WHITE);
  };
  [NSEVENTLOCALMASK:NSScrollWheelMask | NSLeftMouseUpMask | NSKeyDownMask handler:^NSE *(NSE *e) {

    e.type == NSKeyDown     ? ^{ unsigned short code = e.keyCode;
    
      self.scrollOffset += code == AZArrowUp || code == AZArrowRight ?: code == AZArrowDown || code == AZArrowLeft ? -1 : 0; }() : 
      
    e.type == NSScrollWheel ? ^{ _me.scrollOffset += -3* e.deltaY; }() : 
    e.type == NSLeftMouseUp ? ^{

      if (e.clickCount == 2) self.orientation = AZOrientOpposite(self.orientation);
      else {
        [self addLayer];
        if (!!SansNib.hitLayer && [RNG canGetRangeFromString:SansNib.hitLayer.name])
          [[self.storage normal:[RNG rangeFromString:SansNib.hitLayer.name].max] toggleBoolForKey:@"expanded"];
      // XX([self.storage indexOfObject:z]); _list.scrollMode = SameString(_list.scrollMode,kCAScrollVertically) ? kCAScrollHorizontally : kCAScrollVertically;
      // XX(_list.scrollMode);      [x blinkLayerWithColor:RANDOMCOLOR];
      } }() : nil;
      
    [_me.info setNeedsDisplay];
    return e.type == NSKeyDown ? nil : e;
  }];
  return self;
}
- (void) setScrollOffset:(CGF)o { _list.y += (_scrollOffset - o); _scrollOffset = o; 

//  [_list.sublayers eachWithIndex:^(CA, NSInteger idx) { // XX([obj rectValue]);
//  
//      if (NSIntersectsRect([obj rV],self.bounds)) return;
//    
//      id z = _list.sublayers[idx]; NSLog(@"Removing %@", z);  [z unbind:@"boundsHeight"]; [z removeFromSuperlayer];
//  }];
  
}

- (CAL*) addLayer { _visibleRange.length++;

  id<Drawable>x = [self.storage normal:_visibleRange.max];
  CAL           * new = [[CAL layerWithFrame:_list.bounds mask:kCALayerWidthSizable] named:_visibleRange.stringValue];   //  newL.aPoint = AZAnchorTop;
  new.drawBlock       = ^(CAL*d) { !x.drawObjectBlock ?: x.drawObjectBlock(x,d.bounds);
  
    [AZString(d.visibleRect).attributedWithDefaults drawInRect:d.bounds aligned:AZTopRgt backgroundColor:WHITE]; // [[NSBP bezierPathWithOvalInRect:AZCenterRectOnPoint(AZRectFromDim(19),d.position)] fillWithColor:RED];
    [d.description.attributedWithDefaults           drawInRect:d.bounds aligned:AZBtmRgt backgroundColor:BLACK]; // [[NSBP bezierPathWithOvalInRect:AZCenterRectOnPoint(AZRectFromDim(19),d.position)] fillWithColor:RED];
    
  };
  [new addConstraint:!_list.sublayers.count ? AZConstRelSuper(kCAConstraintMaxY)
                                            : AZConstRelAttr(kCAConstraintMaxY,_list.lastSublayer.name,kCAConstraintMinY)]; // newL.siblingPrev.name,kCAConstraintMinY)];
  [new b:@"boundsHeight" tO:x wKP:@"span" o:nil];   new.nDoBC = YES;  new.animatesResize = NO; [_list addSublayer:new];  [_info setNeedsDisplay];
  return new;
}
*/
@end
#pragma clang diagnostic pop
//CLANG_POP


#pragma mark - disabled during migration

@implementation DebugLayer { @public CALayer *layer; CATextLayer* debugText; }

/*

+ (INST) addToLayer:(CAL*)l aligned:(AZPOS)a boundTo:(id)x key:(NSS*)k  { DebugLayer * new = self.class.new;

  [l addSublayer:new->layer       = [CAL noHitLayerWithFrame:AZRectBy(100,100)]];//AZCornerRectPositionedWithSize(l.bounds,a,(NSSZ){100,100})]];
  new->layer.position               = (NSP){l.width,0};
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
*/
@end

/*
        XX(x.constraints);
        [x setNeedsDisplay];
        CABA *ani     = [CABA animationWithKeyPath:@"bounds.size.height"];
        [CATRANNY transactionWithLength:2 actions:^{
				ani.fromValue = @(x.boundsHeight);
          x.boundsHeight += z.expansionDelta;
   = @(x.bounds.size.height);
          ani.removedOnCompletion = NO;
          [ani setCompletion:^(CAAnimationDelegate *delegate) { [x setNeedsDisplay]; }];
          [x addAnimation:ani];
        for (CAL* obj in [list.sublayers subarrayFromIndex:x.siblingIndex+1]) {
            [ani setKeyPath:@"position.y"];
           ani.fromValue = @(obj.positionY);
            ani.toValue = @(obj.positionY = obj.positionY - z.expansionDelta);
//            ani.toValue   = @(obj.positionY = obj.position.y + change);//AZVpoint(AZPointOffsetY(obj.position, z.expanded ? -change : change));
           [obj addAnimation:ani];
          }
     }];

        [list setNeedsLayout];
        id x; if (!(x = [self hit:e.locationInWindow])) return; [x toggleBoolForKey:@"expanded"]; [self.layer setNeedsLayout]; XX(((NSC*)x).nameOfColor);
  [_list setKVOBlock:^(CALayer *l, NSString *k, id val) { if (SameString(k,@"scrollMode")) ;;  NSLog(@"kvoblock:%@ k:%@ v:%@",l, k, val);  }];

- (BOOL) isOpaque             { return YES; }
- (BOOL) wantsDefaultClipping { return NO;  }
  [self setKVOBlock:^(SansList *me, NSString *kp, NSDictionary *x) { objswitch(kp);
  
    objcase(@"scrollOffset") [me.list scrollBy:[x floatForKey:@"value"]]; XX([x floatForKey:@"value"]);
    endswitch
  }];
  } observeTarget:self keyPath:@"scrollOffset" options:0 block:^(MAKVONotification *n) {  [n.observer setNeedsDisplay]; }];
@"position" tO:self wKP:@"scrollOffset" o:nil];
  [_list disableResizeActions];
  [self addObserverForKeyPaths:@[@"scrollOffset", @"storage.@count", @"orientation"] options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld task:^(__typeof(self) o, NSString *kp, NSDictionary *x) {
  [_info observeTarget:self keyPath:@"scrollOffset" options:0 block:^(MAKVONotification *n) { XX(n); [n.observer setNeedsDisplay]; }];
    objswitch(kp);
    objcase(@"orientation",     // [o.list removeSublayers];
            @"storage.@count")
      objcase(@"scrollOffset")
        [CATRANNY immediately:^{
          CGF sOff = x.newNum.fV;
          while (o.storage.count && (!o.list.sublayers.count || o.list.lastSublayer.frameMinY > 0)) {
            NSLog(@"adding a Layer to %lu existing, as o.list.lastSublayer.frameMinY = %f", o.list.sublayers.count, o.list.lastSublayer.frameMinY);
            ctrMax++; if (ctrMax > 1000) NSLog(@"TERMINATE"), [NSApp terminate:nil];
            [o.list setNeedsLayout];
          }
          [o.list scrollTo:sOff];
        }];
    endswitch
    [o.info setNeedsDisplay];
  }];
  
  XX(newL.constraints); newL.debug  = YES; if (!_list.sublayers.count) newL.position = AZAnchorPointOfActualRect(_list.frame, AZTop);
  [newL b:@"positionY" to:@"siblingIndex" using:^id(NSN* v) {

      id y = @(v.uIV == 0 ? l.boundsMaxY + _scrollOffset : [ll.siblingPrev frameMinY]);
      XX(y);
      return y; } type:BindTypeTransform];
*/
/*- (void) layoutSublayersOfLayer:(CAL*)l {

  while (!l.sublayers.count || l.sublayers.count < 4) {// l.lastSublayer.frameMinX > 0) {

//    if (!self.storage.count) 
    CAL *ll = [CAL layerWithFrame:AZRectBy(l.width,33) mask:kCALayerWidthSizable];
    [l addSublayer:ll];
    NSO* x = [self.storage normal:AZMaxRange(_visibleRange)];
    [ll b:@"boundsHeight" tO:x wKP:@"span" o:nil];
    if (x.drawObjectBlock) ll.drawInContextBlk = ^(CAL*d) { x.drawObjectBlock(x,d.bounds);
      [d.description.attributedWithDefaults drawInRect:d.bounds aligned:AZBtmRgt backgroundColor:BLACK];
    };
    ll.name = AZRangeToString(_visibleRange);
    ll.nDoBC  = YES;
    ll.aPoint = AZAnchorTop;
    [ll b:@"positionY" to:@"siblingIndex" using:^id(NSN* v) {

      id y = @(v.uIV == 0 ? l.boundsMaxY + _scrollOffset : [ll.siblingPrev frameMinY]);
      XX(y);
      return y; } type:BindTypeTransform];

//    [ll b:@"positionY" tO:ll wKP:@"siblingIndex" t:^id(NSN* v) {
//      return !v.uIV ? @(l.height + _scrollOffset)
//                    : [[l.sublayers normal:v.uIV - 1] vFK:@"frameMinY"];
//    }];
//    [ll addObserverForKeyPath:@"siblingIndex" task:^(id sender) {
//      XX(sender); NSUI sIdx = [sender unsignedIntForKey:@"siblingIndex"];
//      [sender setPositionY:sIdx ? l.height + _scrollOffset : [l.sublayers[sIdx - 1] floatValueForKey:@"frameMinY"]];
//    }];

//    ll.positionY = !ll.siblingIndex ? l.height + _scrollOffset : [l.sublayers[ll.siblingIndex - 1] frameMinY];

    _visibleRange.location++;
    _visibleRange.length++;
    [_info setNeedsDisplay];
//    XX(l.sublayers);
  }
//  l.frameMinX
  XX([l.sublayers vFK:@"siblings"]);//frameMinX"]);
}
*/
/*- (void) setDrawOffset:(CGF)dOff { _drawOffset = dOff; CGF nudge; RNG newR = _visibleRange;

  while (_drawOffset > (nudge = [self spanOfObjectAtIndex:newR.location])) // List is moving UP!
    newR.location++, _drawOffset -= nudge;
  while (_drawOffset < (nudge = [self spanOfObjectAtIndex:newR.location])) // List is moving DOWN!
    newR.location--, _drawOffset += nudge;
  self.visibleRange = newR;
}
- (void) setScrollOffset:(CGF)scrollOffset { IF_RETURN(_scrollOffset == scrollOffset);

  CAL *keystone;
  while (_list.sublayers.count && (keystone = [_list.sublayers.first objectByIncrementing:@"frameMinY" by:@(scrollOffset - _scrollOffset)]));
    if(keystone.frameMinY > _list.boundsMaxY) [keystone removeFromSuperlayer];
  if (!keystone) {
    [_list addSublayer:keystone = [CAL layerWithFrame:AZRectBy(self.width,0) mask:kCALayerWidthSizable]];
    keystone.nDoBC  = YES;
    keystone.aPoint = AZAnchorTop;
  }
}
*/
/*
- (void) setVisibleRange:(RNG)vR { if (AZEqualRanges(vR, _visibleRange)) return;

  while (_list.sublayers.count && _visibleRange.location < vR.location) _list.sublayers.count -1) [_list.lastSublayer removeFromSuperlayer];
 [_list.sublayers[0] removeFromSuperlayer];


  BOOL isV = self.isVertical; _visibleRange.length = 0;

  NSR dRect = isV ? (NSR){            0, self.height + _drawOffset, self.width,     0 }
                  : (NSR){ -_drawOffset,                      0,       0, self.height };

  while ( isV ? dRect.origin.y + dRect.size.height > 0 : dRect.origin.x + dRect.size.width < self.width) {

    NSI actualIDX = AZMaxRange(_visibleRange);
    CGF      span = [self spanOfObjectAtIndex:actualIDX];
    NSO * drawObj = [self.storage normal:actualIDX];

    dRect = isV ?         AZRectExceptHigh(dRect, span) :           AZRectExceptWide(dRect,span);
    dRect = isV ? AZRectVerticallyOffsetBy(dRect,-span) : AZRectHorizontallyOffsetBy(dRect,span);


    CAL *sub; sub = [_list.sublayers objectOrNilAtIndex:_visibleRange.length] ?: ({
      [_list addSublayer:sub = [CAL layerWithFrame:dRect mask: isV ? kCALayerWidthSizable : kCALayerHeightSizable]];
      //        [sub disableActionsForKeys:@[@"bounds",@"position",kCAOnOrderIn,kCAOnOrderOut]];
//      [sub disableResizeActions];
      [sub setNeedsDisplayOnBoundsChange:YES];
      sub.anchorPoint = AZAnchorTop;
      sub;
    });
    if (!SameString(sub.name, AZRangeToString(_visibleRange))) {
      sub.name = AZRangeToString(_visibleRange);
      sub.constraints = @[!_visibleRange.length ? AZConstRelSuperScaleOff(kCAConstraintMaxY, 1, _drawOffset)
                                                : AZConstAttrRelNameAttrScaleOff(kCAConstraintMaxY,AZRangeToString((RNG){_visibleRange.location,_visibleRange.length - 1}), kCAConstraintMinY, 1, 0)];


      //        [drawObj addObserverForKeyPath:@"span" task:^(id sender) { [sub setBoundsHeight:[sender span]]; }];
      [sub b:@"bounds.size.height" tO:drawObj wKP:@"span" t:^id(id value) { XX(value); return value; }];
      [sub setLayerActionBlock:^id<CAAction>(CAL *l, NSS *k) {

        return [@[@"bounds"] containsObject:k] ? [CABasicAnimation animationWithKeyPath:k andDuration:3 andSet:nil] : nil;
      }];
      [sub setDrawInContextBlk:^(CAL* x) { NSLog(@"Drawing %@! Sidx:%lu", x.name, x.siblingIndex);

        if(drawObj.drawBlock) drawObj.drawBlock(drawObj,x.bounds);//AZRectFromSizeOfRect(dRect)) : NSLog(@"missing drawBlock %@ for %@", AZStringFromRect(x.bounds),drawObj);

        NSAS *info = $(@"sIDX:%ld aIDX:%ld nrmIDX:%lu exp:%@ pos:%@", x.siblingIndex, actualIDX, [self.storage normalizedIndex:actualIDX], StringFromBOOL(drawObj.expanded), AZString(x.position)).attributedWithDefaults;
        [info drawInRect:x.bounds aligned:AZBtmRgt backgroundColor:((NSC*)drawObj).contrastingForegroundColor];

        NSFrameRectWithWidthWithColor(x.bounds,drawObj.expanded ? 3 :1,drawObj.expanded ? RED : WHITE);
        //          NSRectFillWithColor(AZCenterRectOnPoint(AZRectFromDim(20), x.position), RED);// AZRectInsideRectOnEdge(AZRectFromDim(20), l.bounds, AZTop), RED);
      }];
    }
//    [sub setFrameImmediately:dRect];
    _visibleRange.length++;
  }

  while (_visibleRange.length < _list.sublayers.count -1) [_list.lastSublayer removeFromSuperlayer];
  [_list setNeedsLayout];
  [_info setNeedsDisplay];
}
*/

//  if (nudge > 0)
//    while (_drawOffset > (nudge = [self spanOfObjectAtIndex:_visibleRange.location])) // List is moving UP!
//      _visibleRange.location++, _drawOffset -= nudge;
//  else
//    while (_drawOffset < (nudge = [self spanOfObjectAtIndex:_visibleRange.location])) // List is moving DOWN!
//      _visibleRange.location--, _drawOffset += nudge;

//- (id) hit:(NSP)p  { NSI hIdx = _visibleRange.location + [_visibleRects indexOfObjectPassingTest:^BOOL(NSVAL*r, NSUI i, BOOL *s) { return *s = NSPointInRect(p,r.rectValue); }];
//
//  return [self.storage normal:hIdx];
//}

//- (void) drawRect:(NSR)r { IF_RETURN(!self.count);  _visibleRects = NSMA.new;
/*
 - (void) layoutSublayersOfLayer:(CALayer*)l { _visibleRange.length = 0;

 AZLOGCMD;
 //  [CATRANNY immediately:^{
 NSR dRect = isVertical(_orientation) ? (NSR){            0, l.height + _drawOffset, l.width,        0 }
 : (NSR){ -_drawOffset,                      0,       0, l.height };


 while ( isVertical(_orientation) ? dRect.origin.y + dRect.size.height > 0 : dRect.origin.x + dRect.size.width < l.width) {

 NSI  actualIDX = AZMaxRange(_visibleRange);
 NSUI normalIDX = [self.storage normalizedIndex:actualIDX];

 CGF span = [self spanOfObjectAtIndex:actualIDX];
 dRect = isVertical(_orientation) ?         AZRectExceptHigh(dRect, span) :           AZRectExceptWide(dRect,span);
 dRect = isVertical(_orientation) ? AZRectVerticallyOffsetBy(dRect,-span) : AZRectHorizontallyOffsetBy(dRect,span);

 NSO* drawObj = [self.storage normal:actualIDX];
 CAL *sub = [l.sublayers objectOrNilAtIndex:_visibleRange.length] ?: ({
 CAL *newSub = [CAL layer];//WithFrame:dRect];
 //        [newSub disableActionsForKeys:@[@"bounds",@"position",kCAOnOrderIn,kCAOnOrderOut]];
 //        [newSub setNeedsDisplayOnBoundsChange:YES];
 //        [newSub setPosition:(NSP){dRect.size.width/2.,dRect.origin.y + dRect.size.height}];
 newSub.anchorPoint = AZAnchorTop;
 [l addSublayer:newSub], newSub;
 });
 if ([sub unsignedIntegerForKey:@"storageIndex"] != actualIDX) {
 sub.name = AZRangeToString(_visibleRange);
 [sub setDrawInContextBlk:^(CAL* x) { NSLog(@"Drawing %@! Sidx:%lu", x.name, x.siblingIndex);

 void(^dBlk)(id,NSR);
 !!(dBlk = drawObj.drawBlock) ? dBlk(drawObj,AZRectFromSizeOfRect(dRect)) : NSLog(@"missing drawBlock %@ for %@", AZStringFromRect(x.bounds),drawObj);

 NSAS *info = $(@"sIDX:%ld aIDX:%ld nrmIDX:%lu exp:%@ pos:%@", x.siblingIndex, actualIDX, normalIDX, StringFromBOOL(drawObj.expanded), AZString(x.position)).attributedWithDefaults;
 NSR iR = AZCornerRectPositionedWithSize(x.bounds, AZBtmRgt, info.size);
 [info drawInRect:iR withContrastingBackground:[(NSC*)drawObj contrastingForegroundColor]];
 NSFrameRectWithWidthWithColor(x.bounds,drawObj.expanded ? 3 :1,drawObj.expanded ? RED : WHITE);
 NSRectFillWithColor(AZCenterRectOnPoint(AZRectFromDim(20), x.position), RED);// AZRectInsideRectOnEdge(AZRectFromDim(20), l.bounds, AZTop), RED);
 }];
 sub[@"storageIndex"] = @(actualIDX);
 }
 [sub setFrame:dRect];
 _visibleRange.length++; //    [_visibleRects addObject:AZVrect(dRect)];
 }
 while (_visibleRange.length < l.sublayers.count -1)
 [l.lastSublayer removeFromSuperlayer];
 //  }];
 XX(l.sublayers.count);
 }
 */



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
 [self b:@"name" tO:self.list wKP:@"storage.@count" t:^id(id v){ return @(self.index).strV;  }];
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
 new.index ? [new addConstraint:AZConstRelAttr(kCAConstraintMaxY,@(new.index -1).strV,kCAConstraintMinY)]
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
//  $(@"%@ pos:%@ %@ EXP:%@", self.name ?: @(self.siblingIndex).strV, AZStringFromPoint(self.position), AZStringFromRect(self.frame), StringFromBOOL(self.expanded));
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
//@interface SansCell : CAL @end
//@implementation SansCell
//- (void) setBounds:(CGR)b { [super setBounds:b];
//  if (self.frameMinY > self.superlayer.boundsMaxX || self.frameMinY < self.superlayer.boundsMinY) [self removeFromSuperlayer];
//}
//@end
