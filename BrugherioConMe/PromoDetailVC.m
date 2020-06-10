//
//  PromoDetailVC.m
//  BrugherioConMe
//
//  Created by Silvia Pessini on 02/10/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import "PromoDetailVC.h"
#import "Promozioni.h"


@interface PromoDetailVC ()

@end

@implementation PromoDetailVC
@synthesize TitolopromoLB,prm,filteredListContent,ListContent, SottotitolopromoTW,imgview;


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
    [super viewDidLoad];
    
    appDelegate = (it_ariescomunicazioneAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    filteredListContent= [Promozioni getPromozioni:[appDelegate getDBPath]];
    ListContent =  [Promozioni getPromozioni:[appDelegate getDBPath]];
    
    TitolopromoLB.text=prm.titoloPuntov;
    SottotitolopromoTW.text=prm.testo;
    
    
// Carica foto da db
     UIImage *tableImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:prm.Immagine]]];
        [imgview setImage:tableImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
