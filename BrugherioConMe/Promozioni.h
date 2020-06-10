//
//  Promozioni.h
//  BrugherioConMe
//
//  Created by Silvia Pessini on 02/10/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Promozioni : NSObject{
sqlite3 * database;
}

@property (nonatomic, assign) int ID;
@property (nonatomic, retain) NSString *testo;
@property (nonatomic, retain) NSString *Immagine;
@property (nonatomic, assign) int numPDV;
@property (nonatomic, retain) NSString *titoloPuntov;
@property (nonatomic, retain) NSDate *datainizio;
@property (nonatomic, retain) NSDate *datafine;


+ (NSMutableArray *) getPromozioni:(NSString *) dbPath;
+ (NSMutableArray *) getSottoCategorie:(NSString *) dbPath idpadre:(NSInteger) id_padre;

-(int)NumPDV:(NSString *) dbPath;

+ (NSMutableArray *) newPromo:(NSString *) dbPath;


@end
