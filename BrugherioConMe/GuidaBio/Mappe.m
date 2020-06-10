//
//  it_ariescomunicazioneSecondViewController.m
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import "Mappe.h"
#import "AnnotationView.h"
#import "PuntoVendita.h"
#import "AnnotationCustom.h"
#import "MapListViewController.h"
//#import "ARKit.h"
//#import "ARGeoCoordinate.h"
//#import "ContentManager.h"

@interface Mappe ()

@end

@implementation Mappe
@synthesize mapView;
@synthesize locationManager;
@synthesize latitudine;
@synthesize longitudine;
@synthesize coordinate;
@synthesize annotationUser,PDVList,segm,segView;
//@synthesize cameraViewController;
@synthesize infoViewController;
BOOL CentroManuale=NO;
BOOL setted = NO;
MapListViewController *ListViewController;
   NSMutableArray *results;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.title = NSLocalizedString(@"Mappe", @"Mappe");
//    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (it_ariescomunicazioneAppDelegate *)[[UIApplication sharedApplication] delegate];

	// Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc]init];
    
    self.locationManager.desiredAccuracy= kCLLocationAccuracyBest;
    
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone){
        self.locationManager.distanceFilter = 3.0f;
    }else{
          self.locationManager.distanceFilter = 10.0f;
    }
    
      [locationManager startUpdatingLocation];
    
    self.locationManager.delegate = self;
    self.mapView.delegate=self;
    
    self.mapView.zoomEnabled=YES;
    self.mapView.scrollEnabled = YES;
    PDVList = [[NSMutableArray alloc] init];
    [segm setTintColor:[UIColor colorWithRed:20.0/255 green:106.0/255 blue:57.0/255 alpha:1]];
    
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Mappe" image:nil tag:0];
    [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"gps.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"gps.png"]];
}


#pragma mark metodi delegati

- (void) locationManager:(CLLocationManager *) manager
     didUpdateToLocation:(CLLocation *) newLocation
            fromLocation:(CLLocation *) oldLocation {
    
    double oldlat;
    double oldlon;
    
    oldlat=self.latitudine;
    oldlon=self.longitudine;
    
    //—-display latitude—-
    NSString *lat = [[NSString alloc] initWithFormat:@"%f",
                     newLocation.coordinate.latitude];
  
    //self.latitudine = self.latitudine + 0.46693306;
    // NSLog(@"LA latitudine è %f", self.latitudine);
    
    //—-display longitude—-
    NSString *lng = [[NSString alloc] initWithFormat:@"%f",
                     newLocation.coordinate.longitude];
    
    self.latitudine =[lat doubleValue];
    self.longitudine =[lng doubleValue];

    
    self.coordinate = CLLocationCoordinate2DMake(self.latitudine, self.longitudine);
    if(!setted){
    CLLocationCoordinate2D min = CLLocationCoordinate2DMake(self.coordinate.latitude -0.01, self.coordinate.longitude-0.01);
    
    CLLocationCoordinate2D max = CLLocationCoordinate2DMake(self.coordinate.latitude+0.01, self.coordinate.longitude+0.01);
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((max.latitude + min.latitude) / 2.0, (max.longitude + min.longitude) / 2.0);
    MKCoordinateSpan span = MKCoordinateSpanMake(max.latitude - min.latitude, max.longitude - min.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    self.mapView.region= region;

    [mapView setRegion:region animated:YES];
        setted=YES;
        
    }
   // [self.mapView removeAnnotation:self.annotationUser];
    
   // self.annotationUser = [[AnnotationView alloc]initWithCoordinates:self.coordinate title:@"POSIZIONE ATTUALE" subTitle:@""];
    
    //[self.mapView addAnnotation:self.annotationUser];
    
    double spostamento =[self distanceFunc:latitudine lon1:longitudine lat2:oldlat lon2:oldlon];
    NSLog(@"Lo spostamento è %f", spostamento);
    
if(spostamento > 10)
    [self refreshpdvlist];
    
}


-(IBAction)CenterMap:(id)sender{
    CentroManuale=YES;
    [locationManager stopUpdatingLocation];

}


-(void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {

   MKCoordinateRegion  region=self.mapView.region;
         /*
   
    NSLog(@"%f", region.span.latitudeDelta);
    NSLog(@"%f", region.span.longitudeDelta);
   */
}

-(void)refreshpdvlist{
 
    results= [PuntoVendita getPVLatLong:latitudine Long:longitudine dbPath:appDelegate.getDBPath];
    [self.mapView removeAnnotations:PDVList];
    [PDVList removeAllObjects];
    
    
    for (PuntoVendita *p in results){
        CLLocationCoordinate2D coord=CLLocationCoordinate2DMake(p.latitudine, p.longitudine);
        AnnotationCustom *annotationIcone =[[AnnotationCustom alloc] initWithCoordinates:coord title:p.titolo subTitle:p.IndirizzoCompletoUnariga];
     
        
        annotationIcone.nomeTabella = [NSString stringWithFormat:@"%d",p.idcateg ];
        //self.nomeTabella = annotationIcone.nomeTabella;
        annotationIcone.ID = p.ID;
        
        MKMapRect flyTo = MKMapRectNull;
        MKMapPoint annotationPoint = MKMapPointForCoordinate(coord);
        MKMapRect   pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if(MKMapRectIsNull(flyTo)){
            flyTo = pointRect;
        }else {
            flyTo=MKMapRectUnion(flyTo, pointRect);
        }
        
        //aggiungere le immagini
        
        
        [PDVList addObject:annotationIcone];
        }
    
    [self.mapView addAnnotations:PDVList];
    
    //if(viewController){
        
    //    [viewController removeCoordinates:viewController.coordinates];
    
    //}
}


//-(NSMutableArray *)geoLocations;{
//    NSMutableArray *tempLocationArray = [[NSMutableArray alloc] init];
//    
//    CLLocation *tempLocation;
//    ARGeoCoordinate *tempCoordinate;
//    for(AnnotationCustom * a in PDVList){
//        tempLocation = [[CLLocation alloc] initWithLatitude:a.coordinate.latitude longitude:a.coordinate.longitude];
//        tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:a.title];
//      
//        
//        [tempLocationArray addObject:tempCoordinate];
//    }
//    return tempLocationArray;
//    
//   // [viewController addCoordinates:tempLocationArray];
//    
//   // CLLocation *newCenter = [[CLLocation alloc] initWithLatitude:latitudine longitude:longitudine];
//    
//   // viewController.centerLocation = newCenter;
//}


- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    
    self.mapView.mapType = MKMapTypeStandard;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)SegChanghed:(id)sender{
   
    if(segm.selectedSegmentIndex==0){
        
        if(infoViewController){
            
            if(infoViewController.view.superview){
                [self StopAR];
            }
        }

        
        if(ListViewController){
            if(ListViewController.view){
                [ListViewController.view removeFromSuperview];
            }
        }

        
    }else if (segm.selectedSegmentIndex==1){
        [self ShowList];
        
        if(infoViewController){
            
            if(infoViewController.view.superview){
                [self StopAR];
            }
        }
        
    }else if(segm.selectedSegmentIndex == 2){
        [self StartAR:self];
        if(ListViewController){
            if(ListViewController.view.superview){
                [ListViewController.view removeFromSuperview];
            }
        }
        
    }
    
    
}


-(void)StopAR{
        
        [self dismissModalViewControllerAnimated:YES];
        [[[self infoViewController] view] removeFromSuperview];
        infoViewController = nil;
}


-(void)ShowList{
    if (!ListViewController){
        ListViewController = [[MapListViewController alloc] initWithNibName:@"MapListViewController" bundle:nil];
    }
    ListViewController.lista=results;
    
    [self.view addSubview:ListViewController.view];
    [self.view bringSubviewToFront:segView];
}


//-(IBAction)StartAR:(id)sender{
//    
//    
//    if([ARKit deviceSupportsAR]){
//        ARViewController *arvc = [[ARViewController alloc] initWithDelegate:self];
//        [self setCameraViewController:arvc];
//    
//        [cameraViewController setModalTransitionStyle: UIModalTransitionStyleFlipHorizontal];
//       // [[ContentManager sharedContentManager] setScaleOnDistance:YES];
//        
//        [self presentModalViewController:cameraViewController animated:YES];
//        arvc = nil;
//    }
//
//
//    [self.view bringSubviewToFront:segView];
//    
//}



#define BOX_WIDTH 150
#define BOX_HEIGHT 100

//- (UIView *)viewForCoordinate:(ARCoordinate *)coords {
//	
//	CGRect theFrame = CGRectMake(0, 0, BOX_WIDTH, BOX_HEIGHT);
//	UIView *tempView = [[UIView alloc] initWithFrame:theFrame];
//	
//	//tempView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.3];
//	
//	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BOX_WIDTH, 20.0)];
//	titleLabel.backgroundColor = [UIColor colorWithWhite:.3 alpha:.8];
//	titleLabel.textColor = [UIColor whiteColor];
//	titleLabel.textAlignment = UITextAlignmentCenter;
//	//titleLabel.text = coords.title;
//	[titleLabel sizeToFit];
//	
//	titleLabel.frame = CGRectMake(BOX_WIDTH / 2.0 - titleLabel.frame.size.width / 2.0 - 4.0, 0, titleLabel.frame.size.width + 8.0, titleLabel.frame.size.height + 8.0);
//	
//	UIImageView *pointView = [[UIImageView alloc] initWithFrame:CGRectZero];
//	pointView.image = [UIImage imageNamed:@"location.png"];
//	pointView.frame = CGRectMake((int)(BOX_WIDTH / 2.0 - pointView.image.size.width / 2.0), (int)(BOX_HEIGHT / 2.0 - pointView.image.size.height / 2.0), pointView.image.size.width, pointView.image.size.height);
//    
//	[tempView addSubview:titleLabel];
//	[tempView addSubview:pointView];
//	
//
//	
//	return tempView;
//    
//    
//}

-(void) viewDidUnload{
    [self.locationManager stopUpdatingLocation];
    self.locationManager=nil;
}


#define DEG2RAD(degrees) (degrees * 0.01745327) // degrees * pi over 180

-(double) distanceFunc:(double)lat1 lon1:(double) lon1 lat2:(double)lat2 lon2:(double)lon2
{
    
    // convert lat1 and lat2 into radians now, to avoid doing it twice below
    double lat1rad = DEG2RAD(lat1);
    double lat2rad = DEG2RAD(lat2);
    // apply the spherical law of cosines to our latitudes and longitudes, and set the result appropriately
    // 6378.1 is the approximate radius of the earth in kilometres
    return (acos(sin(lat1rad) * sin(lat2rad) + cos(lat1rad) * cos(lat2rad) * cos(DEG2RAD(lon2) - DEG2RAD(lon1))) * 6378.1);
}
@end
