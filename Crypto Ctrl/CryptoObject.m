//
//  CryptoObject.m
//  Crypto Ctrl
//
//  Created by Alfred Lieth Årøe on 03.01.2018.
//  Copyright © 2018 Alfred Lieth Årøe. All rights reserved.
//

#import "CryptoObject.h"

@implementation CryptoObject

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
              last_updated:(NSString *)last_updated
                     {
    self = [super init];
    if (self) {
        _idString = idString;
        _imgId = imgId;
        _name = name;
        _symbol = symbol;
        _rank = rank;
        _price_usd = price_usd;
        _price_btc = price_btc;
        _one_day_volume_usd = one_day_volume_usd;
        _market_cap_usd = market_cap_usd;
        _available_supply = available_supply;
        _total_supply = total_supply;
        _percent_change_1h = percent_change_1h;
        _percent_change_24h = percent_change_24h;
        _percent_change_7d = percent_change_7d;
        _last_updated = last_updated;
        
        if (!_image) {
            _image = nil;
        }
    }
    return self;
}

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
            last_updated:(NSString *)last_updated {
    _idString = idString;
    _imgId = imgId;
    _name = name;
    _symbol = symbol;
    _rank = rank;
    _price_usd = price_usd;
    _price_btc = price_btc;
    _one_day_volume_usd = one_day_volume_usd;
    _market_cap_usd = market_cap_usd;
    _available_supply = available_supply;
    _total_supply = total_supply;
    _percent_change_1h = percent_change_1h;
    _percent_change_24h = percent_change_24h;
    _percent_change_7d = percent_change_7d;
    _last_updated = last_updated;
    
}

- (void)setCryptoImage:(UIImage *)image {
    _image = image;
}

- (UIImage *)getCryptoImage {
    return _image;
}

- (NSString *)getCryptoIdString {
    return _idString;
}


@end
