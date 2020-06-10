//
//  IpadPuntivenditaViewController.m
//  ConMeBrugherio
//
//  Created by Silvia Pessini on 24/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//


#import "IpadPuntivenditaViewController.h"

@interface IpadPuntivenditaViewController ()

@end

@implementation IpadPuntivenditaViewController


@synthesize splitViewController,mysplitViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];
    
    appDelegate = (it_ariescomunicazioneAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self checkorient];
    
}

-(void)checkorient{
    
    
    if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        [self setlandscape];
    }else{
        [self setportrait];
        
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return YES;
    }else {
        if(interfaceOrientation== UIInterfaceOrientationPortrait || interfaceOrientation== UIInterfaceOrientationPortraitUpsideDown){
            return YES;
        }else{
            return NO;
        }
        
    }
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
								duration:(NSTimeInterval)duration {
    
    
	
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeRight || toInterfaceOrientation ==UIInterfaceOrientationLandscapeLeft) {
        [self setlandscape];
        
    }else{
        
        [self setportrait] ;
        
    }
    
    
}

-(IBAction)swiperight:(UISwipeGestureRecognizer *)sender{
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    //NSLog(@"swipe!!");
    
    //[self addSubview:EicaVC.view atIndex:0];
    //[self presentViewController:Eica animated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    [UIView setAnimationTransition:
     UIViewAnimationTransitionCurlDown
                           forView:self.navigationController.view cache:YES];
    
    
    [UIView commitAnimations];
}

-(void)setlandscape{
    if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        [self setportrait];
        return;
    }
//    UIImage *image =[UIImage imageNamed:@"EICMA_H.png"] ;
//    [img setImage:image];
    // btnPlay.frame=CGRectMake(440, 341, 131, 122);
    //btnTicket.frame=CGRectMake(430, 531, 176, 129);
    
    
}


-(void)setportrait{
    
//    UIImage *image =[UIImage imageNamed:@"EICMA_V.png"] ;
//    [img setImage:image];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //btnPlay.frame=CGRectMake(319, 528, 131, 122);
        //  btnTicket.frame=CGRectMake(296, 761, 176, 129);
    }else{
        //   btnPlay.frame=CGRectMake(25, 25, 91, 82);
        // btnTicket.frame=CGRectMake(120, 345, 88, 65);
        
    }
}


-(IBAction)play:(id)sender{
    
    NSString *videoFilePath = [[NSBundle mainBundle] pathForResource: @"Ancma2011" ofType:@"mp4"];
    
    //MPMoviePlayerController *movie = [[MPMoviePlayerController alloc] init];
    //movie.shouldAutoplay=YES;
    //movie.repeatMode = MPMovieRepeatModeNone;
    //movie.fullscreen=YES;
    //movie.movieSourceType=MPMovieSourceTypeFile;
    //movie.scalingMode=MPMovieScalingModeAspectFit;
    //movie.contentURL=[NSURL fileURLWithPath:videoFilePath];
    
    
    
    // [self.view addSubview:movie.view];
    
    //[movie play];
    
//    movieVC =[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:videoFilePath]];
//    [self presentMoviePlayerViewControllerAnimated:movieVC];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videostop:) name:MPMoviePlayerPlaybackDidFinishNotification object:movieVC.moviePlayer];
//    // movie.movieSourceType= MPMovieSourceTypeFile;
    
    //[movie.view setFrame: CGRectMake(20,20,720,576)];
    
    //[movie setContentURL:videoUrl];
    
    // NSLog(@"Url video: %@", movie.contentURL.absoluteString );
    
    //[movie prepareToPlay];
    
    
    
    
    
}

-(void)videostop:(NSNotification *)notification{
//    [movieVC.moviePlayer stop];
//    movieVC=nil;
    if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        
        // [UIApplication sharedApplication].statusBarOrientation=UIInterfaceOrientationPortrait;
        UIDeviceOrientation devor = [[UIDevice currentDevice] orientation];
        
        if(devor == UIInterfaceOrientationLandscapeLeft || devor == UIInterfaceOrientationLandscapeRight){
        }
        
    }
    
    [self checkorient];
}



-(IBAction)GoTicket:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"http://%@", @"www.eicma.it"]]];
    
}


-(IBAction) GO3d:(id)sender{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        // EICMAIphoneRootViewController *masterViewController = [[EICMAIphoneRootViewController alloc] initWithNibName:@"EICMAIphoneRootViewController" bundle:nil];
//        it_ariescomunicazioneDetailViewController *masterViewController = [[it_ariescomunicazioneDetailViewController alloc] initWithNibName:@"it_ariescomunicazioneDetailViewController_iPad" bundle:nil];
//        UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
        
//        [appDelegate.window setRootViewController: masterNavigationController];
        
        
        
        [appDelegate.window makeKeyAndVisible];
        
        
        
    } else {
        
        
//        it_ariescomunicazioneMasterViewController *masterViewController = [[it_ariescomunicazioneMasterViewController alloc] initWithNibName:@"it_ariescomunicazioneMasterViewController_iPad" bundle:nil];
//        UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
//        masterNavigationController.contentSizeForViewInPopover=CGSizeMake(320,500);
//        
//        it_ariescomunicazioneDetailViewController *detailViewController = [[it_ariescomunicazioneDetailViewController alloc] initWithNibName:@"it_ariescomunicazioneDetailViewController_iPad" bundle:nil];
//        UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    	
        
//    	masterViewController.detailViewController = detailViewController;
        
        
//        self.splitViewController = [[UISplitViewController alloc] init];
//        self.splitViewController.delegate = detailViewController;
//        //self.splitViewController.delegate=mysplitViewController;
//        self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
//        self.splitViewController.presentsWithGesture=NO;
//        
//        [appDelegate.window setRootViewController: self.splitViewController];
//        [appDelegate.window makeKeyAndVisible];
//        
        
        
    }
    
}
@end