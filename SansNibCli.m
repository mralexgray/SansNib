#import <AtoZ/AtoZ.h>
#import <SansNib.h>

int main(int argc, char *argv[]){ @autoreleasepool {

    NSA *runningApps = [NSWorkspace.sharedWorkspace.runningApplications valueForKey:@"localizedName"];

    [SansNib addButton:@"R" block:^{ SansNib.layer.contents = NSIMG.randomFunnyImage; }];
    [SansNib addButton:@"S" block:^{ [SansNib split];                                 }];
    [SansNib addButton:@"H" block:^{ [SansNib.view toggleBoolForKey:@"faded"];        }];
    [SansNib addButton:@"I" block:^{ /*AvailableIcons();*/                            }];
    [SansNib addButton:@"T" block:^{ [SansNib addTableForObjects:runningApps];        }];

    [AZNOTCENTER observeName:NSTableViewSelectionDidChangeNotification usingBlock:^(NSNotification *n) {
      XX([runningApps[[n.object selectedRow]] vFK:@"drawBlock"]);
    }];

    [SansNib addButton:@"+" block:^{ [SansNib addViewWithClass:BBMeshView.class]; }];
    [SansNib addButton:@"-" block:^{ IF_CAN_DO(SansNib.view.lastLastSubview,removeFromSuperview); }];

    [SansNib addButton:@"L" block:^{ [Lasso toggle]; }];

    DrawObjectBlock d = ^(id c, NSR r){ NSRectFillWithColor(r,(NSC*)c);
        [$(@"%@ %lu of %lu",((NSC*)c).nameOfColor,((id<Indexed>)c).index,((id<Indexed>)c).indexMax).attributedWithDefaults drawAtPoint:r.origin];
    };
    SansList * list = [SansList viewWithFrame:SansNib.view.bounds mask:NSSIZEABLE];
    NSA*pal = [AtoZ.globalPalette map:^id(NSO* obj) {
      [obj setSpanCollapsed:50 expanded:100];
      [obj setDrawBlock:d];
      return obj;
    }];
//    XX([pal vFK:@"drawBlock"]);
    [list addObjects:pal];
    [SansNib.view addSubview:list];//[AZSimpleView viewWithFrame:SansNib.view.bounds]];
    [SansNib addButton:@"⭕️" block:^{ [list addObjects:[RANDOMPAL arrayBySettingValue:d forObjectsKey:@"drawBlock"]];  }];// ][[SansNib.view firstSubviewOfClass:SansList.class] sV:@(RAND_FLOAT_VAL(10,50)) fK:@"rowHeight"]; }];
    [SansNib addButton:@"🔥" block:^{ [SansNib addViewWithSplit:list]; }];
    [SansNib addButton:@"🐇" block:^{ [SansNib addTableForObjects:((SansList*)[SansNib.view firstSubviewOfClass:SansList.class]).storage]; }];

    [SansNib.eventBlocks addObject:^(NSEvent *e) {
      static CAShapeLayerAuto *zLayer = nil;
      if      (e.type == NSLeftMouseDragged &&  zLayer && zLayer.isHidden) [zLayer fadeIn];
      else if (e.type == NSLeftMouseDragged && !zLayer) {}
    }];
    [SansNib run];
  }
  return 0;
}

/*    [RANDOMPAL do:^(id obj) {
      NSO <DrawableObject>*new = (id)NSO.new;
      new.representedObject = obj;
      new.drawBlock = ^(NSR r){
//      new.associatedDictionary[@"dBlock"] = ^(NSR r){
                                  NSRectFillWithColor(r,obj);
                                  [[obj nameOfColor] drawAtPoint:r.origin withAttributes:NSAS.defaults]; };
      [list addObject:new];
    }];
  */



//    static  CALayer* indi;

//      NSView *hit = [SansNib.view hitTest:e.locationInWindow];
//      if (hit) {
//          NSRect r = AZCornerRectPositionedWithSize(hit.bounds,AZPositionTopRight,AZSizeFromDim(49));
//          if (NSPointInRect([hit convertPoint:e.locationInWindow toView:nil], r)) {
//            [hit.layer addSublayer: indi = indi ?: [CAL layerWithFrame:r drawnUsingBlock:^(CALayer *lll) {
//              NSRectFillWithColor(lll.bounds,RANDOMCOLOR);
//            }]];
//            indi.frame = r;
//  //          if ( doesNotContainObject:indi]) [hit.layer addSublayer:indi];
//        }
//        else indi ? [indi removeFromSuperlayer] : nil;
//      }


//        NSV *v = SansNib.view.lastSubview;
//        CAL  *vLayer =  v.layer ?: (v.layer = CAL.layer, v.wantsLayer = YES, v.layer);
//        zLayer = [CAShapeLayerAuto layerWithFrame:v.bounds];
//        zLayer.zPosition = 10000;
//        zLayer.fillColor = [BLACK alpha:.6].CGColor;
//        zLayer.lineWidth   = 5;
//        zLayer.strokeColor = cgBLACK;
//        zLayer.lineDashPattern = @[@59,@50,@49,@55];
//        zLayer.pathForRect = ^NSBP*(CAShapeLayerAuto  *frmer){ return [NSBP bezierPathWithRect:AZInsetRect(frmer.frame,2.6)]; };
//        zLayer.path = [NSBP bezierPathWithRect:AZInsetRect(zLayer.bounds,2.6)].CGPath;
//        zLayer.opacity = 0;
//        [vLayer addSublayer:zLayer];
//        [zLayer fadeIn];
//        XX(@"YAY");
  //  [CABlockDelegate delegateFor:SansNib.layer ofType:CABlockTypeDrawInContext withBlock:^(CALayer *l) {
  //
  //    NSBP* p = [NSBP bezierPathWithRect:l.bounds];
  //    [p fillWithColor:WHITE];
  //    [p bezel];
  //
  //    [p strokeWithColor:WHITE andWidth:.5 inside:l.bounds];
  //  }];
//    NSW* w = [CAL debugTest];



//    if (_window.inLiveResize) [zLayer redrawPath];    XX(l);
//    if (!ISA(l,CASHL.class)) return;
//    l.position = AZCenterOfRect(l.frame);
//    l.anchorPoint = AZAnchorCenter;
//    CABasicAnimation * animation =  [CABA animationWithKeyPath:@"transform.rotation.z"];
//    animation.toValue = @(DEG2RAD(360));
//    [l addAnimation:animation forKey:nil];
//    if (!l || l == self.class.layer){ //_view.superview.layer) {
//      NSBeep();
//      [self.class.layer animate:@"opacity" toFloat:0 time:2 completion:^{
//        [self.class.layer animate:@"opacity" toFloat:1 time:1];
//      }];
//    }
//    if (e.type == NSLeftMouseUp && zLayer && !zLayer.isHidden) [zLayer fadeOut];



//  [NSThread performBlock:^{
//  } afterDelay:5];
//  [SansNib tableForArray:NSIMG.monoIcons];
//  id x = [SansNib performSelector:NSSelectorFromString(@"simpleView")];
//  XX(x);  XX(NSStringFromClass([x class]));
//  [SansNib]
// From here to end of file added by Injection Plugin //

//#ifdef DEBUG
//static char _inMainFilePath[] = __FILE__;
//static const char *_inIPAddresses[] = {"127.0.0.1", "10.0.1.100", NULL};
//
//#define INJECTION_ENABLED
//#import "/Users/localadmin/Library/Application Support/Developer/Shared/Xcode/Plug-ins/InjectionPlugin.xcplugin/Contents/Resources/BundleInjection.h"
//#endif
//    [SansNib addTableForObjects:[[[@"A" valueForKey:@"classProxy"] valueForKey:@"NSString"] valueForKey:@"badWords"]];
//static void __attribute__ ((constructor)) setProjectName(void) { setenv("PROJECT_NAME", "SansNib", 0); }
//  id (^palette)(NSA*) = ^id(NSA* pal) { return [pal map:^id(id<Indexed>c) { AZBlockObj(c,_c);
//      return c[@"drawBlock"] = ^(NSR r){ NSRectFillWithColor(r,(NSC*)_c);
//
//          [$(@"%@ %lu of %lu",((NSC*)_c).nameOfColor,_c.index,_c.indexMax).attributedWithDefaults drawAtPoint:r.origin];
//      }, c;
//    }];
//  };
