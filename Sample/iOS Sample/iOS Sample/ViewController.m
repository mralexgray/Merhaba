//
//  ViewController.m
//  iOS Sample
//
//  Created by Abdullah Selek on 13/01/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.services = [[NSMutableArray alloc] init];

    NSString *type = @"TestingProtocol";
    self.server = [[MRBServer alloc] initWithProtocol:type];
    self.server.delegate = self;

    BOOL isStarted = [self.server start];
    NSLog(@"Check server started : %@", (isStarted) ? @"YES" : @"NO");
}

#pragma mark MRBServer Delegate functions

- (void)serverRemoteConnectionComplete:(MRBServer *)server {

}

- (void)serverStopped:(MRBServer *)server {

}

- (void)server:(MRBServer *)server didNotStart:(NSDictionary *)errorDict {

}

- (void)server:(MRBServer *)server didAcceptData:(NSData *)data {

}

- (void)server:(MRBServer *)server lostConnection:(NSDictionary *)errorDict {

}

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more {
    NSLog(@"Added a service: %@", [service name]);
    [self.services addObject:service];
    [self refeshTableView:more];
}

- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more {
    NSLog(@"Removed a service: %@", [service name]);
    [self.services removeObject:service];
    [self refeshTableView:more];
}

#pragma mark UITableView Helpers

- (void)refeshTableView:(BOOL)more {
    if(!more) {
        [self.tableView reloadData];
    }
}

#pragma mark UITableView Delegate functions

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.services count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"MRBServerTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [[self.services objectAtIndex:indexPath.row] name];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
