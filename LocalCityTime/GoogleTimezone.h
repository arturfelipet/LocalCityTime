//
//  GoogleTimezone.h
//  Abyara e Brasil Brokers
//
//  Created by Artur Felipe on 7/24/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^GoogleTimezoneBlock) (NSString *localTime, NSError *error);

@interface GoogleTimezone : NSObject

+(void)getTimezoneFor:(CLLocationCoordinate2D)location completionBlock:(GoogleTimezoneBlock)completionBlock;

@end
