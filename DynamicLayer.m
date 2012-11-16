//
//  DynamicLayer.m
//  SansNib
//
//  Created by Alex Gray on 10/27/12.
//
//


#import "DynamicLayer.h"

@implementation DynamicView

-(id) initWithFrame:(NSRect)frameRect
{
    if (!(self = [super initWithFrame:frameRect])) return nil;
	_root 			= [DynamicLayer layer];
	_root.bgC 		= cgPURPLE;
	self.layer 		= _root;
	self.wantsLayer = YES;
	NSButton *b 	= [[NSButton alloc]initWithFrame:AZRectFromDim(50)];
	[b setAction:@selector(animate) withTarget:_root.delegate];
	[self addSubview:b];
	return self;
//	[_root setNeedsDisplay];
//	_root.delegate = self;
}

//- (void) drawRect:(NSRect)dirtyRect{}
@end

@interface DynamicLayer ()
//@property (nonatomic, assign) CGFloat thickness;
@end

@implementation DynamicLayer

@dynamic thickness;

+ (BOOL) needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString: @"thickness"])
        return YES;
    return [super needsDisplayForKey:key];
}

- (void) drawInContext:(CGContextRef)ctx
{
	[NSGraphicsContext drawInContext:ctx flipped:NO actions:^{
		NSBP* h = [NSBP bezierPathWithRect:AZInsetRect(self.bounds, 20)];
		[h setLineWidth:self.thickness];
		[h drawWithFill:RANDOMCOLOR andStroke:BLACK];
//		NSRectFillWithColor(AZInsetRect(self.bounds, 20), RANDOMCOLOR);
//
//    CGRect r = CGRectInset(self.bounds, 20, 20);
//    CGContextSetFillColorWithColor(con, cgORANGE);
//    CGContextFillRect(con, r);
//    CGContextSetLineWidth(con, self.thickness);
//    CGContextStrokeRect(con, r);
		}];
}
@end



//- (void) animate {
//    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"thickness"];
//    ba.toValue = @100;
//	ba.duration = 5;
//    ba.autoreverses = YES;
//    [_root addAnimation:ba forKey:nil];
//}
//- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
//{
//	CGRect r = CGRectInset(self.bounds, 20, 20);
//    CGContextSetFillColorWithColor(ctx, cgORANGE);
//    CGContextFillRect(ctx, r);
//    CGContextSetLineWidth(ctx, self.root.thickness);
//    CGContextStrokeRect(ctx, r);
//
//}
