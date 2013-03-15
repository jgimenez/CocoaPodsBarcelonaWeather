//
//  JGCurrentWeatherViewController.m
//  CocoaPodsPlayground
//
//  Created by gimix on 3/14/13.
//  Copyright (c) 2013 Jordi Gim√©nez. All rights reserved.
//

#import "JGCurrentWeatherViewController.h"
#import "JGWLWundergroundServer.h"
#import "WUNDERGROUND_API_KEY.h"

@interface JGCurrentWeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@property (strong, nonatomic) JGWLWundergroundServer* server;

@end

@implementation JGCurrentWeatherViewController

- (void)viewDidAppear:(BOOL)animated
{
    [self reloadWeather];
}

- (IBAction)reloadButtonTouch:(id)sender {
    [self reloadWeather];
}

- (void)reloadWeather
{
    [self.server currentWeatherIn:kWundergroundServerCitySpainBarcelona
                        onSuccess:^(JGWLCurrentWeather * weather) {
        self.weatherLabel.text = weather.weather;
        self.temperatureLabel.text = [NSString stringWithFormat:@"%dº", weather.temp_c.intValue];
    } onFailure:^(NSError * error) {
        [[[UIAlertView alloc] initWithTitle:@"Could not load weather" message:@"Please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

#pragma mark - Helpers
-(JGWLWundergroundServer *)server
{
    if(_server == nil)
        _server = [[JGWLWundergroundServer alloc] initWithApiKey:WUNDERGROUND_API_KEY];
    return _server;
}

@end
