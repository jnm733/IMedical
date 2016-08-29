//
//  UALHospitalTableViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALHospitalTableViewController.h"
#import "GestorBD.h"
#import "UALPacienteTableViewController.h"

@interface UALHospitalTableViewController ()

@property (nonatomic, strong) GestorBD* gestorBD;
@property (nonatomic, strong) NSArray* arrayDatos;

@property (nonatomic) int idHospitalSelected;
@property (nonatomic) NSString* nombreHospitalSelected;
@property (nonatomic) NSString* localizacionHospitalSelected;
@property (nonatomic) int capacidadHospitalSelected;





- (void) cargarDatos;


@end

@implementation UALHospitalTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabla.delegate = self;
    self.tabla.dataSource = self;
    self.gestorBD = [[GestorBD alloc] initWithDatabaseFilename:@"imedicalF.sqlite"];
    
    [self cargarDatos];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) cargarDatos{
    NSString *consulta = @"select * from hospital";
    if (self.arrayDatos != nil) self.arrayDatos = nil;
    self.arrayDatos = [[NSArray alloc] initWithArray:[self.gestorBD
                                                      selectFromDB:consulta]];
    //actualizamos la tabla
    [self.tabla reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrayDatos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSInteger indexOfNombre = [self.gestorBD.arrNombresCols indexOfObject:@"nombre"];
    NSInteger indexOfLocalizacion = [self.gestorBD.arrNombresCols indexOfObject:@"localizacion"];


    cell.imageView.image = [UIImage imageNamed:@"UAL.png"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfNombre]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfLocalizacion]];
    
    return cell;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addHospital"]){
        UALAddHospitalViewController* destino = [segue destinationViewController];
        destino.delegate = self;
        destino.idHospitalEdit = -1;
        
    }else if ([segue.identifier isEqualToString:@"editHospital"]){
        UALAddHospitalViewController* destino = [segue destinationViewController];
        destino.delegate = self;
        destino.idHospitalEdit = self.idHospitalSelected;
        destino.nombreHospitalEdit = self.nombreHospitalSelected;
        destino.localizacionHospitalEdit = self.localizacionHospitalSelected;
        destino.capacidadHospitalEdit = self.capacidadHospitalSelected;
        
    }
    else if ([segue.identifier isEqualToString:@"pacientesList"]){
        UALPacienteTableViewController* destino = [segue destinationViewController];
        destino.delegate = self;
        destino.idHospital = self.idHospitalSelected;
        destino.nombreHospital = self.nombreHospitalSelected;
    }
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int idRegistro;
    NSString *consulta;
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
    idRegistro = [[[self.arrayDatos objectAtIndex:indexPath.row]
                   objectAtIndex:0]intValue];
        consulta = [NSString stringWithFormat:@"delete from hospital where id=%d",idRegistro];
    
    [self.gestorBD executeQuery:consulta];
    [self cargarDatos];
    }
}

-(void) editionDidFinished{
    [self cargarDatos];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexOfId = [self.gestorBD.arrNombresCols indexOfObject:@"id"];
    NSInteger indexOfNombre = [self.gestorBD.arrNombresCols indexOfObject:@"nombre"];
    NSInteger indexOfLocalizacion = [self.gestorBD.arrNombresCols indexOfObject:@"localizacion"];
    NSInteger indexOfCapacidad = [self.gestorBD.arrNombresCols indexOfObject:@"capacidad"];


    
    self.idHospitalSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfId]intValue];
    self.nombreHospitalSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfNombre]];
    self.localizacionHospitalSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfLocalizacion]];
    self.capacidadHospitalSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfCapacidad]intValue];

    
    [self performSegueWithIdentifier:@"pacientesList" sender:self];

}

-(void) tableView: (UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *)indexPath{
    NSInteger indexOfId = [self.gestorBD.arrNombresCols indexOfObject:@"id"];
    NSInteger indexOfNombre = [self.gestorBD.arrNombresCols indexOfObject:@"nombre"];
    NSInteger indexOfLocalizacion = [self.gestorBD.arrNombresCols indexOfObject:@"localizacion"];
    NSInteger indexOfCapacidad = [self.gestorBD.arrNombresCols indexOfObject:@"capacidad"];
    
    
    
    self.idHospitalSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfId]intValue];
    self.nombreHospitalSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfNombre]];
    self.localizacionHospitalSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfLocalizacion]];
    self.capacidadHospitalSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfCapacidad]intValue];
    
    [self performSegueWithIdentifier:@"editHospital" sender:self];


}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
