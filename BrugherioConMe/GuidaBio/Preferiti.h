//
//  Preferiti.h
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "PVDetailController.h"


@interface Preferiti : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tb;
    
    sqlite3    *database;
    it_ariescomunicazioneAppDelegate *appDelegate;
    NSMutableArray *filteredListContent;
    UITableView *mtview;
    UIButton *btnEdit;
    UIButton *btnEnd;
}
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain) IBOutlet UITableView *mtview;


@end
