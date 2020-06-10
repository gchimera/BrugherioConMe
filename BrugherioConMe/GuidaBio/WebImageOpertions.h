//
//  WebImageOpertions.h
//  EICMA
//
//  Created by Silvia Pessini on 08/11/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebImageOpertions : NSObject

+(void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage;
@end
