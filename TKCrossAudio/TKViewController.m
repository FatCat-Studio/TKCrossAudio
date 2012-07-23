//
//  TKViewController.m
//  TKCrossAudio
//
//  Created by Timofey Korchagin on 23/07/2012.
//  Copyright (c) 2012 MIPT. All rights reserved.
//

#import "TKViewController.h"

@interface TKViewController ()

@end

@implementation TKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	audioTracksBuffers = [NSMutableArray arrayWithCapacity:10];
    
    // Initialize the OpenAL device and context here so that it doesn't happen
	// prematurely.
	
	// We'll let OALSimpleAudio deal with the device and context.
	// Sbince we're not going to use it for playing effects, don't give it any sources.
	[OALSimpleAudio sharedInstance].reservedSources = 0;
    
    // You could do all mp3 or any other format supported by iOS software decoding.
    // Any format requiring the hardware will only work on the first track that starts playing.
    
    [self bufferTrack:@"shelby_startup_Starter3.wav"];
    [self bufferTrack:@"firebird_idle.wav"];
    [self bufferTrack:@"firebird_onlow.wav"];
    [self bufferTrack:@"firebird_offlow.wav"];
    [self bufferTrack:@"firebird_onmid.wav"];
    [self bufferTrack:@"firebird_offmid.wav"];
    [self bufferTrack:@"firebird_onhigh.wav"];
    [self bufferTrack:@"firebird_offhigh.wav"];
//    [self bufferTrack:@"HappyAlley.caf"];
//    [self bufferTrack:@"PlanetKiller.mp3"];
//    [self bufferTrack:@"ColdFunk.caf"];
    
    firstSource = [ALSource source];
    secondSource = [ALSource source];
    
    slider.maximumValue = [audioTracksBuffers count] - 1.001;
    slider.value = 0;

}

-(void) bufferTrack:(NSString*) filename
{
    ALBuffer *trackBuffer = [[OpenALManager sharedInstance] bufferFromFile:filename reduceToMono:YES];
	[audioTracksBuffers addObject:trackBuffer];
}

-(IBAction)slider:(id)sender{
    float vMod = slider.value - ((int)slider.value);
    ALBuffer *firstBuffer = [audioTracksBuffers objectAtIndex:((int)slider.value)];
    ALBuffer *secondBuffer = [audioTracksBuffers objectAtIndex:((int)slider.value + 1)];
    
    [firstSource play:firstBuffer loop:YES];
    firstSource.pitch = 1.0f + vMod*0.1;
    firstSource.volume = (1.0f - vMod*vMod)*(slider.value/slider.maximumValue);
	[secondSource play:secondBuffer loop:YES];
    secondSource.pitch = (1.0f - vMod*0.1);
    secondSource.volume = (vMod*vMod)*(slider.value/slider.maximumValue)+1;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
