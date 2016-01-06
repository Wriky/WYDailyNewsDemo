//
//  YYToolKit.m
//  YYDailyNewsDemo
//
//  Created by REiFON-MAC on 15/12/28.
//  Copyright © 2015年 L. All rights reserved.
//

NSString * const YYRequestGET = @"GET";
NSString * const YYRequestPOST = @"POST";

//Web图片加载
extern UIImage *ImageWithURL(NSString *imageURL){
    
    return [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    
}

#pragma mark resource Control
//bundle图片加载
extern UIImage* Image(NSString* imageName)
{
    NSString *bundleStr = @"Resource.bundle/";
    NSString *imgPath   = [bundleStr stringByAppendingString:imageName];
    return [UIImage imageNamed:imgPath];
}



//bundle文件加载
extern NSString* FilePath(NSString* fileName)
{
    NSString *bundleStr = @"resource.bundle/";
    NSString *filePath  = [bundleStr stringByAppendingString:fileName];
    return ResourcePath(filePath);
}

//获取资源全路径
NSString* ResourcePath(NSString* fileName)
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", fileName];
}

NSString *transformDateStr(NSString *dateStr){
    NSString *transformStr = nil;
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate* inputDate = [inputFormatter dateFromString:dateStr];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *dateString = [outputFormatter stringFromDate:inputDate];
    

    NSString *weekdayStr = weekdayStringFromDate(inputDate);
    transformStr = [NSString stringWithFormat:@"%@  %@",dateString,weekdayStr];
    return transformStr;
}

NSString *getPreviousDate(NSString *currentDateStr){
    
    
    NSString *transformStr = nil;
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate* inputDate = [inputFormatter dateFromString:currentDateStr];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];

    
    NSDate *lastDay = [NSDate dateWithTimeInterval:+24*60*60 sinceDate:inputDate];
    
    NSString *lastDayString = [outputFormatter stringFromDate:lastDay];
    NSString *weekdayStr = weekdayStringFromDate(lastDay);
    transformStr = [NSString stringWithFormat:@"%@  %@",lastDayString,weekdayStr];
    
    return transformStr;
}

NSString *weekdayStringFromDate(NSDate *inputDate){
    NSArray *weekdays = @[@"星期日",@"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday-1];
}


float CurrentDevce()
{
    return ((kScreenWidth == 320.f && kScreenHeight< 500.f)?3.5:(kScreenWidth == 320.f && kScreenHeight> 500.f)?4:(kScreenWidth == 375)?4.7:5.5);
}

float AdjustF(float X)
{
    float DevceNum = CurrentDevce();
    if (DevceNum == 4.0f || DevceNum == 3.5f)
    {
        return X;
    }
    else{
        return X*(kScreenWidth/320.f);
    }
    
}

CGRect AdjustRect(float X,float Y,float W,float H)
{
    float DevceNum = CurrentDevce();
    if (DevceNum == 4.0f || DevceNum == 3.5f)
    {
        return CGRectMake(X, Y, W, H);
    }else
    {
        return CGRectMake(X*(kScreenWidth/320.f), Y*(kScreenWidth/320.f), W*(kScreenWidth/320.f), H*(kScreenWidth/320.f));
    }
}


void setExtraCellLineHidden(UITableView *tableView)
{
    UIView *view =[ [UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

UIColor *RGBColor(float R,float G,float B,float A)
{
    return [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A];
}

float sizeForDevices(float f1,float f2, float f3, float f4){
    
    float DevceNum = CurrentDevce();
    
    if (DevceNum == 3.5f){
        return f1;
    }
    else if (DevceNum == 4.0f){
        return f2;
    }
    else if (DevceNum == 4.7f){
        return f3;
    }
    else{
        return f4;
    }
}

UIFont * FontOfSize(CGFloat fontSize)
{
    return [UIFont systemFontOfSize:fontSize];
}

UIFont * BoldFontOfSize(CGFloat fontSize)
{
    return [UIFont boldSystemFontOfSize:fontSize];
}

UIFont * FontOfSizeForDevices(CGFloat font1,CGFloat font2,CGFloat font3,CGFloat font4){
    
    float DevceNum = CurrentDevce();
    
    if (DevceNum == 3.5f)
    {
        return FontOfSize(font1);
    }
    else if (DevceNum == 4.0f)
    {
        return FontOfSize(font2);
    }
    else if (DevceNum == 4.7f)
    {
        return FontOfSize(font3);
    }
    else
    {
        return FontOfSize(font4);
    }
    
}

UIFont * BoldFontOfSizeForDevices(CGFloat font1,CGFloat font2,CGFloat font3,CGFloat font4){
    
    float DevceNum = CurrentDevce();
    
    if (DevceNum == 3.5f)
    {
        return BoldFontOfSize(font1);
    }
    else if (DevceNum == 4.0f)
    {
        return BoldFontOfSize(font2);
    }
    else if (DevceNum == 4.7f)
    {
        return BoldFontOfSize(font3);
    }
    else
    {
        return BoldFontOfSize(font4);
    }
    
}

#pragma mark Font Size
//文字尺寸
float GetTextHight(UIFont *font, NSString* text, CGFloat width)
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize sz = [text boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return sz.height;
}

float GetTextWidth(UIFont *font, NSString* text)
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize sz = [text boundingRectWithSize:CGSizeMake(0, font.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return sz.width;
}
