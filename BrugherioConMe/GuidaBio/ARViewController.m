//
//  ARViewController.m
//  ARKitDemo
//
//  Modified by Niels W Hansen on 12/31/11.
//  Copyright 2011 Agilite Software. All rights reserved.
//

#import "ARViewController.h"
#import "AugmentedRealityController.h"
#import "GEOLocations.h"
#import "MarkerView.h"
#import "ContentManager.h"

@implementation ARViewController

@synthesize agController;
@synthesize delegate;

-(id)initWithDelegate:(id<ARLocationDelegate>) aDelegate {
	
	[self setDelegate:aDelegate];
	
	if (!(self = [super init]))
		return nil;
	
	[self setWantsFullScreenLayout: YES];
    
 	return self;
}

- (void)loadView {
    
	AugmentedRealityController*  arc = [[AugmentedRealityController alloc] initWithViewController:self withDelgate:self];
	
	[arc setDebugMode:NO];
	[arc setScaleViewsBasedOnDistance:NO];
	[arc setMinimumScaleFactor:0.8];
	[arc setRotateViewsBasedOnPerspective:NO];
    [arc updateDebugMode:![arc debugMode]];
    
    //UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-30, 60, 30)];
    UIButton *closeBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [closeBtn setFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 30)];
    [closeBtn setTitle:@"Torna alle mappe" forState:UIControlStateNormal];
    //[closeBtn setTintColor:[UIColor colorWithRed:20.0/255 green:106.0/255 blue:57.0/255 alpha:1];
    [closeBtn setTintColor:[UIColor blackColor]];
    [closeBtn sizeToFit];
    [closeBtn addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:closeBtn];
    
    //[closeBtn release];
	
	GEOLocations* locations = [[GEOLocations alloc] initWithDelegate:delegate];
	
	if ([[locations returnLocations] count] > 0) {
		for (ARGeoCoordinate *coordinate in [locations returnLocations]) {
			MarkerView *cv = [[MarkerView alloc] initForCoordinate:coordinate withDelgate:self] ;
            [coordinate setDisplayView:cv];
            
			[arc addCoordinate:coordinate];
			[cv release];
		}
	}
    
    [self setAgController:arc];
    [arc release];
	[locations release];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self setAgController:nil];
    [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

-(void) didTapMarker:(ARGeoCoordinate *) coordinate {
    NSLog(@"delegate worked click on %@", [coordinate title]);
    [delegate locationClicked:coordinate];
    
}

-(void) didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@"Heading Updated");

}
-(void) didUpdateLocation:(CLLocation *)newLocation {
    NSLog(@"Location Updated");

}
-(void) didUpdateOrientation:(UIDeviceOrientation) orientation {
    NSLog(@"Orientation Updated");
    
    if (orientation == UIDeviceOrientationPortrait)
        NSLog(@"Protrait");

}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [agController release];
	agController = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
