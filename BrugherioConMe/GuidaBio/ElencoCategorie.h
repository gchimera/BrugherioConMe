//
//  ElencoCategorie.h
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"


@interface ElencoCategorie : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tb;
    
    sqlite3    *database;
    NSMutableArray *filteredListContent;
     it_ariescomunicazioneAppDelegate *appDelegate;
    
}

@property (nonatomic, retain) NSMutableArray *filteredListContent;
//@property (strong, nonatomic) splitViewDetailViewController *detailViewController;

@end
