//
//  LYTimeUtil.m
//  LYCampus-iPhone
//
//  Created by MAC-LY001 on 14-2-14.
//  Copyright (c) 2014年 广州联奕信息科技有限公司. All rights reserved.
//

#import "YBGTimeUtil.h"

@interface YBGTimeUtil ()
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) NSCalendar *calendar;
@end

@implementation YBGTimeUtil
+ (YBGTimeUtil *)sharedInstance {
    static YBGTimeUtil *_shareHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareHelper = [[YBGTimeUtil alloc]init];
    });
    
    return _shareHelper;
}
- (NSComparisonResult)firstDate:(NSDate *)firstDate compareSecondDate:(NSDate *)secondDate {
    NSComparisonResult result = [firstDate compare:secondDate];
    NSLog(@"date1 : %@, date2 : %@", firstDate, secondDate);
    if (result == NSOrderedDescending) {
        NSLog(@"Date1  is in the future");
        return result;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"Date1 is in the past");
        return result;
    }
    else {
        NSLog(@"Both dates are the same");
    }
    return result;
}
- (NSDate *)dateByComparingWithDate:(NSDate *)aDate totalDays:(NSInteger)day
{
    NSDateComponents *components = [self.calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];

    
    [components setHour:day*24];
    [components setMinute:0];
    [components setSecond:0];
    return [self.calendar dateByAddingComponents:components toDate: aDate options:0];
}
- (NSDate *)dateByComparingWithDate:(NSDate *)aDate totalMinutes:(NSInteger)minutes
{
    NSDateComponents *components = [self.calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
    
    
    [components setHour:0];
    [components setMinute:minutes];
    [components setSecond:0];
    return [self.calendar dateByAddingComponents:components toDate: aDate options:0];
}
- (NSInteger)weekdayIndexByDate:(NSDate *)date
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [self.calendar components:unitFlags fromDate:date];
    return [comps weekday]-1;
}
- (NSInteger)daysBetweenDay:(NSString *)day anotherDay:(NSString *)anotherDay {
   
    NSDate *firstTimeDate = [self dateByDateString:day];

    NSDate *secondTimeDate = [self dateByDateString:anotherDay];

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [self.calendar components:unitFlags fromDate:firstTimeDate toDate:secondTimeDate options:0];
    return labs([comps day]);

}
- (NSInteger)minutesOfTodaySinceNow:(NSString *)clockTime {
    NSDate *currentDate = [NSDate date];
    NSString *currentYearDate = [self dateStringByDate:currentDate];
    NSDate *targetTimeDate = [self dateByDateString:[currentYearDate stringByAppendingString:[NSString stringWithFormat:@" %@:00",clockTime]]];
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [self.calendar components:unitFlags fromDate:[NSDate date] toDate:targetTimeDate options:0];
    //    comps = [calendar components:unitFlags fromDate:date];
    return [comps minute] + [comps hour]*60;
    
}
- (NSInteger)dayIndexByDate:(NSDate *)date
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [self.calendar components:unitFlags fromDate:date];
    return [comps day];
}

- (NSInteger)monthIndexByDate:(NSDate *)date
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [self.calendar components:unitFlags fromDate:date];
    return [comps month];
}

- (NSInteger)yearIndexByDate:(NSDate *)date
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [self.calendar components:unitFlags fromDate:date];
    return [comps year];
}

- (NSString *)ChineseNameForWeekdayIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return @"星期日";
            break;
        case 1:
            return @"星期一";
            break;
        case 2:
            return @"星期二";
            break;
        case 3:
            return @"星期三";
            break;
        case 4:
            return @"星期四";
            break;
        case 5:
            return @"星期五";
            break;
        case 6:
            return @"星期六";
            break;
        default:
            break;
    }
    return nil;
}

- (NSDate *)dateByDateString:(NSString *)dateStr
{
    if (dateStr.length<11) {
        [self.formatter setDateFormat:@"yyyy-MM-dd"];
    }
    else if(dateStr.length < 18) {
        [self.formatter setDateFormat: @"yyyy-MM-dd HH:mm"];
        
    }
    else{
        [self.formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    }
    [self.formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date=[self.formatter dateFromString:dateStr];
    return date;
}

- (NSString *)dateStringByDate:(NSDate *)date;
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (NSInteger)monthIndex:(NSDate *)date
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [self.calendar components:unitFlags fromDate:date];
    NSInteger month = [comps month];
    return month;
}

- (NSString *)monthStringByDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:date];
    NSString *sub = [str substringToIndex:7];
    return sub;
}

- (NSString *)compareTimeByTimeStr:(NSString *)timeStr{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:timeStr];
    NSDate * now = [NSDate date];
    NSTimeInterval dateInterval = [date timeIntervalSince1970]*1;
    NSTimeInterval nowInterval = [now timeIntervalSince1970]*1;
    NSTimeInterval cha = nowInterval - dateInterval;
    NSString *timeString=@"";
    if (cha/5*60<1) {
        timeString = @"刚刚";
    }
    if (cha/5*60>1&&cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
//        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//        [dateformatter setDateFormat:@"HH:mm"];
//        timeString = [NSString stringWithFormat:@"今天 %@",[dateformatter stringFromDate:d]];
    }
    if (cha/86400>1)
    {
        //        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        //        timeString = [timeString substringToIndex:timeString.length-7];
        //        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        timeString = timeStr;
    }
    return timeString;
}

- (NSString *)schoolCircleTimeByTimeStr:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:timeStr];
    NSDate * nowDate = [NSDate date];
    
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *dateComponents = [self.calendar components:unitFlags fromDate:date];
    NSDateComponents *nowComponents = [self.calendar components:unitFlags fromDate:nowDate];
    if ([dateComponents year]!=[nowComponents year]) {
        //显示月日
        return [timeStr substringWithRange:NSMakeRange(5, 5)];
    }
    else if ([dateComponents day]==[nowComponents day]&&[dateComponents month]==[nowComponents month]) {
        //今天
        NSTimeInterval dateInterval = [date timeIntervalSince1970]*1;
        NSTimeInterval nowInterval = [nowDate timeIntervalSince1970]*1;
        NSTimeInterval cha = nowInterval - dateInterval;
        NSString *timeString=@"";
        
        NSString* str;
        if (fmodf(cha, 1)==0) {
            
            str = [NSString stringWithFormat:@"%.0f",cha];

        } else if (fmodf(cha*10, 1)==0) {
            str = [NSString stringWithFormat:@"%.1f",cha];
        } else {
            str = [NSString stringWithFormat:@"%.2f",cha];
        }
        
        
        float chas = [str integerValue];
//        NSLog(@"%f",chas/5*60);
        if (chas/(5*60)<=1.0f) {
            timeString = @"刚刚";
        }
        else if (chas/(5*60)>1.0f&&cha/3600<1.0f) {
            timeString = [NSString stringWithFormat:@"%f", chas/60];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        }
        else if (chas/3600>1.0f) {
            timeString = [NSString stringWithFormat:@"%f", chas/3600];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
        }else{
            timeString = [NSString stringWithFormat:@"%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
        }
        return timeString;
//        return [NSString stringWithFormat:@"今天%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
    }else if ([nowComponents day]-[dateComponents day]==1&&[dateComponents month]==[nowComponents month]){
        //昨天
        return @"昨天";
    }else if ([nowComponents day]-[dateComponents day]>1&&[dateComponents month]==[nowComponents month]){
        //同一个月显示几天前
        return [NSString stringWithFormat:@"%ld天前",[nowComponents day]-[dateComponents day]];
    }
    else{
        //显示月日
        return [timeStr substringWithRange:NSMakeRange(5, 5)];
    }

    return nil;
}

- (NSString *)detailSchoolCircleTimeByTimeStr:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:timeStr];
    NSDate * nowDate = [NSDate date];
    
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *dateComponents = [self.calendar components:unitFlags fromDate:date];
    NSDateComponents *nowComponents = [self.calendar components:unitFlags fromDate:nowDate];
    if ([dateComponents year]!=[nowComponents year]) {
        //显示月日
        return [timeStr substringWithRange:NSMakeRange(5, 11)];
    }
    else if ([dateComponents day]==[nowComponents day]&&[dateComponents month]==[nowComponents month]) {
        //今天
        NSTimeInterval dateInterval = [date timeIntervalSince1970]*1;
        NSTimeInterval nowInterval = [nowDate timeIntervalSince1970]*1;
        NSTimeInterval cha = nowInterval - dateInterval;
        NSString *timeString=@"";
        
        NSString* str;
        if (fmodf(cha, 1)==0) {
            
            str = [NSString stringWithFormat:@"%.0f",cha];
            
        } else if (fmodf(cha*10, 1)==0) {
            str = [NSString stringWithFormat:@"%.1f",cha];
        } else {
            str = [NSString stringWithFormat:@"%.2f",cha];
        }
        
        float chas = [str integerValue];
        //        NSLog(@"%f",chas/5*60);
        if (chas/(5*60)<=1.0f) {
            timeString = @"刚刚";
        }
        else if (chas/(5*60)>1.0f&&cha/3600<1.0f) {
            timeString = [NSString stringWithFormat:@"%f", chas/60];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        }
        else if (chas/3600>1.0f) {
            timeString = [NSString stringWithFormat:@"%f", chas/3600];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
        }else{
            timeString = [NSString stringWithFormat:@"%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
        }
        return timeString;
        //        return [NSString stringWithFormat:@"今天%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
    }else if ([nowComponents day]-[dateComponents day]==1&&[dateComponents month]==[nowComponents month]){
        //昨天
        return @"昨天";
    }else if ([nowComponents day]-[dateComponents day]>1&&[dateComponents month]==[nowComponents month]){
        //同一个月显示几天前
        return [NSString stringWithFormat:@"%d天前",[nowComponents day]-[dateComponents day]];
    }
    else{
        //显示月日
        return [timeStr substringWithRange:NSMakeRange(5, 5)];
    }
    
    return nil;

}


- (NSString *)messageTimeByTimeStr:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:timeStr];
    NSDate * nowDate = [NSDate date];

    
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *dateComponents = [self.calendar components:unitFlags fromDate:date];
    NSDateComponents *nowComponents = [self.calendar components:unitFlags fromDate:nowDate];
    if ([dateComponents year]!=[nowComponents year]) {
        //显示年月日
        return [timeStr substringToIndex:10];
    }
    else if ([dateComponents day]==[nowComponents day]) {
        //今天
        NSString *hourStr = [timeStr substringWithRange:NSMakeRange(11, 2)];
        NSInteger hourInteger = [hourStr integerValue];
        if (hourInteger<6) {
            return [NSString stringWithFormat:@"凌晨%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
        }
        else if(hourInteger<12){
            return [NSString stringWithFormat:@"早上%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
        }
        else if(hourInteger<14)
        {
            return [NSString stringWithFormat:@"中午%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];;
        }
        else if(hourInteger<18)
        {
            return  [NSString stringWithFormat:@"下午%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
        }
        else{
            return [NSString stringWithFormat:@"晚上%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
        }
    }else if ([nowComponents day]-[dateComponents day]==1){
        //昨天
        return [NSString stringWithFormat:@"昨天%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
    }else{
        //显示月日
        return [timeStr substringWithRange:NSMakeRange(5, 5)];
    }
    return nil;
}

- (NSString *)formatTimeStr:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date1 = [formatter dateFromString:timeStr];
    NSDate * date2 = [NSDate date];
    

    
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    

    NSDateComponents *startDay = [self.calendar components:unitFlags fromDate:date1];
    NSDateComponents *today = [self.calendar components:unitFlags fromDate:date2];
    
    NSInteger months = [today month]-[startDay month];
    NSInteger days = [today day]-[startDay day];
    if (months>0) {
        return [NSString stringWithFormat:@"%d个月以前",months];
    }
    if (days>=3*7) {
        return @"三周以前";
    }
    else if (days>=2*7) {
        return @"两周以前";
    }
    else if (days>=7) {
        return @"一周以前";
    }
    else if (days>0 && days<7) {
        return [NSString stringWithFormat:@"%d天以前",days];
    }
    else if (days<0 && days>-7) {
        [formatter setDateFormat:@"EEEE"];
        NSString *weekDay = [formatter stringFromDate:date1];
        NSLog(@"%@", [formatter stringFromDate:date1]);
        if (days==-1) {
            return @"明天";
        }
        else if (days==-2){
            return @"后天";
        }
        else{
            return weekDay;
        }
    }
    else if (days<=-7){
        days = -days;
        return [NSString stringWithFormat:@"%d天之后",days];
    }
    else if (days==0) {
        return @"今天";
    }
    else{
        return @"";
    }
}


- (NSDate *)dateByTimeString:(NSString *)timeStr
{
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    [str appendString:timeStr];
    if (timeStr.length==16) {
        [str appendString:@":00"];
    }
    else{
        
    }
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YY-MM-dd HH:mm"];
    NSDate *d=[dateformatter dateFromString:str];
    return d;
}

- (NSString *)timeStrByDate:(NSDate *)date{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateformatter stringFromDate:date];
}

- (NSString *)formatRefreshTime:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:timeStr];
    NSDate * nowDate = [NSDate date];

    
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *dateComponents = [self.calendar components:unitFlags fromDate:date];
    NSDateComponents *nowComponents = [self.calendar components:unitFlags fromDate:nowDate];
    if ([dateComponents year]!=[nowComponents year]) {
        //显示月日
        return [timeStr substringWithRange:NSMakeRange(5, 5)];
    }
    else if ([dateComponents day]==[nowComponents day]&&[dateComponents month]==[nowComponents month]) {
        //今天
        NSTimeInterval dateInterval = [date timeIntervalSince1970]*1;
        NSTimeInterval nowInterval = [nowDate timeIntervalSince1970]*1;
        NSTimeInterval cha = nowInterval - dateInterval;
        NSString *timeString=@"";
        
        NSString* str;
        if (fmodf(cha, 1)==0) {
            
            str = [NSString stringWithFormat:@"%.0f",cha];
            
        } else if (fmodf(cha*10, 1)==0) {
            str = [NSString stringWithFormat:@"%.1f",cha];
        } else {
            str = [NSString stringWithFormat:@"%.2f",cha];
        }
        //        if ([[[NSString stringWithFormat:@"%f", cha/60] substringToIndex:timeString.length-7] integerValue]<=5) {
        //            return @"刚刚";
        //        }
        
        
        float chas = [str integerValue];
        //        NSLog(@"%f",chas/5*60);
        if (chas/(60)<=1.0f) {
            timeString = @"刚刚";
        }
        else if (chas/(60)>1.0f&&cha/3600<1.0f) {
            timeString = [NSString stringWithFormat:@"%f", chas/60];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        }
        else if (chas/3600>1.0f&&chas/7200<1.0f) {
            timeString = [NSString stringWithFormat:@"%f", chas/3600];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
        }else{
            timeString = [NSString stringWithFormat:@"今天%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
        }
        return timeString;
        //        return [NSString stringWithFormat:@"今天%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
    }else if ([nowComponents day]-[dateComponents day]==1&&[dateComponents month]==[nowComponents month]){
        //昨天
        return [NSString stringWithFormat:@"昨天%@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
    }else{
        //显示月日
        return [timeStr substringWithRange:NSMakeRange(5, 5)];
    }
    
    return nil;
}

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc]init];
    }
    return _formatter;
}
- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        _calendar.timeZone = [NSTimeZone localTimeZone];
        //        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}
@end
