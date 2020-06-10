//
//  it_ariescomunicazioneSecondViewController.h
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AnnotationView.h"
//#import "ARKit.h"



@interface Mappe : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation>
{
    CLGeocoder *geocoder;
    AnnotationView * annotationUser;
    NSString *location;
    it_ariescomunicazioneAppDelegate *appDelegate;
    NSMutableArray *filteredListContent;
 //   ARViewController *cameraViewController;
    UIViewController *infoViewController;
}

@property (nonatomic, strong)IBOutlet MKMapView *mapView;
@property (nonatomic, strong)IBOutlet UIView *segView;
@property (nonatomic, assign)double latitudine;
@property  (nonatomic, assign)double longitudine;
@property (nonatomic, strong)CLLocationManager * locationManager;
@property (nonatomic, assign)CLLocationCoordinate2D  coordinate;
@property (nonatomic, strong) AnnotationView * annotationUser;
@property(nonatomic,retain) NSMutableArray *PDVList;
@property (nonatomic, strong)IBOutlet UISegmentedControl *segm;
// @property (nonatomic, retain) ARViewController *cameraViewController;
@property (nonatomic, retain) UIViewController *infoViewController;

-(IBAction)StartAR:(id)sender;
-(IBAction)SegChanghed:(id)sender;
-(IBAction)CenterMap:(id)sender;

@end
