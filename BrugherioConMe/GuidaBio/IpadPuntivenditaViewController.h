//
//  IpadPuntivenditaViewController.h
//  ConMeBrugherio
//
//  Created by Silvia Pessini on 24/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategorieSplitviewController.h"

@interface IpadPuntivenditaViewController : UIViewController{
     it_ariescomunicazioneAppDelegate *appDelegate;
}


@property (strong, nonatomic) UISplitViewController *splitViewController;
@property (nonatomic,retain) CategorieSplitviewController *mysplitViewController;

@end
