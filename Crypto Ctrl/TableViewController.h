//
//  TableViewController.h
//  Crypto Ctrl
//
//  Created by Alfred Lieth Årøe on 03.01.2018.
//  Copyright © 2018 Alfred Lieth Årøe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CryptoTableViewCell.h"
#import "CryptoObject.h"

@interface TableViewController : UITableViewController {
    NSInteger *listStart;
    NSInteger *listEnd;
    NSMutableArray *cryptoArray;
    NSMutableArray *widgetCryptoIdArray;
    NSArray *imageDataArray;
}
@end
