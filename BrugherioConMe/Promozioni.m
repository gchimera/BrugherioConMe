//
//  Promozioni.m
//  BrugherioConMe
//
//  Created by Silvia Pessini on 02/10/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import "Promozioni.h"

@implementation Promozioni

@synthesize ID;
@synthesize testo;
@synthesize Immagine,numPDV,titoloPuntov;
@synthesize datainizio, datafine;


+ (NSMutableArray *) getPromozioni:(NSString *) dbPath{
	
    NSMutableArray * result;
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
        
        NSString *query =[NSString stringWithFormat:@"SELECT Promozioni.ID,Promozioni.testo,ifnull(Promozioni.Immagine,''),PUNTI_VENDITA.TITOLO FROM Promozioni inner join PUNTI_VENDITA ON PUNTI_VENDITA.ID=Promozioni.IDPunto_Vendita WHERE date('now') BETWEEN Datainizio AND Datafine "];
        
        sqlite3_stmt *statement;
        
        int sqlResult = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil);
        
        NSLog(@"IL valore della variabile è %d", sqlResult);
        
        //if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        
        if(sqlResult == SQLITE_OK){
            
            result= [[NSMutableArray alloc]init];
            
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                Promozioni * rowTable =[[Promozioni alloc]init];
                
                rowTable.ID = sqlite3_column_int(statement,0);
                char *testo= (char*)sqlite3_column_text(statement,1);
                char *Immagine =  (char*)sqlite3_column_text(statement,2);
                char *punto= (char*)sqlite3_column_text(statement,3);

                
               rowTable.testo = [[NSString alloc]initWithUTF8String: testo];
           rowTable.Immagine = [[NSString alloc]initWithUTF8String: Immagine];
                rowTable.titoloPuntov = [[NSString alloc]initWithUTF8String: punto];
                
                
                
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





+ (NSMutableArray *) newPromo:(NSString *) dbPath{
	
    NSMutableArray * result;
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
        \
        NSString *query =[NSString stringWithFormat:@"INSERT INTO Promozioni (ID,IDPunto_Vendita,Datainizio,Datafine,Testo,Immagine) VALUES (9,90,2013-09-09,013-09-09,\"jj\",\"aa\") "];
        
        sqlite3_stmt *statement;
        
        int sqlResult = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil);
        
        NSLog(@"IL valore della variabile è %d", sqlResult);
        
        //if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        
        if(sqlResult == SQLITE_OK){
            
            result= [[NSMutableArray alloc]init];
            
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                Promozioni * rowTable =[[Promozioni alloc]init];
                
                rowTable.ID = sqlite3_column_int(statement,0);
                char *testo= (char*)sqlite3_column_text(statement,1);
                //char *Immagine =  sqlite3_column_int(statement,2);
                
                
                rowTable.testo = [[NSString alloc]initWithUTF8String: testo];
                // rowTable.Immagine = [[NSString alloc]initWithUTF8String: Immagine];
                
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





+(void) DeletePromo:(NSInteger)pid dbPath:(NSString *)dbPath
{
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
        
        const char *sql  = "Delete from Promozioni where ID=%@",pid;
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




+(void) InsertPromo:(NSInteger)pid pv:(Promozioni *)pv dbPath:(NSString *)dbPath
{
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   )
    {
        
        NSString *sqlInsert  = [NSString stringWithFormat:@"INSERT or REPLACE into PUNTI_VENDITA VALUES ('%i', '%i' , '%d', '%d', %@,%@);", pv.ID, pv.numPDV, pv.datainizio, pv.datafine, pv.testo, pv.Immagine];
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

