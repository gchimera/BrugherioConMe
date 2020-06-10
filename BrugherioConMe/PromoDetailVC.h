//
//  PromoDetailVC.h
//  BrugherioConMe
//
//  Created by Silvia Pessini on 02/10/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promozioni.h"
#import "sqlite3.h"

@interface PromoDetailVC : UIViewController <UISplitViewControllerDelegate>

{
    sqlite3    *database;
    it_ariescomunicazioneAppDelegate *appDelegate;
    NSMutableArray *images;
}

@property (nonatomic, retain) IBOutlet UILabel *TitolopromoLB;
@property (nonatomic, retain) IBOutlet UITextView *SottotitolopromoTW;

@property (nonatomic, retain) IBOutlet UIImageView *imgview;

@property Promozioni *prm;


@property NSMutableArray *filteredListContent;
@property  NSMutableArray *ListContent;




@end
