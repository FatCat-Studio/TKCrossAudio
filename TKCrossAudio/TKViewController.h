//
//  TKViewController.h
//  TKCrossAudio
//
//  Created by Timofey Korchagin on 23/07/2012.
//  Copyright (c) 2012 MIPT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectAL.h"

@interface TKViewController : UIViewController
{
    IBOutlet UISlider *slider;
    
	ALChannelSource* channel;
    
	ALSource* firstSource;
	ALSource* secondSource;
   
    NSMutableArray *audioTracksBuffers;
}

-(IBAction)slider:(id)sender;
@end
