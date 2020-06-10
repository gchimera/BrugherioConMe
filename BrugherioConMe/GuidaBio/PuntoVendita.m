//
//  ChinaDatabase2.m
//  
//
//  Created by adriana carelli on 26/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "PuntoVendita.h"


@implementation PuntoVendita
@synthesize ID;
@synthesize titolo;
@synthesize testo;
@synthesize idcateg;
@synthesize indirizzo;
@synthesize numeroCivico;
@synthesize telefono;
@synthesize fax;
@synthesize email;
@synthesize sito;
@synthesize Provincia;
@synthesize logo;
@synthesize latitudine;
@synthesize longitudine,distanza;
@synthesize apertura;
@synthesize fb;
@synthesize tw;
@synthesize  inevidenza;
@synthesize Foto1;
@synthesize Foto2;
@synthesize Foto3;
@synthesize Foto4;
@synthesize Foto5;


+ (NSMutableArray *) getPVCategoria:(NSInteger)idcateg dbPath:(NSString *) dbPath{
	
    NSMutableArray * result;
    
     if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){

	NSString *query =[NSString stringWithFormat:@"SELECT ID,ifnull(TITOLO,''), ifnull(CATEG_M,''),ifnull(TESTO, ''), ifnull(INDIRIZZO,''),ifnull([NUMERO_CIVICO], ''),  ifnull(TELEFONO, ''), ifnull(FAX, ''), ifnull(EMAIL, ''),ifnull(SITO, ''), ifnull(APERTURA,''), ifnull(LOGO,''), ifnull(FACEBOOK,''), ifnull(TWITTER,''), ifnull(LATITUDINE, 0), ifnull(LONGITUDINE, 0),ifnull(FOTO1, ''),ifnull(FOTO2, ''),ifnull(FOTO3, ''),ifnull(FOTO4, ''),ifnull(FOTO5, ''),ifnull(IN_EVIDENZA, '') FROM PUNTI_VENDITA WHERE CATEG_M =%d order by TITOLO;",idcateg];
	
	sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil);
    
    NSLog(@"IL valore della variabile è %d", sqlResult);
    
    //if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
   
    if(sqlResult == SQLITE_OK){
        
        result= [[NSMutableArray alloc]init];
        
	
	     while (sqlite3_step(statement) == SQLITE_ROW) {
			
			PuntoVendita * rowTable =[[PuntoVendita alloc]init];
			
			rowTable.ID = sqlite3_column_int(statement,0);
			char *title= (char*)sqlite3_column_text(statement,1);
			rowTable.idcateg =  sqlite3_column_int(statement,2);
			char *text= (char*)sqlite3_column_text(statement,3);
			char *address= (char*)sqlite3_column_text(statement,4);
			char *number= (char*)sqlite3_column_text(statement,5);
            // rowTable.cap = sqlite3_column_int(statement,6);
            
			//char *place= (char*)sqlite3_column_text(statement,7);
			//char *regione= (char*)sqlite3_column_text(statement,8);
			char * tel= (char*)sqlite3_column_text(statement,6);
			char *faxPlace= (char*)sqlite3_column_text(statement,7);
			char *emailPlace= (char*)sqlite3_column_text(statement,8);
			char *sitoWeb= (char*)sqlite3_column_text(statement,9);
			char *apertura= (char*)sqlite3_column_text(statement,10);
			char *log= (char*)sqlite3_column_text(statement,11);
           
            // NSLog(@"il valore della latitudine  è %f", rowTable.latitudine);
             char *fb= (char*)sqlite3_column_text(statement,12);
          
            // NSLog(@"il valore della longitudine è %f", rowTable.longitudine);
             char *tw= (char*)sqlite3_column_text(statement,13);
               rowTable.latitudine = sqlite3_column_double(statement, 14);
               rowTable.longitudine= sqlite3_column_double(statement, 15);
             
             
             	rowTable.Foto1 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,16)];
             	rowTable.Foto2 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,17)];
             	rowTable.Foto3 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,18)];
             	rowTable.Foto4 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,19)];
             	rowTable.Foto5 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,20)];
            rowTable.inevidenza=[[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,21)];
			
			rowTable.titolo = [[NSString alloc]initWithUTF8String: title];
			rowTable.testo = [[NSString alloc]initWithUTF8String: text];
			rowTable.indirizzo = [[NSString alloc]initWithUTF8String: address];
			rowTable.numeroCivico = [[NSString alloc]initWithUTF8String: number];
	 		rowTable.fb = [[NSString alloc]initWithUTF8String: fb];
			rowTable.tw = [[NSString alloc]initWithUTF8String: tw];
			rowTable.telefono = [[NSString alloc]initWithUTF8String: tel];
			rowTable.fax = [[NSString alloc]initWithUTF8String: faxPlace];
			rowTable.email = [[NSString alloc]initWithUTF8String: emailPlace];
			rowTable.sito = [[NSString alloc]initWithUTF8String: sitoWeb];
			rowTable.apertura = [[NSString alloc]initWithUTF8String: apertura];
			rowTable.logo = [[NSString alloc]initWithUTF8String: log];
		
			[result addObject:rowTable];
	     }
		
		sqlite3_finalize(statement);
        sqlite3_close(database);
	}else {
        NSLog(@"Failed from sqlite3_step(statement). Error is:  %s", sqlite3_errmsg(database) );

        sqlite3_close(database);
    }
}
	return result;
		
}



	
+ (void) finalizeStatements{
    if(database) sqlite3_close(database);
    
}
	
	-(void)LoadbyID:(NSInteger)pid dbPath:(NSString *)dbPath{
    }
	


+(NSMutableArray *) Getpreferiti: (NSString *)dbPath
{
    database=nil;
    
    NSMutableArray *Prefs = [[NSMutableArray alloc] init];
    int ret=sqlite3_open([dbPath UTF8String], &database);
    NSLog(@"RETURN CODE %d",ret);
    
    if( ret == SQLITE_OK   ){
        
        const char *sql  = "select ID,TITOLO FROM PREFERITI order by TITOLO";
        
        sqlite3_stmt *statment;
        
        
        if(sqlite3_prepare_v2(database, sql, -1, &statment, NULL)== SQLITE_OK){
            
            
            while( sqlite3_step(statment) == SQLITE_ROW){
                
                NSInteger primaryKey = sqlite3_column_int(statment, 0);
                PuntoVendita  *esp = [[PuntoVendita alloc] initWithPrimaryKey:primaryKey];
                esp.titolo =  [NSString stringWithUTF8String:(char *) sqlite3_column_text(statment,1)];
               // esp.Stand= [NSString stringWithUTF8String:(char *) sqlite3_column_text(statment,2)];
                [Prefs addObject:esp];
                
            }
            
            
        }
        sqlite3_finalize(statment);
        
    }
    
    sqlite3_close(database);
    return Prefs;
}


-(bool)Ispreferito:(NSString *) dbPath{
    int result=0;
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
        NSString *query =[NSString stringWithFormat:@"SELECT COUNT(id) FROM PREFERITI WHERE ID=%d",ID];
        
        sqlite3_stmt *statement;
        
        int sqlResult = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil);
        
        if(sqlResult == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                
                result=sqlite3_column_int(statement,0);
                
                
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }else {
            NSLog(@"Failed from sqlite3_step(statement). Error is:  %s", sqlite3_errmsg(database) );
            
            sqlite3_close(database);
        }
    }
    return result > 0;
}


+(BOOL) AddFavourite:(NSInteger)pid dbPath:(NSString *)dbPath
{
    
    //  database=nil;
    
    int ret=sqlite3_open([dbPath UTF8String], &database);
    NSLog(@"RETURN CODE %d",ret);
    
    if( ret == SQLITE_OK   ){
        
        const char *sql  = "INSERT OR REPLACE INTO Preferiti( ID,TITOLO) Select ID,TITOLO FROM PUNTI_VENDITA where PUNTI_VENDITA.ID=?";
        sqlite3_stmt *statment;
        
        if(sqlite3_prepare_v2(database, sql, -1, &statment, NULL)== SQLITE_OK){
            
            sqlite3_bind_int(statment, 1,pid );
            
            if (SQLITE_DONE!= sqlite3_step(statment)) {
                NSLog( @"Errore durante l'inesrimento del preferito. '%s'", sqlite3_errmsg(database));
                sqlite3_finalize(statment);
                sqlite3_close(database);
                return NO;
            }
            sqlite3_reset(statment);
            return YES;
            
        }else{
            NSLog( @"Errore durante l'inesrimento del preferito. '%s'", sqlite3_errmsg(database));
            sqlite3_finalize(statment);
            sqlite3_close(database);
            return NO;
            
        }
    }
    sqlite3_close(database);
    return NO;
    
}

+(void) DeleteFavourite:(NSInteger)pid dbPath:(NSString *)dbPath
{
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
        
        const char *sql  = "Delete from Preferiti where ID=?";
        sqlite3_stmt *statment;
        if(sqlite3_prepare_v2(database, sql, -1, &statment, NULL)== SQLITE_OK){
            sqlite3_bind_int(statment, 1,pid );
            if (SQLITE_DONE!= sqlite3_step(statment)) {
                NSAssert1(0, @"Errore durante la cancellazione. '%s'", sqlite3_errmsg(database));
                
            }
            sqlite3_reset(statment);
        }
        
    }
    
}





    
    

-(id) initWithPrimaryKey:(NSInteger)pk{
    
    self = [super init];
    
    ID = pk;
    
    return self;
    
    
}





-(void) LoadByID :(NSInteger) Mid dbPath:(NSString *)dbPath{
    
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
        
        
        NSString *query =[NSString stringWithFormat:@"SELECT ID,ifnull(TITOLO,''), ifnull(CATEG_M,''),ifnull(TESTO, ''), ifnull(INDIRIZZO,''),ifnull([NUMERO_CIVICO], ''),  ifnull(TELEFONO, ''), ifnull(FAX, ''), ifnull(EMAIL, ''),ifnull(SITO, ''), ifnull(APERTURA,''), ifnull(LOGO,''), ifnull(FACEBOOK,''), ifnull(TWITTER,''), ifnull(LATITUDINE, 0), ifnull(LONGITUDINE, 0),ifnull(FOTO1, ''),ifnull(FOTO2, ''),ifnull(FOTO3, ''),ifnull(FOTO4, ''),ifnull(FOTO5, ''),ifnull(IN_EVIDENZA, '')  FROM PUNTI_VENDITA WHERE ID = %d", Mid];
        
        sqlite3_stmt *statement;
        
        
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL)== SQLITE_OK)
        {
       
            
            while( sqlite3_step(statement) == SQLITE_ROW){
                
                
                
                
                
                ID = sqlite3_column_int(statement,0);
                char *title= (char*)sqlite3_column_text(statement,1);
                idcateg =  sqlite3_column_int(statement,2);
                char *text= (char*)sqlite3_column_text(statement,3);
                char *address= (char*)sqlite3_column_text(statement,4);
                char *number= (char*)sqlite3_column_text(statement,5);
                // rowTable.cap = sqlite3_column_int(statement,6);
                
                //char *place= (char*)sqlite3_column_text(statement,7);
                //char *regione= (char*)sqlite3_column_text(statement,8);
                char * tel= (char*)sqlite3_column_text(statement,6);
                char *faxPlace= (char*)sqlite3_column_text(statement,7);
                char *emailPlace= (char*)sqlite3_column_text(statement,8);
                char *sitoWeb= (char*)sqlite3_column_text(statement,9);
                char *mapertura= (char*)sqlite3_column_text(statement,10);
                char *log= (char*)sqlite3_column_text(statement,11);
                
                // NSLog(@"il valore della latitudine  è %f", rowTable.latitudine);
                char *mfb= (char*)sqlite3_column_text(statement,12);
                
                // NSLog(@"il valore della longitudine è %f", rowTable.longitudine);
                char *mtw= (char*)sqlite3_column_text(statement,13);
                latitudine = sqlite3_column_double(statement, 14);
                longitudine= sqlite3_column_double(statement, 15);
                
                
             	Foto1 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,16)];
             	Foto2 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,17)];
             	Foto3 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,18)];
             	Foto4 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,19)];
             	Foto5 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,20)];
                
                
                titolo = [[NSString alloc]initWithUTF8String: title];
                testo = [[NSString alloc]initWithUTF8String: text];
                indirizzo = [[NSString alloc]initWithUTF8String: address];
                numeroCivico = [[NSString alloc]initWithUTF8String: number];
                fb = [[NSString alloc]initWithUTF8String: mfb];
                tw = [[NSString alloc]initWithUTF8String: mtw];
                telefono = [[NSString alloc]initWithUTF8String: tel];
                fax = [[NSString alloc]initWithUTF8String: faxPlace];
                email = [[NSString alloc]initWithUTF8String: emailPlace];
                sito = [[NSString alloc]initWithUTF8String: sitoWeb];
                apertura = [[NSString alloc]initWithUTF8String: mapertura];
                logo = [[NSString alloc]initWithUTF8String: log];

                inevidenza=[[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,21)];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }else {
        
        sqlite3_close(database);
    }

}

+ (NSMutableArray *) getPVLatLong:(double)Lat Long:(double) Long dbPath:(NSString *)dbPath{
    
        NSMutableArray * result;
         result= [[NSMutableArray alloc]init];
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
    sqlite3_create_function(database, "distance", 4, SQLITE_UTF8, NULL, &distanceFunc, NULL, NULL);
    
        NSString *query =[NSString stringWithFormat:@"SELECT ID,ifnull(TITOLO,''), ifnull(CATEG_M,''),ifnull(TESTO, ''), ifnull(INDIRIZZO,''),ifnull([NUMERO_CIVICO], ''),  ifnull(TELEFONO, ''), ifnull(FAX, ''), ifnull(EMAIL, ''),ifnull(SITO, ''), ifnull(APERTURA,''), ifnull(LOGO,''), ifnull(FACEBOOK,''), ifnull(TWITTER,''), ifnull(LATITUDINE, 0), ifnull(LONGITUDINE, 0),ifnull(FOTO1, ''),ifnull(FOTO2, ''),ifnull(FOTO3, ''),ifnull(FOTO4, ''),ifnull(FOTO5, ''),distance(LATITUDINE,LONGITUDINE,%f,%f) as Distanza,ifnull(IN_EVIDENZA, '') FROM PUNTI_VENDITA WHERE distance(LATITUDINE,LONGITUDINE,%f,%f) < 30 order by Distanza", Lat,Long,Lat,Long];
        
        
        sqlite3_stmt *statement;
        
        int sqlResult = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil);
        if(sqlResult == SQLITE_OK){
            
            result= [[NSMutableArray alloc]init];
            
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                PuntoVendita * rowTable =[[PuntoVendita alloc]init];
                
                rowTable.ID = sqlite3_column_int(statement,0);
                char *title= (char*)sqlite3_column_text(statement,1);
                rowTable.idcateg =  sqlite3_column_int(statement,2);
                char *text= (char*)sqlite3_column_text(statement,3);
                char *address= (char*)sqlite3_column_text(statement,4);
                char *number= (char*)sqlite3_column_text(statement,5);
                // rowTable.cap = sqlite3_column_int(statement,6);
                
                //char *place= (char*)sqlite3_column_text(statement,7);
                //char *regione= (char*)sqlite3_column_text(statement,8);
                char * tel= (char*)sqlite3_column_text(statement,6);
                char *faxPlace= (char*)sqlite3_column_text(statement,7);
                char *emailPlace= (char*)sqlite3_column_text(statement,8);
                char *sitoWeb= (char*)sqlite3_column_text(statement,9);
                char *apertura= (char*)sqlite3_column_text(statement,10);
                char *log= (char*)sqlite3_column_text(statement,11);
                
                // NSLog(@"il valore della latitudine  è %f", rowTable.latitudine);
                char *fb= (char*)sqlite3_column_text(statement,12);
                
                // NSLog(@"il valore della longitudine è %f", rowTable.longitudine);
                char *tw= (char*)sqlite3_column_text(statement,13);
                rowTable.latitudine = sqlite3_column_double(statement, 14);
                rowTable.longitudine= sqlite3_column_double(statement, 15);
                
                
             	rowTable.Foto1 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,16)];
             	rowTable.Foto2 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,17)];
             	rowTable.Foto3 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,18)];
             	rowTable.Foto4 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,19)];
             	rowTable.Foto5 = [[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,20)];
                
                 rowTable.inevidenza=[[NSString alloc]initWithUTF8String: (char*)sqlite3_column_text(statement,21)];
                
                rowTable.titolo = [[NSString alloc]initWithUTF8String: title];
                rowTable.testo = [[NSString alloc]initWithUTF8String: text];
                rowTable.indirizzo = [[NSString alloc]initWithUTF8String: address];
                rowTable.numeroCivico = [[NSString alloc]initWithUTF8String: number];
                rowTable.fb = [[NSString alloc]initWithUTF8String: fb];
                rowTable.tw = [[NSString alloc]initWithUTF8String: tw];
                rowTable.telefono = [[NSString alloc]initWithUTF8String: tel];
                rowTable.fax = [[NSString alloc]initWithUTF8String: faxPlace];
                rowTable.email = [[NSString alloc]initWithUTF8String: emailPlace];
                rowTable.sito = [[NSString alloc]initWithUTF8String: sitoWeb];
                rowTable.apertura = [[NSString alloc]initWithUTF8String: apertura];
                rowTable.logo = [[NSString alloc]initWithUTF8String: log];
                [result addObject:rowTable];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }else {
            NSLog(@"Failed from sqlite3_step(statement). Error is:  %s", sqlite3_errmsg(database) );
            
            sqlite3_close(database);
        }

        
        
    }
    
    return result;
    
}



-(NSString *) IndirizzoCompleto{
    return [NSString stringWithFormat:@"%@ %@  ", indirizzo, numeroCivico];
}
-(NSString *) IndirizzoCompletoUnariga{
    return [NSString stringWithFormat:@"Brugherio (MI) %@ %@", indirizzo, numeroCivico];
}


#define DEG2RAD(degrees) (degrees * 0.01745327) // degrees * pi over 180

static void distanceFunc(sqlite3_context *context, int argc, sqlite3_value **argv)
{
    // check that we have four arguments (lat1, lon1, lat2, lon2)
    assert(argc == 4);
    // check that all four arguments are non-null
    if (sqlite3_value_type(argv[0]) == SQLITE_NULL || sqlite3_value_type(argv[1]) == SQLITE_NULL || sqlite3_value_type(argv[2]) == SQLITE_NULL || sqlite3_value_type(argv[3]) == SQLITE_NULL) {
        sqlite3_result_null(context);
        return;
    }
    // get the four argument values
    double lat1 = sqlite3_value_double(argv[0]);
    double lon1 = sqlite3_value_double(argv[1]);
    double lat2 = sqlite3_value_double(argv[2]);
    double lon2 = sqlite3_value_double(argv[3]);
    // convert lat1 and lat2 into radians now, to avoid doing it twice below
    double lat1rad = DEG2RAD(lat1);
    double lat2rad = DEG2RAD(lat2);
    // apply the spherical law of cosines to our latitudes and longitudes, and set the result appropriately
    // 6378.1 is the approximate radius of the earth in kilometres
    sqlite3_result_double(context, acos(sin(lat1rad) * sin(lat2rad) + cos(lat1rad) * cos(lat2rad) * cos(DEG2RAD(lon2) - DEG2RAD(lon1))) * 6378.1);
}




+(void) DeletePromo:(NSInteger)pid dbPath:(NSString *)dbPath
{
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
        
        const char *sql  = "Delete from PUNTI_VENDITA where ID=%@",pid;
        sqlite3_stmt *statment;
        if(sqlite3_prepare_v2(database, sql, -1, &statment, NULL)== SQLITE_OK){
            sqlite3_bind_int(statment, 1,pid );
            if (SQLITE_DONE!= sqlite3_step(statment)) {
                NSAssert1(0, @"Errore durante la cancellazione. '%s'", sqlite3_errmsg(database));
                
            }
            sqlite3_reset(statment);
        }
        
    }
}


+(void) InsertPV:(NSInteger)pid pv:(PuntoVendita *)pv dbPath:(NSString *)dbPath
{
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   )
    {
        
        NSString *sqlInsert  = [NSString stringWithFormat:@"INSERT or REPLACE into PUNTI_VENDITA VALUES ('%i','%@', '%i' , '%@', '%@','%i', %@,%@,%@,  %@, %@, %@, %i, %i, %@, %@, %@, %@, %@,%@,%@,%@,%@);", pv.ID, pv.titolo, pv.categ, pv.testo, pv.indirizzo, pv.numeroCivico, pv.inevidenza, pv.telefono, pv.fax, pv.email, pv.sito, pv.logo,pv.latitudine,pv.longitudine,pv.apertura,pv.fb,pv.tw,pv.Foto1, pv.Foto2, pv.Foto3,pv.Foto4,pv.Foto5];
        sqlite3_stmt *statment;
            if(sqlite3_prepare_v2(database, [sqlInsert UTF8String], -1, &statment, NULL)== SQLITE_OK){
                sqlite3_bind_int(statment, 1,pid );
        if (SQLITE_DONE!= sqlite3_step(statment)) {
            NSAssert1(0, @"Errore durante l'inserimento. '%s'", sqlite3_errmsg(database));
            
        }
        sqlite3_reset(statment);
    }
    
}
}




@end
