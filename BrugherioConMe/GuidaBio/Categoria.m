//
//  Categoria.m
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import "Categoria.h"
#import "sqlite3.h"

#import "PuntoVendita.h"

@implementation Categoria


@synthesize ID;
@synthesize Desc;
@synthesize Icona,numPDV;


+ (NSMutableArray *) getCategorie:(NSString *) dbPath{
    
    
    NSMutableArray * result= [[NSMutableArray alloc]init];
     if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
    NSString *query =@"SELECT ID,Descrizione, IFNULL(Icone,'') FROM Categorie where ID_padre = '0' and ID not in (1,2) order by [Ordine]";
	
	sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil);
    
         
         Categoria * cat1 =[[Categoria alloc]init];
         cat1.ID=1;
         cat1.Desc=@"PROMOZIONI";
         cat1.Icona=@"";
         [result addObject:cat1];
         
         Categoria * cat2 =[[Categoria alloc]init];
         cat2.ID=2;
         cat2.Desc=@"PREFERITI";
         cat2.Icona=@"";
[result addObject:cat2];
         
         
    if(sqlResult == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
			
			Categoria * cat =[[Categoria alloc]init];
            cat.ID=sqlite3_column_int(statement,0);
            cat.Desc=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement,1)];
            cat.Icona=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement,2)];
            
            [result addObject:cat];
            
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


+ (NSMutableArray *) getSottoCategorie:(NSString *) dbPath idpadre:(NSInteger) id_padre{
    
    NSMutableArray *risultato = [[NSMutableArray alloc]init];
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
        NSString *query =[NSString stringWithFormat: @"SELECT ID,Descrizione, IFNULL(Icone,'') FROM Categorie where ID_padre = %d order by [Ordine]",id_padre];
        
       	sqlite3_stmt *statement;
        
        int sqlResult = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil);
        
        if(sqlResult == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                Categoria * cat =[[Categoria alloc]init];
                cat.ID=sqlite3_column_int(statement,0);
                cat.Desc=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement,1)];
                cat.Icona=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement,2)];
                [risultato addObject:cat];
                
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }else {
            NSLog(@"Failed from sqlite3_step(statement). Error is:  %s", sqlite3_errmsg(database) );
            
            sqlite3_close(database);
        }
        
    }
    return risultato;
}




-(int)NumPDV:(NSString *) dbPath{
     int result=0;

    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK   ){
        NSString *query =[NSString stringWithFormat:@"SELECT COUNT(id) FROM PUNTI_VENDITA WHERE IDCATEG=%d",ID];
        
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
    return result;
}



@end
