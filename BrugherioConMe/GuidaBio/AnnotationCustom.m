//
//  AnnotationCustom.m
//  China To Milan
//
//  Created by chiara bramani on 06/11/12.
//  Copyright (c) 2012 chiara bramani. All rights reserved.
//

#import "AnnotationCustom.h"

@implementation AnnotationCustom

CLLocationCoordinate2D coordinate;

@synthesize coordinate, title, subtitle, nomeTabella, ID, pv;

- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                     title:(NSString *)paramTitle
                  subTitle:(NSString *)paramSubTitle{
    
    self = [super init];
    
    if (self != nil){
        coordinate = paramCoordinates;
        title = paramTitle;
        subtitle = paramSubTitle;
    }
    
    return(self);
    
}

@end
