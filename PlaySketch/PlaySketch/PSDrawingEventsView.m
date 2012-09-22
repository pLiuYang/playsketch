/*
 
 --------------
 Copyright 2012 Singapore Management University
 
 This Source Code Form is subject to the terms of the
 Mozilla Public License, v. 2.0. If a copy of the MPL was
 not distributed with this file, You can obtain one at
 http://mozilla.org/MPL/2.0/.
 --------------
 
 */


#import "PSDrawingEventsView.h"

@implementation PSDrawingEventsView
@synthesize drawingDelegate = _drawingDelegate;
@synthesize currentLine = _currentLine;

-(void)awakeFromNib
{
	CGRect newBounds = self.bounds;
	newBounds.origin = CGPointMake(-self.bounds.size.width/2.0,
									 -self.bounds.size.height/2.0);
	self.bounds = newBounds;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint p = [[touches anyObject] locationInView:self];
	
	//Fetch a line from our delegate to put our touch points into
	if(self.drawingDelegate)
	{
		self.currentLine = [self.drawingDelegate newLineToDrawTo:self];
		[self.currentLine addLineTo:p];
	}
	
	if(self.drawingDelegate)
		[self.drawingDelegate movedAt:p inDrawingView:self];
}		


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	CGPoint p = [touch locationInView:self];
	CGPoint previous = [touch previousLocationInView:self];

	if(self.currentLine)
	{

		[self.currentLine addLineTo:p];
		
		if (self.drawingDelegate)
			[self.drawingDelegate addedToLine:self.currentLine fromPoint:previous toPoint:p inDrawingView:self];
	}
	
	if(self.drawingDelegate)
		[self.drawingDelegate movedAt:p inDrawingView:self];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

	if(self.currentLine)
	{
		if (self.drawingDelegate)
		{
			[self.drawingDelegate finishedDrawingLine:self.currentLine inDrawingView:self];
			[self.currentLine finishLine];
		}
		self.currentLine = nil;
	}

}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	if(self.currentLine)
	{
		if (self.drawingDelegate)
		{
			[self.drawingDelegate finishedDrawingLine:self.currentLine inDrawingView:self];
			[self.currentLine finishLine];
		}
		self.currentLine = nil;	
	}

}

@end
