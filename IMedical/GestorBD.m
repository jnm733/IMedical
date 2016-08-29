//
//  GestorBD.m
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "GestorBD.h"
#import <sqlite3.h>

@interface GestorBD()

@property (nonatomic, strong) NSString* carpetaDocumentos;
@property (nonatomic, strong) NSString* nombreBD;
@property (nonatomic, strong) NSMutableArray *arrResultados;

-(void) copiarBDCarpetaDocumentos;
-(void) ejecutaConsulta: (const char*) consulta
           esEjecutable: (BOOL) consultaEjecutable;

@end

@implementation GestorBD

- (instancetype) initWithDatabaseFilename: (NSString *) dbFileName{
    NSArray *paths = nil;
    self = [super init];
    if (self){
        paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                    NSUserDomainMask, YES);
        self.carpetaDocumentos = [paths objectAtIndex:0];
        self.nombreBD = dbFileName;
        [self copiarBDCarpetaDocumentos];
    }
    return self;
}

- (void) copiarBDCarpetaDocumentos{
    NSString* carpetaDestino;
    NSString* caminoFuente;
    NSError* error;
    carpetaDestino = [self.carpetaDocumentos
                      stringByAppendingPathComponent:self.nombreBD];
    if (![[NSFileManager defaultManager] fileExistsAtPath:carpetaDestino]){
        caminoFuente = [[[NSBundle mainBundle] resourcePath]
                        stringByAppendingPathComponent:self.nombreBD];
        [[NSFileManager defaultManager] copyItemAtPath:caminoFuente
                                                toPath:carpetaDestino error:&error];
        if (error != nil) NSLog(@"%@", [error localizedDescription]);
    }
}

-(void) ejecutaConsulta: (const char*) consulta esEjecutable: (BOOL)
consultaEjecutable{
    sqlite3* baseDeDatos;
    NSString *caminoBD = [self.carpetaDocumentos
                          stringByAppendingPathComponent:self.nombreBD];
    sqlite3_stmt* consultaCompilada;
    NSMutableArray *arrayAux;
    char* datos;
    int numCols;
    //Inicializamos array de resultados
    if (self.arrResultados != nil){
        [self.arrResultados removeAllObjects];
        self.arrResultados = nil;
    }
    self.arrResultados = [[NSMutableArray alloc]init];
    //Inicializamos array de nombres de columnas
    if (self.arrNombresCols != nil){
        [self.arrNombresCols removeAllObjects];
        self.arrNombresCols = nil;
    }
    self.arrNombresCols = [[NSMutableArray alloc]init];
    //Abrimos la BD
    if (sqlite3_open([caminoBD UTF8String], &baseDeDatos) != SQLITE_OK){
        NSLog(@"%s", sqlite3_errmsg(baseDeDatos));
        return;
    }
    // Compilamos la consulta
    if (sqlite3_prepare_v2(baseDeDatos,consulta, -1, &consultaCompilada,
                           NULL) != SQLITE_OK){
        NSLog(@"Errorrrr en la consulta :%s",
              sqlite3_errmsg(baseDeDatos));
        return;
    }
    if (!consultaEjecutable){ //Cargamos datos en un array auxiliar ...
        while (sqlite3_step(consultaCompilada)==SQLITE_ROW){
            //fila por fila
            arrayAux = [[NSMutableArray alloc] init];
            numCols = sqlite3_column_count(consultaCompilada);
            for (int i=0; i<numCols; i++){
                datos = (char*)sqlite3_column_text(consultaCompilada,i);
                if (datos != NULL){
                    [arrayAux addObject:[NSString
                                         stringWithUTF8String:datos]];
                }
                if (self.arrNombresCols.count != numCols){
                    datos = (char*) sqlite3_column_name(consultaCompilada,i);
                    [self.arrNombresCols addObject:[NSString
                                                    stringWithUTF8String:datos]];
                }
            }
            if (arrayAux.count > 0){
                [self.arrResultados addObject:arrayAux];
            }
        }
    }
    else{ //consulta ejecutable: inserte/update/delete
        if (sqlite3_step(consultaCompilada) == SQLITE_DONE){
            self.filasAfectadas = sqlite3_changes(baseDeDatos);
            self.ultimoID = sqlite3_last_insert_rowid(baseDeDatos);
        }
        else{
            NSLog(@"Errorrrr en la consulta :%s",
                  sqlite3_errmsg(baseDeDatos));
            return;
        }
    }
    sqlite3_finalize(consultaCompilada);
    sqlite3_close(baseDeDatos);
}

- (NSArray*) selectFromDB:(NSString*) consulta{
    [self ejecutaConsulta:[consulta UTF8String] esEjecutable:NO];
    return self.arrResultados;
}

- (void) executeQuery: (NSString*) consulta{
    [self ejecutaConsulta:[consulta UTF8String]
             esEjecutable:YES];
}

@end
