//
//  DynamicLayer.h
//  SansNib
//
//  Created by Alex Gray on 10/27/12.
//
//

#import <QuartzCore/QuartzCore.h>
#import <AtoZ/AtoZ.h>



@interface DynamicLayer : CALayer
@property (nonatomic, assign) CGFloat thickness;
@end

@interface DynamicView : NSView
@property (nonatomic, strong) DynamicLayer *root;
@end
