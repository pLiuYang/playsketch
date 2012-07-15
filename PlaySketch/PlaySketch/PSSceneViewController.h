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
@class PSAnimationRenderingController;
@class PSDrawingDocument;


@interface PSSceneViewController : UIViewController

@property(nonatomic,retain)IBOutlet PSAnimationRenderingController* renderingController;
@property(nonatomic,retain)PSDrawingDocument* currentDocument;

-(IBAction)play:(id)sender;
@end
