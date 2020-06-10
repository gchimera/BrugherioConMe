//
//  PromozioniVC.h
//  BrugherioConMe
//
//  Created by Silvia Pessini on 02/10/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"


@interface PromozioniVC :  UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tb;
    
    sqlite3    *database;
    NSMutableArray *filteredListContent;
    it_ariescomunicazioneAppDelegate *appDelegate;
    
}

@property (nonatomic, retain) NSMutableArray *filteredListContent;
//@property (strong, nonatomic) splitViewDetailViewController *detailViewController;

@end
