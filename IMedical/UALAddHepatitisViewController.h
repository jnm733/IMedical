//
//  UALAddHepatitisViewController.h
//  IMedical
//
//  Created by Jose Luis on 8/29/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UALAddHepatitisViewController
-(void) editionDidFinished;
@end

@interface UALAddHepatitisViewController : UIViewController

@property (nonatomic, strong) id<UALAddHepatitisViewController>
delegate;
@property (nonatomic) int idPaciente;
@property (nonatomic) NSString* dniPaciente;

@property (nonatomic) int idDiagSelected;




@end
