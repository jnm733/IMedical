//
//  UALAddHospitalViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALAddHospitalViewController.h"
#import "GestorBD.h"

@interface UALAddHospitalViewController ()

@property (weak, nonatomic) IBOutlet UISlider *capacidadHospital;
@property (weak, nonatomic) IBOutlet UITextField *localizacionHospital;
@property (weak, nonatomic) IBOutlet UITextField *nombreHospital;
@property (nonatomic, strong) GestorBD* gestorBD;


- (IBAction)ocultarTeclado:(id)sender;
- (IBAction)sliderChange:(id)sender;


@end

@implementation UALAddHospitalViewController

- (IBAction)ocultarTeclado:(id)sender {
}

- (IBAction)sliderChange:(id)sender {
    self.capacidadText.text = [NSString stringWithFormat:@"%i pacientes", (int)self.capacidadHospital.value];
}

- (IBAction) guardarDatos:(id) sender{
    NSString *consulta;
    if(self.idHospitalEdit == -1){
    consulta = [NSString stringWithFormat: @"insert into hospital values (null, '%@','%@','%f')", self.nombreHospital.text, self.localizacionHospital.text, self.capacidadHospital.value];
    }else{
        consulta = [NSString stringWithFormat:@"update hospital set nombre='%@', localizacion='%@', capacidad='%f' where id=%d", self.nombreHospital.text, self.localizacionHospital.text, self.capacidadHospital.value, self.idHospitalEdit];
    }
    [self.gestorBD executeQuery:consulta];
    if (self.gestorBD.filasAfectadas !=0){
        NSLog(@"Consulta ejecutada con ÉXITO...%d filas",
              self.gestorBD.filasAfectadas);
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate editionDidFinished];
    }
    else{
        NSLog(@"No se ha podido ejecutar la consulta...repásala...");
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gestorBD = [[GestorBD alloc]
                     initWithDatabaseFilename:@"imedical.sqlite"];
    if(self.idHospitalEdit == -1) {
        self.title = @"Nuevo Hospital";
        
        
    }else{
        self.title = [NSString stringWithFormat:@"Editar %@", self.nombreHospitalEdit];
        self.nombreHospital.text = self.nombreHospitalEdit;
        self.localizacionHospital.text = self.localizacionHospitalEdit;
        self.capacidadHospital.value = self.capacidadHospitalEdit;
        self.capacidadText.text = [NSString stringWithFormat:@"%i pacientes", (int)self.capacidadHospital.value];
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
