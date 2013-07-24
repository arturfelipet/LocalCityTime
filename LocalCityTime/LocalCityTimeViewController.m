//
//  LocalCityTimeViewController.m
//  LocalCityTime
//
//  Created by Artur Felipe on 7/24/13.
//  Copyright (c) 2013 own. All rights reserved.
//

#import "LocalCityTimeViewController.h"
#import "GoogleTimezone.h"

@interface LocalCityTimeViewController ()
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@end

@implementation LocalCityTimeViewController

@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-25.41632 longitude:-49.26183 zoom:2];
	
	[mapView setCamera:camera];
	[mapView setMyLocationEnabled:NO];
	[mapView setMapType:kGMSTypeNormal];
	[mapView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(GMSMapView *)mapViewp didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
	GMSMarker *marker = [[GMSMarker alloc] init];
	[marker setPosition:coordinate];
	[marker setTitle:@"Location"];
	[marker setSnippet:[NSString stringWithFormat:@"Lat: %f, Lng: %f", coordinate.latitude, coordinate.longitude]];
	[marker setAnimated:NO];
	
	[GoogleTimezone getTimezoneFor:coordinate completionBlock:^(NSString *localTime, NSError *error) {
		[marker setTitle:localTime];
		[mapView setSelectedMarker:marker];
	}];

	[marker setMap:mapView];
	
	[mapView setSelectedMarker:marker];
}

@end
