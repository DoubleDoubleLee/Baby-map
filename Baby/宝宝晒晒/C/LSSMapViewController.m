//
//  LSSMapViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface LSSMapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

{
    MKMapView * _map;
    CLLocationManager * _locationManager;
    MKPointAnnotation * _annotation1;
}

@end

@implementation LSSMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createMap];
    [self setLocation];
    
   // [self addLongPressGesture];

}
-(void)setLocation{
    //创建定位管理器
    _locationManager=[[CLLocationManager alloc]init];
   
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前尚未打开,请设置打开!");
        return;
    }
    //设置代理
    
     _locationManager.delegate=self;
    //设置定位精度
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //定位频率 每隔多少米定位一次
    _locationManager.distanceFilter=100;
    //如果没有授权,就请求授权
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
        [_locationManager requestAlwaysAuthorization];
        //[_locationManager startUpdatingLocation];
    }
        //启动跟踪定位 3.开始监听(开始获取位置)
        [_locationManager startUpdatingLocation];
}

-(void)createMap{
    _map=[[MKMapView alloc]initWithFrame:self.view.frame];
    _map.mapType=MKMapTypeStandard;//默认地图
    _map.scrollEnabled=YES;
    _map.delegate=self;
    
    if ([CLLocationManager locationServicesEnabled]==YES) {
        _map.showsUserLocation=YES;
    }

   [self.view addSubview:_map];

}

#pragma mark--给地图添加大头针
-(void)addLongPressGesture{
    UILongPressGestureRecognizer * longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [_map addGestureRecognizer:longPress];
}
-(void)longPress:(UILongPressGestureRecognizer*)longPress{
    //判断是否开始长按
    if (longPress.state==UIGestureRecognizerStateBegan) {
        //1.拿到点击的位置
        CGPoint point=[longPress locationInView:self.view];
        //2.将位置转化成坐标 Coordinate 坐标
        CLLocationCoordinate2D coordinate=[_map convertPoint:point toCoordinateFromView:_map];
        //3.创建系统大头针
        MKPointAnnotation * annotation=[[MKPointAnnotation alloc]init];
        //4.设置坐标
        annotation.coordinate=coordinate;
        annotation.title=@"我的选择";
        annotation.subtitle=@"详细地址";
        [_map addAnnotation:annotation];
    }
}
/**
 *  授权状态发生改变时调用
 *
 *  @param manager 触发事件的对象
 *  @param status  当前授权的状态
 */

//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    if (status == kCLAuthorizationStatusNotDetermined) {
//        NSLog(@"等待用户授权");
//    }else if (status == kCLAuthorizationStatusAuthorizedAlways ||
//              status == kCLAuthorizationStatusAuthorizedWhenInUse)
//        
//    {
//        NSLog(@"授权成功");
//        // 开始定位
//        [_locationManager startUpdatingLocation];
//        
//    }else
//    {
//        NSLog(@"授权失败");
//    }
//}

#pragma mark - CLLocationManagerDelegate
/**
 *  获取到位置信息之后就会调用(调用频率非常高)
 *
 *  @param manager   触发事件的对象
 *  @param locations 获取到的位置
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * location=[locations lastObject];//取出最后的位置
 
    NSLog(@"经度:%f  纬度:%f",location.coordinate.longitude,location.coordinate.latitude);
    //如果不需要实时定位，使用完即使关闭定位服务 如果只需要获取一次, 可以获取到位置之后就停止
   // [_locationManager stopUpdatingLocation];
    
    //2.设置大头针显示的位置
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    _map.centerCoordinate = coordinate;
    //确定一个范围，以某经纬度为中心，经度（南北）距离和纬度（东西）距离构成一个长方体活着正方形
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 30000, 30000);
    _map.region =region;
    
    //3.设置大头针的标题
    _annotation1=[[MKPointAnnotation alloc]init];
    _annotation1.title=@"北科";
    _annotation1.subtitle=@"千峰";
    _annotation1.coordinate = coordinate;
    [_map removeAnnotations:_map.annotations];
    
   // [_map addAnnotations:@[_annotation1]];
    [_map addAnnotation:_annotation1];

    
}
#pragma mark - 懒加载
- (CLLocationManager *)mgr
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
