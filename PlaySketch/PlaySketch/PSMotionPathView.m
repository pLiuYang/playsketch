/*
 
 --------------
 Copyright 2012 Singapore Management University
 
 This Source Code Form is subject to the terms of the
 Mozilla Public License, v. 2.0. If a copy of the MPL was
 not distributed with this file, You can obtain one at
 http://mozilla.org/MPL/2.0/.
 --------------
 
 */

#import "PSMotionPathView.h"
#import "PSDrawingGroup.h"

@interface PSMotionPathView ()
@property(nonatomic,retain) NSMutableDictionary* paths; // Group -> Bezier path
@end

@implementation PSMotionPathView
@synthesize paths;

- (void) awakeFromNib
{
	self.paths = [NSMutableDictionary dictionary];
	

	// We need to correct the coordinate system of this view to match the others
	// It should be centred on 0,0 (by offsetting its bounds)
	self.bounds = CGRectMake(-self.bounds.size.width/2.0,
							 -self.bounds.size.height/2.0,
							 self.bounds.size.width,
							 self.bounds.size.height);

	// We also need to fix up the frame, since we are the child of a view which
	// has also made these corrections already (this is hacky)
	self.frame = CGRectMake(-self.frame.size.width/2.0,
						   -self.frame.size.height/2.0,
							self.frame.size.width,
							self.frame.size.height);

}

- (void)drawRect:(CGRect)rect
{
	// Draw all of our bezier paths
	[[UIColor colorWithWhite:0.3 alpha:0.5] setStroke];
	
	for (NSString* key in self.paths)
	{
		[[self.paths objectForKey:key] stroke];
	}
}


- (void) addLineForGroup:(PSDrawingGroup*)group
{
	// Bail if we have a group with no positions!
	if ( group.positionCount < 1 ) return;
	
	// Create a Bezier Path to represent the group
	UIBezierPath* newPath = [UIBezierPath bezierPath];
	CGFloat lineDash[] = { 10.0f, 5.0f };
	[newPath setLineDash:lineDash count:2 phase:0];
	[newPath setLineCapStyle:kCGLineCapRound];
	
	// Pick a point (in the group's co-ordinates) to tranform into the parent co-ords
	CGPoint linePoint = CGPointMake(0,0);
	

	SRTPosition* positions = group.positions;
	int positionCount = group.positionCount;

	for (int i = 0; i < positionCount; i++)
	{
		CGAffineTransform transform = (SRTPositionToTransform(positions[i]));
		CGPoint transformedPoint = CGPointApplyAffineTransform(linePoint, transform);

		if( i == 0 )
			[newPath moveToPoint:transformedPoint];
		else
			[newPath addLineToPoint:transformedPoint];
	}
	
	[self.paths setObject:newPath forKey:group.objectID];
	[self setNeedsDisplay];
}

@end
