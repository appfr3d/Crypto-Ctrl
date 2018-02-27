//
//  TodayViewController.h
//  Crypto Ctrl Widget
//
//  Created by Alfred Lieth Årøe on 03.01.2018.
//  Copyright © 2018 Alfred Lieth Årøe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CryptoWidgetObject.h"
#import "WidgetTableViewCell.h"

@interface TodayViewController : UIViewController {
    NSMutableArray *widgetCryptoIdArray;    // ID
    NSMutableArray *cryptoDataArray;        // All data
    NSArray *imageDataArray;                // Data for images
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
