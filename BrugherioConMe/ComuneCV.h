//
//  ComuneCV.h
//  ConMeBrugherio
//
//  Created by Silvia Pessini on 25/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "it_ariescomunicazioneDetailViewController.h"
@interface ComuneCV : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *tb;
    it_ariescomunicazioneAppDelegate *appDelegate;
    NSMutableArray *menulist;
}
   
@end
