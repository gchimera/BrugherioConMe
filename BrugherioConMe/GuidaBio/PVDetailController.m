//
//  PVDetailController.m
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import "PVDetailController.h"
#import "AnnotationView.h"
#import "BCDShareSheet.h"
#import "BCDShareableItem.h"
#import "WebImageOpertions.h"
#import <CoreGraphics/CoreGraphics.h>
#import "UIAlertView+Blocks.h"


@interface PVDetailController ()

@end

@implementation PVDetailController

@synthesize CurPV;
@synthesize labelTitle;
@synthesize labelIndirizzo;


@synthesize buttonFavorites;
@synthesize buttonEmail;
@synthesize buttonWWW;
@synthesize buttonCALL;
@synthesize buttonFB;
@synthesize buttonTW;
@synthesize buttonAddContact;
@synthesize mapView;
@synthesize latitudine;
@synthesize longitudine,scview;
@synthesize buttonFax;
@synthesize testo;
@synthesize aperturaLB;
@synthesize note;
@synthesize toolb;
@synthesize imgview,giragira,navbar,labelTitle2, toolbar,toolbar2;

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

    [self CaricaUI];
    scview.contentSize=CGSizeMake(320,450);
    // self.navigationItem.rightBarButtonItem
         if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
          [self.scview setContentSize:CGSizeMake(549,1048)];
    }else{
        [self.scview setContentSize:CGSizeMake(549,505)];
       // [self.navigationController setNavigationBarHidden:FALSE];
        
        navbar.hidden=YES;
           UIImage *img1 = [UIImage imageNamed:@"topb.png"];
        
 [[UINavigationBar appearance] setBackgroundImage:img1 forBarMetrics:UIBarMetricsDefault];
        
        
        [toolbar setBackgroundImage:[UIImage imageNamed:@"topb.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        [toolbar2 setBackgroundImage:[UIImage imageNamed:@"topb.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];

  
}
    
    
  
}

-(void) viewWillAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=YES;
    
}

-(void) CaricaUI{
    labelTitle.text=CurPV.titolo;
    labelTitle2.text=CurPV.titolo;
    labelIndirizzo.text=CurPV.IndirizzoCompleto;
    testo.text=CurPV.testo;
    aperturaLB.text=CurPV.apertura;
    note.text=CurPV.inevidenza;
    
    [buttonFax setTitle:CurPV.fax forState:UIControlStateNormal];
    [buttonCALL setTitle:CurPV.telefono forState:UIControlStateNormal];
    [buttonEmail setTitle:CurPV.email forState:UIControlStateNormal];
    [buttonWWW setTitle:CurPV.sito forState:UIControlStateNormal];

    [self findLatitudeLongitude:CurPV.IndirizzoCompletoUnariga ];
    
    if([CurPV Ispreferito:appDelegate.getDBPath]){
    
        [buttonFavorites setImage:[UIImage imageNamed:@"FullStar"] forState:UIControlStateNormal];
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegati mappa

-(void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated   {
    MKCoordinateRegion region = self.mapView.region;
    NSLog(@"%f", region.span.latitudeDelta);
    NSLog(@"%f", region.span.longitudeDelta);
}



-(void)loadMapViewWithLatitude:(CGFloat)latitudine andLongitude:(CGFloat)longitude{
    NSLog(@"la latitudine è %f", self.latitudine);
    NSLog(@"la longitudine è %f", self.longitudine);
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.latitudine, self.longitudine);
    NSString * address = CurPV.IndirizzoCompleto;
    AnnotationView * annotation = [[AnnotationView alloc]initWithCoordinates:location title:[NSString stringWithFormat:@"%@", self.labelTitle.text]subTitle:[NSString stringWithFormat:@"%@", address ]];
    
    [self.mapView addAnnotation:annotation];
    
    CLLocationCoordinate2D min = CLLocationCoordinate2DMake(self.latitudine -0.001, self.longitudine-0.001);
    
    CLLocationCoordinate2D max = CLLocationCoordinate2DMake(self.latitudine+0.001, self.longitudine+0.001);
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((max.latitude + min.latitude) / 2.0, (max.longitude + min.longitude) / 2.0);
    MKCoordinateSpan span = MKCoordinateSpanMake(max.latitude - min.latitude, max.longitude - min.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    self.mapView.region= region;
    
    
}
-(void) findLatitudeLongitude : (NSString *)address{
    self.latitudine=CurPV.latitudine;
    self.longitudine=CurPV.longitudine;
    
    
    [self loadMapViewWithLatitude:self.latitudine andLongitude:self.longitudine];

//    
//    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
//    
//    [myGeocoder
//     geocodeAddressString:address
//     completionHandler:^(NSArray *placemarks, NSError *error) {
//         
//         if ([placemarks count] > 0 &&
//             error == nil){
//             NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
//             CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
//             NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
//             NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
//             self.latitudine =firstPlacemark.location.coordinate.latitude;
//             self.longitudine =firstPlacemark.location.coordinate.longitude;
//             //[self caricaMappa];
//             NSLog(@"la latitudine è %f", self.latitudine);
//             NSLog(@"la longitudine è %f", self.longitudine);
//             
//             [self loadMapViewWithLatitude:self.latitudine andLongitude:self.longitudine];
//             
//             
//         }
//         else if ([placemarks count] == 0 &&
//                  error == nil){
//             NSLog(@"Found no placemarks.");
//         }
//         else if (error != nil){
//             NSLog(@"An error occurred = %@", error);
//         }
//         
//     }];
//    
    
    
}
-(void) addFoto:(NSString*) Foto
{
    
    if([Foto isEqualToString:@""] || Foto == nil){
        return;
        
    }
    
    NSString *strurl= Foto;
    
    strurl= [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *imgURL =[[NSURL alloc] initWithString:strurl];
    
    NSURLRequest     *req =[NSURLRequest requestWithURL:imgURL];
    NSHTTPURLResponse *resp =nil;
    NSError *err=nil;
    NSData *response =[NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    if ([resp statusCode]== 200){
        
        UIImage *img = [[UIImage alloc] initWithData:response] ;
        ////if(img.size.width > 320){
        //   float perc = (img.size.width / 320);
        //   CGAffineTransform *scale = CGAffineTransformScale(perc,perc);
        
        //   img = [self imageWithImage:img scaledPercent:perc];
        // }
        [images addObject:img];
        
    }
    

    

}

-(void) viewDidAppear:(BOOL)animated
{
        giragira.Hidden=FALSE;
    [giragira startAnimating];
    if([it_ariescomunicazioneAppDelegate   isConnectionAvailable] == YES){
        images = [[NSMutableArray alloc] init];
        
        [self addFoto:CurPV.Foto1];
        [self addFoto:CurPV.Foto2];
        [self addFoto:CurPV.Foto3];
        [self addFoto:CurPV.Foto4];
        [self addFoto:CurPV.Foto5];
        
                   //}
        
        if(images.count > 0){
            // [logo setImage:[UIImage imageWithContentsOfFile:tlogo]];
            imgview.clipsToBounds=YES;
            
            imgview.animationImages= images;
            imgview.animationDuration=15;
            imgview.animationRepeatCount=0;
            [imgview startAnimating];
        }
    }else{
       // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connesione internet assente." message:@"E' necessaria una connessione ad internet per vedere la galleria immagini." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	//	[alert show];
    }
    [giragira stopAnimating];
    giragira.Hidden=TRUE;
    
}


- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    
    self.mapView.mapType = MKMapTypeStandard;
    
    
}

-(IBAction)showpopover:(id) sender{
    BCDShareableItem *item = [[BCDShareableItem alloc] initWithTitle:[NSString stringWithFormat:@"Trova prodotti biologici qui: %@",CurPV.titolo]];
    [item setDescription:CurPV.IndirizzoCompletoUnariga];
    [item setItemURLString:CurPV.sito];

    
    UIActionSheet *sheet = [[BCDShareSheet sharedSharer] sheetForSharing:item completion:^(BCDResult result) {
        if (result==BCDResultSuccess) {
            NSLog(@"Yay!");
        }
    }];
    [sheet showFromBarButtonItem:sender animated:YES];
	}




-(IBAction)closeme:(id) sender{
   // [self dismissModalViewControllerAnimated:YES];
    
    [self dismissModalViewControllerAnimated:YES];
}





-(IBAction) goEmail:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Intendi inviare una mail a: "
                                                    message: CurPV.email
                                                   delegate:nil // Can be another value but will be overridden when showing with handler.
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Si", nil];
    
    [alert show];
    
    [alert showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        
        if (buttonIndex == [alertView cancelButtonIndex]) {
            
            NSLog(@"Hai scelto NO (index %i)", buttonIndex);
            
        } else {
            
             if(CurPV.email.length > 2){
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        
        if([MFMailComposeViewController canSendMail]){
            [mail setToRecipients:[NSArray arrayWithObjects:CurPV.email, nil]];
            [mail setSubject:@"Richiesta di contatto"];
            [mail setMessageBody:@"" isHTML:NO];
            //[self presentModalViewController:mail animated:YES];
            [self presentViewController:mail animated:YES completion:nil];
        }
        
        mail=nil;
    }

            
            NSLog(@"Hai scelto SI (index %i)", buttonIndex);
        }
    }];
    
    
   }


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
	[self dismissViewControllerAnimated:YES completion:nil];
    
	if (result == MFMailComposeResultFailed){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Messaggio non inviato!" message:@"Non è stato possibile inviare la tua e-mail" delegate:self cancelButtonTitle:@"Annulla" otherButtonTitles:nil];
		[alert show];
        
	}
}

-(IBAction) GoPhone:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vuoi chiamare il numero: "
                                                    message: CurPV.telefono
                                                   delegate:nil // Can be another value but will be overridden when showing with handler.
                                          cancelButtonTitle:@"No"
                                        otherButtonTitles:@"Si", nil];

    [alert show];
    
    [alert showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        
        if (buttonIndex == [alertView cancelButtonIndex]) {
            
            NSLog(@"Hai scelto NO (index %i)", buttonIndex);
            
        } else {
                NSString *deviceType = [UIDevice currentDevice].model;
    
    if(CurPV.telefono.length > 2 && [deviceType isEqualToString:@"iPhone"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"tel://%@", CurPV.telefono]]];
    }else{
        UIAlertView *popUp = [[UIAlertView alloc] initWithTitle:@"Telefono"
                                                        message:@"Il dispositivo non supporta questa funzione" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [popUp show];
    }

            NSLog(@"Hai scelto SI (index %i)", buttonIndex);
        }
    }];

    
    
}

-(IBAction) AddFavourite:(id)sender
{
    if( [PuntoVendita AddFavourite:CurPV.ID dbPath:appDelegate.getDBPath] == YES){
        UIAlertView *popUp = [[UIAlertView alloc] initWithTitle:@"Aggiunto ai preferiti correttamente"
                                                        message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
    
        
        [popUp show];
        // [popUp release];
        
    }
}


-(IBAction) GoWW:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Intendi visitare il sito: "
                                                    message: CurPV.sito
                                                   delegate:nil // Can be another value but will be overridden when showing with handler.
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Si", nil];
    
    [alert show];
    
    [alert showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        
        if (buttonIndex == [alertView cancelButtonIndex]) {
            
            NSLog(@"Hai scelto NO (index %i)", buttonIndex);
            
        } else {
            
             if(CurPV.sito.length > 2){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString  stringWithFormat:@"http://%@", CurPV.sito]]];
    }

            NSLog(@"Hai scelto SI (index %i)", buttonIndex);
        }
    }];
    
    
}

    
       


@end
