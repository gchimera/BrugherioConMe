//
//  AnnotationCustom.h
//  China To Milan
//
//  Created by chiara bramani on 06/11/12.
//  Copyright (c) 2012 chiara bramani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "PuntoVendita.h"

@interface AnnotationCustom : NSObject <MKAnnotation>{
    
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;
@property (nonatomic, copy, readwrite)NSString * nomeTabella;
@property (nonatomic, assign)int ID;
@property (nonatomic, strong)PuntoVendita * pv;


- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                     title:(NSString *)paramTitle
                  subTitle:(NSString *)paramSubTitle;


@end
