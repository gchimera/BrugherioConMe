//
//  it_ariescomunicazioneFirstViewController.h
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categoria.h"
#import "it_ariescomunicazioneDetailViewController.h"

@interface ElencoPDV : UIViewController<UITableViewDataSource, UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>
{
    
    IBOutlet UITableView *tb;
    sqlite3    *database;
    it_ariescomunicazioneAppDelegate *appDelegate;
    NSMutableArray *filteredListContent;
     NSMutableArray *ListContent;
}

@property (strong, nonatomic) it_ariescomunicazioneDetailViewController *detailViewController;

@property (nonatomic, retain) Categoria *CurCat;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain) NSMutableArray *ListContent;
@property(nonatomic,retain) IBOutlet UISearchBar *sbar;

@end
