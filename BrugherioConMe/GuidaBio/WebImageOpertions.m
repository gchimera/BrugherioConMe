//
//  WebImageOpertions.m
//  EICMA
//
//  Created by Silvia Pessini on 08/11/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import "WebImageOpertions.h"
#import <QuartzCore/QuartzCore.h>

@implementation WebImageOpertions

+(void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage{
    NSURL *url=[NSURL URLWithString:urlString];
    
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t donwloadQueue =dispatch_queue_create("it.ariescomunicazione.queue", NULL);
    dispatch_async(donwloadQueue, ^{
        
        NSData *imageData =[NSData dataWithContentsOfURL:url];
        dispatch_async(callerQueue, ^{
            processImage(imageData);
        });
    });
    donwloadQueue=nil;
    
    
    //dispatch_release(donwloadQueue);
    
}
@end
