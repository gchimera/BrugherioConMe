//
//  Categoria.h
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface Categoria : NSObject{
    	sqlite3 * database;
}

@property (nonatomic, assign) int ID;
@property (nonatomic, copy) NSString *Desc;
@property (nonatomic, copy) NSString *Icona;
@property (nonatomic, assign) int numPDV;

+ (NSMutableArray *) getCategorie:(NSString *) dbPath;
+ (NSMutableArray *) getSottoCategorie:(NSString *) dbPath idpadre:(NSInteger) id_padre;

-(int)NumPDV:(NSString *) dbPath;
@end
