//
//  GoogleTimezone.m
//  Abyara e Brasil Brokers
//
//  Created by Artur Felipe on 7/24/13.
//
//

#import "GoogleTimezone.h"
#import "AFNetworking.h"

@implementation GoogleTimezone

+(void)getTimezoneFor:(CLLocationCoordinate2D)location completionBlock:(GoogleTimezoneBlock)completionBlock
{
    GoogleTimezoneBlock completeBlock = [completionBlock copy];
    
    NSString* saddr = [NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude];
    
    //https://maps.googleapis.com/maps/api/timezone/json?location=-25.41632,-49.26183&timestamp=1331161200&sensor=false
	
	double timestamp = [[NSDate date] timeIntervalSince1970];
	
    NSString *connectionString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/timezone/json?location=%@&timestamp=%f&sensor=false", saddr, timestamp];
    
    NSURL *url = [NSURL URLWithString:connectionString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
		NSString *timezoneName = [JSON objectForKey:@"timeZoneId"];
		NSTimeZone *timezone = [NSTimeZone timeZoneWithName:timezoneName];
		
		NSDateFormatter *localTimeFormat = [[NSDateFormatter alloc] init];
		[localTimeFormat setTimeZone:timezone];
		[localTimeFormat setDateFormat:@"h:mm a"];
		NSDate *localTime = [[NSDate alloc] init];
		NSString *localTimeString = [localTimeFormat stringFromDate:localTime];
        
        completeBlock(localTimeString, nil);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
		NSMutableDictionary* details = [NSMutableDictionary dictionary];
		[details setValue:[error description] forKey:NSLocalizedDescriptionKey];

		NSError *err = [NSError errorWithDomain:@"world" code:200 userInfo:details];		
		completeBlock(NO, err);
    }];
    [operation start];
}

@end

