//
//  AnnotationView.m
//  China To Milan
//
//  Created by adriana carelli on 03/10/12.
//  Copyright (c) 2012 chiara bramani. All rights reserved.
//



#import "AnnotationView.h"

@implementation AnnotationView

CLLocationCoordinate2D coordinate;

@synthesize coordinate, title, subtitle;

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
