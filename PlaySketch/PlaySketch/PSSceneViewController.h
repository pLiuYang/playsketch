/*
 
 --------------
 Copyright 2012 Singapore Management University
 
 This Source Code Form is subject to the terms of the
 Mozilla Public License, v. 2.0. If a copy of the MPL was
 not distributed with this file, You can obtain one at
 http://mozilla.org/MPL/2.0/.
 --------------
 
 */

#import <UIKit/UIKit.h>
#import "PSDrawingEventsView.h"
#import "PSSRTManipulator.h"
#import "PSPenColorViewController.h"
#import "PSPhysicsGlobalViewController.h"
#import "PSPhysicsStateViewController.h"
#include <Box2D.h>

@class PSAnimationRenderingController, PSDrawingDocument, PSTimelineSlider, PSGroupOverlayButtons, PSMotionPathView, PSKeyframeView;

@interface PSSceneViewController : UIViewController <PSDrawingEventsViewDrawingDelegate, 
														PSSRTManipulatoDelegate,
														PSPenColorChangeDelegate,
                                                        PSPhysicalGlobalChangeDelegate,
                                                        PSPhysicalStateChangeDelegate>

@property(nonatomic,retain) IBOutlet PSAnimationRenderingController* renderingController;
@property(nonatomic,retain) IBOutlet PSDrawingEventsView* drawingTouchView;
@property(nonatomic,retain) IBOutlet UIButton* playButton;
@property(nonatomic,retain) IBOutlet PSTimelineSlider* timelineSlider;
@property(nonatomic,retain) IBOutlet PSKeyframeView* keyframeView;
@property(nonatomic,retain) IBOutlet PSGroupOverlayButtons* selectionOverlayButtons;
@property(nonatomic,retain) IBOutlet PSMotionPathView* motionPathView;
@property(nonatomic,retain) IBOutlet PSSRTManipulator* manipulator;
@property(nonatomic,retain) IBOutlet UIButton* startSelectingButton;
@property(nonatomic,retain) IBOutlet UIButton* startDrawingButton;
@property(nonatomic,retain) IBOutlet UIButton* startErasingButton;
@property(nonatomic,retain) IBOutlet UIButton* undoButton;
@property(nonatomic,retain) IBOutlet UIButton* redoButton;
@property(nonatomic,retain) IBOutlet UIButton* debugDrawButton;
@property(nonatomic,retain) PSDrawingDocument* currentDocument;
@property(nonatomic,retain) PSDrawingGroup* rootGroup;
@property b2World* world;

- (IBAction)dismissSceneView:(id)sender;
- (IBAction)playPressed:(id)sender;
- (IBAction)timelineScrubbed:(id)sender;
- (IBAction)toggleRecording:(id)sender;
- (IBAction)exportAsVideo:(id)sender;
- (IBAction)snapTimeline:(id)sender;
- (IBAction)showPenPopover:(id)sender;
- (IBAction)startSelecting:(id)sender;
- (IBAction)startDrawing:(id)sender;
- (IBAction)startErasing:(id)sender;
- (IBAction)deleteCurrentSelection:(id)sender;
- (IBAction)createGroupFromCurrentSelection:(id)sender;
- (IBAction)ungroupFromCurrentSelection:(id)sender;
- (IBAction)markCurrentSelectionVisible:(id)sender;
- (IBAction)markCurrentSelectionNotVisible:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)redo:(id)sender;
- (IBAction)drawDebugShape:(id)sender;
- (void)setPlaying:(BOOL)playing;

// physical system
- (IBAction)showPhysicsStatePopover:(id)sender;
- (IBAction)showPhysicsGlobalPopover:(id)sender;
- (NSMutableArray*)IterativeSimplify:(NSMutableArray*)vertices targetLowNumOfV:(int)tl targetHighNumOfV:(int)th ErrThresholdL:(float)etl ErrThresholdH:(float)eth increment:(int)i;
- (NSMutableArray*)Simplify:(NSMutableArray*)vertices ErrThreshold:(float)et;

@end
