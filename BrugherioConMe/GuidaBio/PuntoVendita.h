//
//  ChinaDatabase2.h
//  
//
//  Created by adriana carelli on 26/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "it_ariescomunicazioneAppDelegate.h"



@interface PuntoVendita : NSObject {
	sqlite3 * database;

}

@property (nonatomic, assign) int ID;
@property (nonatomic, copy) NSString *titolo;
@property (nonatomic, copy) NSString *testo;
@property (nonatomic, assign) int idcateg;
@property (nonatomic, copy) NSString *indirizzo;
@property (nonatomic, copy) NSString *numeroCivico;
@property (nonatomic, assign) int cap;
@property (nonatomic, copy) NSString *comune;
@property (nonatomic, copy) NSString *Regione;
@property (nonatomic, copy) NSString *telefono;
@property (nonatomic, copy) NSString *fax;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *sito;
@property (nonatomic, copy) NSString *Provincia;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, assign)double latitudine;
@property (nonatomic, assign)double longitudine;
@property (nonatomic, assign) int categ;
@property (nonatomic, assign) double distanza;
@property (nonatomic, copy) NSString *fb;
@property (nonatomic, copy) NSString *tw;
@property (nonatomic, copy) NSString *inevidenza;
@property (nonatomic, copy) NSString *apertura;
@property (nonatomic, copy) NSString *Foto1;
@property (nonatomic, copy) NSString *Foto2;
@property (nonatomic, copy) NSString *Foto3;
@property (nonatomic, copy) NSString *Foto4;
@property (nonatomic, copy) NSString *Foto5;


+ (NSMutableArray *) getPVCategoria:(NSInteger)idcateg dbPath:(NSString *) dbPath;
+ (NSMutableArray *) getPVLatLong:(double)Lat Long:(double) Long dbPath:(NSString *)dbPath;
+ (void) finalizeStatements;
+ (NSMutableArray *) Getpreferiti:(NSString *)dbPath;
+ (BOOL) AddFavourite:(NSInteger) pid dbPath:(NSString *)dbPath;
+ (void) DeleteFavourite :(NSInteger) pid dbPath:(NSString *)dbPath;

-(NSString*) IndirizzoCompleto;
-(NSString*) IndirizzoCompletoUnariga;
-(void) LoadByID :(NSInteger) Mid dbPath:(NSString *)dbPath;
-(id) initWithPrimaryKey:(NSInteger) pk;

-(bool)Ispreferito:(NSString *) dbPath;


@end
static sqlite3 *database = nil;

