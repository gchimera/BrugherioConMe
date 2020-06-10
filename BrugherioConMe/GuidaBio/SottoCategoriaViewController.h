//
//  SottoCategoriaViewController.h
//  ConMeBrugherio
//
//  Created by Silvia Pessini on 20/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"


@interface SottoCategoriaViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
     IBOutlet UITableView *tb;
    
    sqlite3 *database;
    NSMutableArray *filteredListContent;
    it_ariescomunicazioneAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic) NSInteger *ID_padre;



@end
