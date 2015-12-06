//
//  HomeViewController.m
//  FieldArea
//
//  Created by Bikram Dangol on 12/5/15.
//  Copyright © 2015 AppCoders. All rights reserved.
//

#import "HomeViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface HomeViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *availableFieldAreaArray;

@end

@implementation HomeViewController

-(NSMutableArray *)availableFieldAreaArray
{
        if (!_availableFieldAreaArray){
                _availableFieldAreaArray = [[NSMutableArray alloc] init];
        }
        return _availableFieldAreaArray;
}

- (IBAction)logoutPressed:(UIBarButtonItem *)sender {
        [[FBSDKLoginManager new] logOut];
        [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender {
        [self performSegueWithIdentifier:@"homeToAreaCalculatorSegue" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.availableFieldAreaArray = [@[@"Bikram's Field", @"Babu's Field", @"Aaron's Field"] mutableCopy];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [self.availableFieldAreaArray count];
        //return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.availableFieldAreaArray[indexPath.row];
        cell.detailTextLabel.text = @"12/06/2015";
        return cell;
}


@end
