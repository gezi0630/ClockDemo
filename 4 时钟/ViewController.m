//
//  ViewController.m
//  4 时钟
//
//  Created by MAC on 2017/8/21.
//  Copyright © 2017年 GuoDongge. All rights reserved.
//

#import "ViewController.h"
//时钟的宽度
#define kClockW _clockView.bounds.size.width

#define angle2radion(angle) ((angle) / 180.0 * M_PI)

//一小时时针转30度
#define perHourA 30
//每分钟时针旋转0.5˚
#define perMinHourA 0.5

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockView;

/**秒针Layer*/
@property(nonatomic,weak)CALayer * secondLayer;
/**分针Layer*/
@property(nonatomic,weak)CALayer * minuteLayer;
/**时针Layer*/
@property(nonatomic,weak)CALayer * hourLayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加时针
    [self setUpHourLayer];
    
    //添加分针
    [self setUpMinuteLayer];
    
    //添加秒针
    [self setUpSecondLayer];
    
    //添加定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    [self timeChange];
    
    
}



/*************/

-(void)timeChange
{
    NSLog(@"%s",__func__);
    
    //获取当前日历对象
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    //获取日期的组件
    //components: 需要获取的日期组件
    //fromDate:获取哪个日期的组件
     NSDateComponents  *cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    //获取秒
    NSInteger second = cmp.second;
    
    //获取分
    NSInteger minute = cmp.minute;
    
    //获取小时
    NSInteger  hour = cmp.hour;
    
    
    //计算秒针旋转多少度
    CGFloat secondA = second * 6;
    
    //计算分针旋转多少度
    CGFloat minuteA = minute * 6;
    
    //计算时针旋转多少度
    CGFloat hourA = hour * perHourA + minute * perMinHourA;
    
    
    //旋转秒针
    _secondLayer.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
    
    //旋转分针
    _minuteLayer.transform = CATransform3DMakeRotation(angle2radion(minuteA), 0, 0, 1);
    
    
    
    //旋转时针
    _hourLayer.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);
}


#pragma mark - 添加秒针

-(void)setUpSecondLayer
{
    CALayer *secondL = [CALayer layer];
    
    secondL.backgroundColor = [UIColor redColor].CGColor;
    
    //设置锚点
    secondL.anchorPoint = CGPointMake(0.5, 1);
    
    //位置
    secondL.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    secondL.bounds = CGRectMake(0, 0, 2, kClockW * 0.5 - 20);
    
    [_clockView.layer addSublayer:secondL];
    
    _secondLayer = secondL;
    
    
    
}

#pragma mark - 添加分针

-(void)setUpMinuteLayer
{
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    //设置锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 -20);
    layer.cornerRadius = 2;
    
    [_clockView.layer addSublayer:layer];
    
    _minuteLayer = layer;
    
    
}

#pragma mark - 添加时针

-(void)setUpHourLayer
{
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    //设置锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 -40);
    layer.cornerRadius = 2;
    
    [_clockView.layer addSublayer:layer];
    
    _hourLayer = layer;

}





@end
