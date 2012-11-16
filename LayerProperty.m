/*
	 Animate custom property example:
 
	CGFloat currentProgress = 1.0;
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"currentProgress"];
	anim.duration = 0.5;
	anim.fromValue = @0;
	anim.toValue = @(currentProgress);
	anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

	[myLayer addAnimation:anim forKey:@"animateProgress"];

	myLayer.currentProgress = currentProgress;
*/


#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import <AtoZ/AtoZ.h>
#import "SansNib.h"

/*@interface MyLayer : CALayer
@property (nonatomic, readwrite, assign) CGFloat currentProgress;
//@property (nonatomic, assign)	CGFloat		currentProgress;
@end


@implementation MyLayer

@dynamic currentProgress;

- (id)init {
    self = [super init];
    if (self) {
		[self setValuesForKeysWithDictionary:@{@"c":RANDOMCOLOR, @"bg":RANDOMCOLOR}];
		self.currentProgress= 0;
		self.delegate=self;
      [self setNeedsDisplay];
    }
    
    return self;
}

//- (id)initWithLayer:(id)layer {
//  self = [super initWithLayer:layer];
//  [self setCurrentProgress:[(MyLayer*)layer currentProgress]];
//  return self;
//}


+ (BOOL)needsDisplayForKey:(NSString *)key {
  if ([key isEqualToString:@"currentProgress"]) {
    return YES;
  }
  return [super needsDisplayForKey:key];
}

- (id < CAAction >)actionForKey:(NSString *)key {
  if ([self presentationLayer] != nil) {
    if ([key isEqualToString:@"currentProgress"]) {
      CABasicAnimation *anim = [CABasicAnimation
                                animationWithKeyPath:@"currentProgress"];
      anim.fromValue = [[self presentationLayer] 
                        valueForKey:@"currentProgress"];
      anim.duration = 2;
	  return anim;
    }
  }

  return [super actionForKey:key];
}



//- (void)setCurrentProgress:(CGF)progress {
//	// Force redraw outside of animations
//	self.currentProgress += 20;
////	[self setNeedsDisplay];
//}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
	[NSGraphicsContext drawInContext:ctx flipped:YES actions:^{

		NSRectFillWithColor(layer.frame,self[@"c"]);
		NSP pnt = AZCenterOfRect(layer.frame);
		NSBezierPath *path = [NSBezierPath bezierPathWithTriangleInRect:AZCenterRectOnPoint(AZRectFromDim(100), pnt) orientation:AMTriangleRight];

		NSAffineTransform *t = [NSAffineTransform transformRotatingAroundPoint:pnt byDegrees:self.currentProgress];

		[path transformUsingAffineTransform:t];
		path.lineWidth = self.currentProgress / 360 * 20;
		[path drawWithFill:self[@"bg"] andStroke:RANDOMCOLOR];
	}];
}

//- (id) init {
//	if (!(self = [super init])) return nil;
//	self.delegate = self;
//	return self;
//}
//- (id)initWithLayer:(id)layer {
//	if ((self = [super initWithLayer:layer])) {
//		if ([layer isKindOfClass:[MyLayer class]]) {
//			// Copy custom property values between layers
//			MyLayer *other = (MyLayer *)layer;
//			self.currentProgress = other.currentProgress;
//		}
//	}
//	return self;
//}

@end

/*
Animate custom property example:

double currentProgress = 1.0;
CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"currentProgress"];
anim.duration = 0.5;
anim.fromValue = [NSNumber numberWithDouble:0.0];
anim.toValue = [NSNumber numberWithDouble:currentProgress];
anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

[myLayer addAnimation:anim forKey:@"animateProgress"];

myLayer.currentProgress = currentProgress;

#import <AtoZ/AtoZ.h>
#import <QuartzCore/QuartzCore.h>

@interface MyLayer : CALayer
@property (nonatomic, assign)	NSI spot;
@end


@implementation MyLayer

+ (BOOL)needsDisplayForKey:(NSString *)key {
    // To force animation when our custom properties change
	return [key containsAnyOf:@[@"spot", @"strokeWidth"]] ?:
		   [super needsDisplayForKey:key];
}

- (id) initWithLayer:(id)layer {
	if(self = [super initWithLayer:layer]) {
		if([layer isKindOfClass:[CircleLayer class]]) {
			CircleLayer *other = (CircleLayer*)layer;
			self.radius = other.radius;
			self.strokeWidth = other.strokeWidth;
		}
	}
	return self;
}


- (void)setCurrentProgress:(double)progress {
	// Force redraw outside of animations
	currentProgress = progress;
	[self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)c {
	// Custom layer drawing
}

- (id)initWithLayer:(id)layer {
	if ((self = [super initWithLayer:layer])) {
		if ([layer isKindOfClass:[MyLayer class]]) {
			// Copy custom property values between layers
			MyLayer *other = (MyLayer *)layer;
			self.currentProgress = other.currentProgress;
		}
	}
	return self;
}

@end*/
