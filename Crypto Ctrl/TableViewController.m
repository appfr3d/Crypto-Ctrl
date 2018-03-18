//
//  TableViewController.m
//  Crypto Ctrl
//
//  Created by Alfred Lieth Årøe on 03.01.2018.
//  Copyright © 2018 Alfred Lieth Årøe. All rights reserved.
//

#import "TableViewController.h"

#define kMaxWidgets 7

@interface TableViewController ()

@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Init variables
    listStart = 0;
    listEnd = 0;
    cryptoArray = [[NSMutableArray alloc] init];
    // widgetCryptoIdArray = [[NSMutableArray alloc] init];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"cryptoImageData" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    imageDataArray = [NSJSONSerialization JSONObjectWithData:jsonData options: 0 error:&error];
    
    
    NSUserDefaults *shard = [[NSUserDefaults alloc] initWithSuiteName:@"group.alfredla.Crypto-Ctrl"];
    
    NSData *widgetCryptoIdData = [shard objectForKey:@"widgetCryptoIdArray"];
    
    if (widgetCryptoIdData) {
        widgetCryptoIdArray = [NSKeyedUnarchiver unarchiveObjectWithData:widgetCryptoIdData];
    } else {
        widgetCryptoIdArray = [[NSMutableArray alloc] init];
    }
    
    
    // Download and set up crypto-data
    [self getAndUpdateCurrencyDataWithStart:0 andLimit:100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Downloade data

- (void)getAndUpdateCurrencyDataWithStart:(NSInteger)start andLimit:(NSInteger)limit {
    
    NSString *URLString = [NSString stringWithFormat:@"https://api.coinmarketcap.com/v1/ticker/?start=%li&limit=%li", (long)start, (long)limit];
    NSURL *URL = [NSURL URLWithString:URLString];
    
    [AppDelegate downloadDataFromURL:URL withCompletionHandler:^(NSData *data){
        if (data != nil) {
            NSError *error2;
            NSMutableArray *returnedArr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error2];
            if (error2 != nil) {
                NSLog(@"%@", [error2 localizedDescription]);
            } else {
                // Her kommer det ny data!
                
                for (NSInteger i = 0; i < limit; i++) {
                    // Gjør om dataen til CryptoObjekter
                    
                    NSString *idString = [[returnedArr objectAtIndex:i] objectForKey:@"id"];
                    NSString *name = [[returnedArr objectAtIndex:i] objectForKey:@"name"];
                    NSString *symbol = [[returnedArr objectAtIndex:i] objectForKey:@"symbol"];
                    NSString *rank = [[returnedArr objectAtIndex:i] objectForKey:@"rank"];
                    NSString *price_usd = [[returnedArr objectAtIndex:i] objectForKey:@"price_usd"];
                    NSString *price_btc = [[returnedArr objectAtIndex:i] objectForKey:@"price_btc"];
                    NSString *one_day_volume_usd = [[returnedArr objectAtIndex:i] objectForKey:@"24h_volume_usd"];
                    NSString *market_cap_usd = [[returnedArr objectAtIndex:i] objectForKey:@"market_cap_usd"];
                    NSString *available_supply = [[returnedArr objectAtIndex:i] objectForKey:@"available_supply"];
                    NSString *total_supply = [[returnedArr objectAtIndex:i] objectForKey:@"total_supply"];
                    NSString *percent_change_1h = [[returnedArr objectAtIndex:i] objectForKey:@"percent_change_1h"];
                    NSString *percent_change_24h = [[returnedArr objectAtIndex:i] objectForKey:@"percent_change_24h"];
                    NSString *percent_change_7d = [[returnedArr objectAtIndex:i] objectForKey:@"percent_change_7d"];
                    NSString *last_updated = [[returnedArr objectAtIndex:i] objectForKey:@"last_updated"];
                    
                    
                    NSString *imgId = @"";
                    for (NSInteger i = 0; i < imageDataArray.count; i++) {
                        if ([[[imageDataArray objectAtIndex:i] objectForKey:@"name"] isEqualToString:name]) {
                            imgId = [[imageDataArray objectAtIndex:i] objectForKey:@"id"];
                            break;
                        }
                    }
                    
                    CryptoObject *cryptoDataObject = [[CryptoObject alloc]
                                                      initWithId:idString
                                                      imgId:imgId
                                                      name:name
                                                      symbol:symbol
                                                      rank:rank
                                                      price_usd:price_usd
                                                      price_btc:price_btc
                                                      one_day_volume_usd:one_day_volume_usd
                                                      market_cap_usd:market_cap_usd
                                                      available_supply:available_supply
                                                      total_supply:total_supply
                                                      percent_change_1h:percent_change_1h
                                                      percent_change_24h:percent_change_24h
                                                      percent_change_7d:percent_change_7d
                                                      last_updated:last_updated];
                    
                    if ([cryptoArray count] < start+i) {
                        // Endre det eksisterende elementet
                        [cryptoArray replaceObjectAtIndex:start+i withObject:cryptoDataObject];
                    } else {
                        // Legg til et nytt element
                        [cryptoArray addObject:cryptoDataObject];
                    }
                    
                    if ([[cryptoArray objectAtIndex:start+i] getCryptoImage] == nil) {
                        [self getAndUpdateCurrencyImageWithIndex:start+i andId:imgId];
                        // NSLog(@"Caller img downloade\n");
                    }
                    
                }
                
                // Oppdater table-viewet!
                [self.tableView reloadData];
            }
        } else {
            NSLog(@"Returned dict is nil");
        }
        
    }];
}

- (void)getAndUpdateCurrencyImageWithIndex:(NSInteger)index andId:(NSString*)imgID {
    // Link found in sourcecode at coinmarketcap.com
    NSString *URLString = [NSString stringWithFormat:@"https://s2.coinmarketcap.com/static/img/coins/32x32/%@.png", imgID];
    NSURL *URL = [NSURL URLWithString:URLString];
    [AppDelegate downloadDataFromURL:URL withCompletionHandler:^(NSData *data){
        if (data != nil) {
            // Her kommer det ny data!
            [[cryptoArray objectAtIndex:index] setCryptoImage:[UIImage imageWithData:data]];
            [self.tableView reloadData];
        } else {
            NSLog(@"Image data is nil...\n");
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // NSLog(@"Reload..\n");
    return [cryptoArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CryptoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cryptoCell" forIndexPath:indexPath];
    
    CryptoObject *cryptoDataObject = [cryptoArray objectAtIndex:indexPath.row];
    
    // Name
    [cell.cryptoNameLabel setText:cryptoDataObject.name];
    
    // Price
    [cell.cryptoPriceLabel setText:[NSString stringWithFormat:@"US$ %@", cryptoDataObject.price_usd]];
    
    // Diff
    cell.cryptoDifferenceLabel.layer.masksToBounds = YES;
    [cell.cryptoDifferenceLabel.layer setCornerRadius:5.0f];
    
    NSString *diffText = [NSString stringWithFormat:@"%@%%", cryptoDataObject.percent_change_24h];
    if ([diffText containsString:@"-"]) {
        [cell.cryptoDifferenceLabel setBackgroundColor:[UIColor redColor]];
    } else {
        [cell.cryptoDifferenceLabel setBackgroundColor:[UIColor greenColor]];
        diffText = [NSString stringWithFormat:@"+%@", diffText];
    }
    [cell.cryptoDifferenceLabel setText:diffText];
    
    // Image
    if (cryptoDataObject.image != nil) {
        [cell.cryptoImageView setImage:cryptoDataObject.image];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return [widgetCryptoIdArray count] <= 7;
}
*/

// Function found at: https://medium.com/ios-os-x-development/enable-slide-to-delete-in-uitableview-9311653dfe2
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *idString = [[cryptoArray objectAtIndex:indexPath.row] getCryptoIdString];
    BOOL add = ![widgetCryptoIdArray containsObject:idString];
    
    NSString *title = add ? @"Add to\nwidget!" : @"Remove from\nwidget!";
    
    UITableViewRowAction *addToWidget = [UITableViewRowAction
                                         rowActionWithStyle:UITableViewRowActionStyleNormal
                                         title:title
                                         handler:^(UITableViewRowAction *action, NSIndexPath *indexP) {
                                             
                                             // Legg til eller fjern
                                             if ([widgetCryptoIdArray count] < kMaxWidgets && add) {
                                                 [widgetCryptoIdArray addObject:idString];
                                             } else if (!add) {
                                                 [widgetCryptoIdArray removeObject:idString];
                                             }
                                             
                                             // Oppdater NSUserDefaults
                                             NSData *data = [NSKeyedArchiver archivedDataWithRootObject:widgetCryptoIdArray];
                                             
                                             NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.alfredla.Crypto-Ctrl"];
                                             
                                             [shared setObject:data forKey:@"widgetCryptoIdArray"];
                                             [shared synchronize];
                                             
                                             // "Lukk" raden
                                             [tableView setEditing:NO animated:YES];
                                         }];

    // TODO: Sjekk om den er med på widgets allerede (rød farge hvis med fra før, grønn farge hvis ikke med fra før)
    // og om det er plass til flere i widgeten eller ikke
    
    if (add) {
        [addToWidget setBackgroundColor:[UIColor greenColor]];
    } else {
        [addToWidget setBackgroundColor:[UIColor redColor]];
    }
    
    return @[addToWidget];
}


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
