//
//  GestorBD.h
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GestorBD : NSObject

@property (nonatomic, strong) NSMutableArray *arrNombresCols;
@property (nonatomic) int filasAfectadas;
@property (nonatomic) long long ultimoID;

- (instancetype) initWithDatabaseFilename: (NSString *) dbFileName;
- (NSArray*) selectFromDB:(NSString*) consulta;
- (void) executeQuery: (NSString*) consulta;

@end
