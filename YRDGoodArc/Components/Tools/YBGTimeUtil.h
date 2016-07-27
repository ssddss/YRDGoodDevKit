//
//  LYTimeUtil.h
//  LYCampus-iPhone
//
//  Created by MAC-LY001 on 14-2-14.
//  Copyright (c) 2014年 广州联奕信息科技有限公司. All rights reserved.
//
/// @项目名称    联奕演示平台 1.0
/// @模块名称    时间转换工具类
/// @功能说明    提供时间转换的方法
/// @模块版本    1.0.0.0 （适用底层功能模块）

#import <Foundation/Foundation.h>

@interface YBGTimeUtil : NSObject
/**
 *  获取单例
 *
 *  @return
 */
+ (YBGTimeUtil *)sharedInstance;
/**
 *  比较第一个日期相比第二个日期早，等，还是晚
 *
 *  @param firstDate  <#firstDate description#>
 *  @param secondDate <#secondDate description#>
 */
- (NSComparisonResult)firstDate:(NSDate *)firstDate compareSecondDate:(NSDate *)secondDate;
/**
 通过NSDate对象获取星期几
 */
- (NSInteger)weekdayIndexByDate:(NSDate *)date;
/**
 *  获取时间相对当前的分钟数
 *
 *  @param date
 *
 *  @return   大于0表示将来，小于0表示过去式
 */
- (NSInteger)minutesOfTodaySinceNow:(NSString *)clockTime;
/**
 通过NSDate对象获取日期
 */
-(NSInteger)dayIndexByDate:(NSDate *)date;
/**
 通过NSDate对象获取星期几
 */
-(NSInteger)monthIndexByDate:(NSDate *)date;
/**
 通过NSDate对象获取星期几
 */
-(NSInteger)yearIndexByDate:(NSDate *)date;
/**
 通过NSDate对象获取短日期字符串
 */
- (NSString *)dateStringByDate:(NSDate *)date;
/**
 按照字符串获取日期
 */
- (NSDate *)dateByDateString:(NSString *)dateStr;
/**
 通过NSDate对象获取月份字符串
 */
-(NSInteger)monthIndex:(NSDate *)date;
/**
 * 通过NSDate对象获取月份字符串
 */
-(NSString *)monthStringByDate:(NSDate *)date;

/**
 * 通过计算天数之差，获取中文格式化的时间
 */
-(NSString *)formatTimeStr:(NSString *)timeStr;
/**
 转化没有秒数的时间字符串
 **/
-(NSDate *)dateByTimeString:(NSString *)timeStr;
/**
 计算传入的时间字符串与当前的时间差
 相差超过一天则返回日期
 **/
-(NSString *)compareTimeByTimeStr:(NSString *)timeStr;
/**
 计算消息列表的时间
 **/
-(NSString *)messageTimeByTimeStr:(NSString *)timeStr;
/**
 获取校圈的时间
 **/
-(NSString *)schoolCircleTimeByTimeStr:(NSString *)timeStr;
/**
 校圈详情的时间
 **/
-(NSString *)detailSchoolCircleTimeByTimeStr:(NSString *)timeStr;
/**
 *  计算两个天之间的天数之差
 */
- (NSInteger)daysBetweenDay:(NSString *)day anotherDay:(NSString *)anotherDay;
/**
 *  计算和某天相差几天的日期是那一天
 */
- (NSDate *)dateByComparingWithDate:(NSDate *)aDate totalDays:(NSInteger)day;
/**
 通过nsdate获取时间字符串
 **/
-(NSString *)timeStrByDate:(NSDate *)date;
/**
 更新时间转换
 **/
-(NSString *)formatRefreshTime:(NSString *)timeStr;

/**
 *  距离多少分钟的时间
 *
 *  @param aDate
 *  @param minutes
 *
 *  @return
 */
- (NSDate *)dateByComparingWithDate:(NSDate *)aDate totalMinutes:(NSInteger)minutes;
/**
 *  根据时间获取当前日期整周的数据，周日为第一天
 *
 *  @param date
 *
 *  @return
 */
- (NSArray *)getDateInWeek:(NSDate *)date;
/**
 *  检测日期是否在当前周里，周日为第一天
 *
 *  @param date
 *
 *  @return
 */
- (BOOL)checkDateInCurrentWeek:(NSString *)date;
@end
