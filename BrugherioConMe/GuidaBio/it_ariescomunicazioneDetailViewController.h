//
//  it_ariescomunicazioneDetailViewController.h
//  ConMeBrugherio
//
//  Created by Silvia Pessini on 24/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PuntoVendita.h"
#import "Promozioni.h"

@protocol SubstitutableDetailViewController
@property (nonatomic,retain) UIBarButtonItem *navigationPaneBarButtonItem;
@end


@interface it_ariescomunicazioneDetailViewController : UIViewController<UISplitViewControllerDelegate>

@property(nonatomic,assign) IBOutlet UIViewController<SubstitutableDetailViewController> *detailViewcontroller;

@property IBOutlet UIImageView *imgvw;

@property(nonatomic,retain) UIPopoverController *navigationPopoverController;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic,retain) PuntoVendita* CurPV;
@property (nonatomic,retain) Promozioni* prm;

-(void)mostrapdv;

-(void)mostrapromozione:(Promozioni*) promo;

@end
