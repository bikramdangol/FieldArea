//
//  HomeViewController.m
//  FieldArea
//
//  Created by Bikram Dangol on 12/5/15.
//  Copyright © 2015 AppCoders. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface HomeViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *availableFieldArray;

@end

@implementation HomeViewController

-(NSMutableArray *)availableFieldArray
{
        if (!_availableFieldArray){
                _availableFieldArray = [[NSMutableArray alloc] init];
        }
        return _availableFieldArray;
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
}

-(void) viewWillAppear:(BOOL)animated
{
        // Find all Field records by the current user
        PFUser *user = [PFUser currentUser];
        if (user != nil) {
                PFQuery *query = [PFQuery queryWithClassName:@"Field"];
                [query whereKey:@"user" equalTo:user];
                [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                        if (!error) {
                                self.availableFieldArray = [objects mutableCopy];
                                [self.tableView reloadData];
                        }
                }];
        }
        
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
        return [self.availableFieldArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.availableFieldArray[indexPath.row][@"name"];
        NSDate *date = (NSDate *)self.availableFieldArray[indexPath.row][@"date"];
        
        NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
        [dateformat setDateFormat:@"mm/dd/yyyy"]; // Date formatter
        NSString *dateString = [dateformat stringFromDate:date];
        
        cell.detailTextLabel.text = dateString;
        return cell;
}


@end
