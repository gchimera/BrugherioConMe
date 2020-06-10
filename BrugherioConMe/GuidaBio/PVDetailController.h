//
//  PVDetailController.h
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PuntoVendita.h"
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>


@protocol EICMAModalImagesDelegate <NSObject>

-(void) done;

@end


@interface PVDetailController : UIViewController<MFMailComposeViewControllerDelegate>{
    it_ariescomunicazioneAppDelegate * appDelegate;
        NSMutableArray *images;
    
}

@property (nonatomic,retain) PuntoVendita* CurPV;
@property  (nonatomic, strong) IBOutlet UILabel * labelTitle;
@property  (nonatomic, strong) IBOutlet UILabel * labelTitle2;
@property (nonatomic, strong) IBOutlet UILabel * labelIndirizzo;
@property (nonatomic, strong) IBOutlet UIScrollView * scview;
@property (nonatomic, strong)  IBOutlet UIButton * buttonFavorites;
@property (nonatomic, strong)  IBOutlet UIButton * buttonEmail;
@property (nonatomic, strong)  IBOutlet UIButton * buttonWWW;
@property (nonatomic, strong)  IBOutlet UIButton * buttonCALL;
@property (nonatomic, strong) IBOutlet  UIButton * buttonFB;
@property (nonatomic, strong) IBOutlet  UIButton * buttonTW;
@property (nonatomic, strong) IBOutlet  UIButton * buttonAddContact;
@property (nonatomic, strong)  IBOutlet MKMapView * mapView;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *sharebut;
@property  (nonatomic, strong) IBOutlet UIButton * buttonFax;
@property (nonatomic, strong) IBOutlet UITextView *testo;
@property  (nonatomic, strong) IBOutlet UITextView *aperturaLB;
@property (nonatomic, strong) IBOutlet UITextView *note;
@property (nonatomic, retain) IBOutlet UIImageView *imgview;
@property (nonatomic,assign) id<EICMAModalImagesDelegate> delegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *giragira;

@property (nonatomic, retain) IBOutlet UIImage *toolb;

@property (nonatomic, retain) IBOutlet UINavigationBar *navbar;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar2;

@property (nonatomic, assign)double latitudine;
@property  (nonatomic, assign)double longitudine;
-(IBAction)showpopover:(id) sender;
-(IBAction)closeme:(id) sender;

-(IBAction)AddFavourite:(id) sender;
-(IBAction)GoWW:(id) sender;
-(IBAction)GoPhone:(id) sender;
-(IBAction)goEmail:(id) sender;
@end
