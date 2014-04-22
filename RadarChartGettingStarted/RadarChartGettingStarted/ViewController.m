//
//  ViewController.m
//  RadarChartGettingStarted
//
//  Created by Thomas Kelly on 08/04/2014.
//
//  Copyright 2014 Scott Logic
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ViewController.h"
#import <ShinobiCharts/ShinobiChart.h>

@interface ViewController () <SChartDatasource>

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	  // Do any additional setup after loading the view, typically from a nib.
    
    [ShinobiCharts setLicenseKey:@""]; //Trial Users - Set your licence key here
   
    [self setupData];
    
    //Create the chart
    ShinobiChart *chart = [[ShinobiChart alloc] initWithFrame:self.view.bounds
                                         withPrimaryXAxisType:SChartAxisTypeCategory
                                         withPrimaryYAxisType:SChartAxisTypeNumber];
    
    //Customise the axes
    chart.yAxis.majorTickFrequency = @1;
    chart.yAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    chart.yAxis.style.majorGridLineStyle.lineColor = [UIColor colorWithWhite:0.8 alpha:1];
    
    chart.datasource = self;
    [self.view addSubview:chart];
}

-(void)setupData
{
    self.categories = @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
    
    NSMutableArray *datasets = [NSMutableArray array];
    //Add first data set
    [datasets addObject:@{@"Jan": @1.1,
                          @"Feb": @2.2,
                          @"Mar": @3.3,
                          @"Apr": @4.4,
                          @"May": @5.5,
                          @"Jun": @7.0,
                          @"Jul": @6.7,
                          @"Aug": @5.8,
                          @"Sep": @4.9,
                          @"Oct": @3.0,
                          @"Nov": @2.1,
                          @"Dec": @1.2}];
    //Add second data set
    [datasets addObject:@{@"Jan": @4.5,
                          @"Feb": @4.6,
                          @"Mar": @2.7,
                          @"Apr": @2.8,
                          @"May": @0.9,
                          @"Jun": @0.0,
                          @"Jul": @2.1,
                          @"Aug": @2.2,
                          @"Sep": @4.3,
                          @"Oct": @4.4,
                          @"Nov": @7.5,
                          @"Dec": @7.6}];
    self.data = datasets;
}

#pragma mark - Datasource

-(NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart
{
    return self.data.count;
}

-(NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
{
    return self.categories.count;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index
{
    //Use a radial chart and series
    SChartRadialLineSeries *radialSeries = [SChartRadialLineSeries new];
    //Draw connecting line between first and last datapoint
    radialSeries.pointsWrapAround = YES;
    return radialSeries;
}

-(id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex
{
    SChartDataPoint *dp = [SChartDataPoint new];
    dp.xValue = self.categories[dataIndex];
    dp.yValue = [self.data[seriesIndex] objectForKey:dp.xValue];
    return dp;
}

@end
