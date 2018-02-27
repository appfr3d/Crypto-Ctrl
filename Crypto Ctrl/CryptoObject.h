//
//  CryptoObject.h
//  Crypto Ctrl
//
//  Created by Alfred Lieth Årøe on 03.01.2018.
//  Copyright © 2018 Alfred Lieth Årøe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CryptoObject : NSObject
- (instancetype)initWithId:(NSString *)idString
                     imgId:(NSString *)imgId
                      name:(NSString *)name
                    symbol:(NSString *)symbol
                      rank:(NSString *)rank
                 price_usd:(NSString *)price_usd
                 price_btc:(NSString *)price_btc
        one_day_volume_usd:(NSString *)one_day_volume_usd
            market_cap_usd:(NSString *)market_cap_usd
          available_supply:(NSString *)available_supply
              total_supply:(NSString *)total_supply
         percent_change_1h:(NSString *)percent_change_1h
        percent_change_24h:(NSString *)percent_change_24h
         percent_change_7d:(NSString *)percent_change_7d
              last_updated:(NSString *)last_updated;


- (void)updateDataWithId:(NSString *)idString
                   imgId:(NSString *)imgId 
                    name:(NSString *)name
                  symbol:(NSString *)symbol
                    rank:(NSString *)rank
               price_usd:(NSString *)price_usd
               price_btc:(NSString *)price_btc
      one_day_volume_usd:(NSString *)one_day_volume_usd
          market_cap_usd:(NSString *)market_cap_usd
        available_supply:(NSString *)available_supply
            total_supply:(NSString *)total_supply
       percent_change_1h:(NSString *)percent_change_1h
      percent_change_24h:(NSString *)percent_change_24h
       percent_change_7d:(NSString *)percent_change_7d
            last_updated:(NSString *)last_updated;

// Getters and setters
- (void)setCryptoImage:(UIImage *)image;
- (UIImage *)getCryptoImage;
- (NSString *)getCryptoIdString;

@property NSString *idString;
@property NSString *imgId;
@property NSString *name;
@property NSString *symbol;
@property NSString *rank;
@property NSString *price_usd;
@property NSString *price_btc;
@property NSString *one_day_volume_usd;
@property NSString *market_cap_usd;
@property NSString *available_supply;
@property NSString *total_supply;
@property NSString *percent_change_1h;
@property NSString *percent_change_24h;
@property NSString *percent_change_7d;
@property NSString *last_updated;
@property UIImage *image;


@end
