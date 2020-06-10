//
//  MySplitviewController.m
//  EICMA
//
//  Created by Silvia Pessini on 07/11/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import "CategorieSplitviewController.h"
#import "ElencoCategorie.h"
#import "it_ariescomunicazioneDetailViewController.h"

@interface CategorieSplitviewController()




@end

@implementation CategorieSplitviewController

-(void) viewDidLoad

{
   
    self.splitViewController.presentsWithGesture=NO;
    
     [self checkorient];
    
}

-(void)checkorient{
    
    
    if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        [self setlandscape];
    }else{
        [self setportrait];
        
    }
    
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





-(void)setlandscape{
    if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        [self setportrait];
        return;
    }
    
    
}


-(void)setportrait{
    

    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
 
        
    }else{
      
        
        
    }
}


#pragma mark UISplitViewDelegate


@end
