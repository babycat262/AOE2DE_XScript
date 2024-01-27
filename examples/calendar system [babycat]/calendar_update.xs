include "calendar_buffs.xs";

//记录日期的触发器变量ID
const int TV_year = 11;
const int TV_month = 12;
const int TV_day = 13;
const int TV_yday = 14;
const int TV_solar = 15;
const int TV_season = 16;
// 日历参数
int CA01 = 00; int CA02 = -1; int CA03 = -1; int CA04 = -1; 
int CA05 = -1; int CA06 = -1; int CA07 = -1; int CA08 = -1; 
int CA09 = -1; int CA10 = -1; int CA11 = -1; int CA12 = -1; 

void solar_transform(float comb_date=1.01) 
{
    // 根据 月份，天数 确定季节和节气
    static int season = 0;    // 季节（全局）
    static int solar = 1;    //节气
    int season_cur = season;    //当前季节
    // 24节气
         if(comb_date == 2.04) {solar = 1; season_cur = 1;}    // 立春 [2.03, 2.05]
    else if(comb_date == 2.19) {solar = 2;}    // 雨水 [2.19, 2.20]
    else if(comb_date == 3.05) {solar = 3;}    // 惊蛰 [3.05, 3.06]
    else if(comb_date == 3.21) {solar = 4;}    // 春分 [3.19, 3.22]
    else if(comb_date == 4.05) {solar = 5;}    // 清明 [4.04, 4.05]
    else if(comb_date == 4.20) {solar = 6;}    // 谷雨 [4.19, 4.21]
    else if(comb_date == 5.06) {solar = 7; season_cur = 2;}    // 立夏 [5.05, 5.07]
    else if(comb_date == 5.20) {solar = 8;}    // 小满 [5.20, 5.22]
    else if(comb_date == 6.06) {solar = 9;}    // 芒种 [6.05, 6.07]
    else if(comb_date == 6.22) {solar =10;}    // 夏至 [6.21, 6.22]
    else if(comb_date == 7.07) {solar =11;}    // 小暑 [7.06, 7.08]
    else if(comb_date == 7.23) {solar =12;}    // 大暑 [7.22, 7.24]
    else if(comb_date == 8.08) {solar =13; season_cur = 3;}    // 立秋 [8.07, 8.08]
    else if(comb_date == 8.23) {solar =14;}    // 处暑 [8.22, 8.24]
    else if(comb_date == 9.08) {solar =15;}    // 白露 [9.07, 9.09]
    else if(comb_date == 9.23) {solar =16;}    // 秋分 [9.22, 9.24]
    else if(comb_date ==10.08) {solar =17;}    // 寒露 [10.07, 10.09]
    else if(comb_date ==10.24) {solar =18;}    // 霜降 [10.22, 10.24]
    else if(comb_date ==11.07) {solar =19; season_cur = 4;}    // 立冬 [11.07, 11.08]
    else if(comb_date ==11.22) {solar =20;}    // 小雪 [11.22, 11.23]
    else if(comb_date ==12.07) {solar =21;}    // 大雪 [12.07, 12.08]
    else if(comb_date ==12.22) {solar =22;}    // 冬至 [12.21, 12.23]
    else if(comb_date == 1.06) {solar =23;}    // 小寒 [1.05, 1.07]
    else if(comb_date == 1.20) {solar =24;}    // 大寒 [1.20, 1.21]
    else {}
    //同步season和solar到触发器变量
    if(season != season_cur) {season = season_cur; xsSetTriggerVariable(TV_season, season);}
    xsSetTriggerVariable(TV_solar, solar);
    //设置季节和节气效果
         if(solar>=01 && solar<=06) {season_buffs(1,-1,-1,-1);}
    else if(solar>=07 && solar<=12) {season_buffs(-1,1,-1,-1);}
    else if(solar>=13 && solar<=18) {season_buffs(-1,-1,1,-1);}
    else if(solar>=19 && solar<=24) {season_buffs(-1,-1,-1,1);}
    solar_buffs(comb_date, solar);
}

// 根据year值确定闰年标识
int isLeap(int year=1000) {if((year%400 == 0)||(year%4 == 0)&&(year%100 != 0)) {return(1);} return(0);}
void calendar_system()
{//日历系统
    static int runs = 0;    // 函数（rule）运行次数
    // 日历初始值信息
    static int year =908;  // 年份 初始值
    static int month= 02;  // 月份 初始值
    static int day  = 04;  // 月内天数 初始值
    static int yday = 35;  // 一年内第Y天

    static int leap = 0;    // 闰年标识符
    if(isLeap(year)==1 && runs==0) {leap = 1;}    //初始year年份的leap标识
    // 更新日期
    day++;  yday++;
    if(   yday==CA02      || yday==CA03+leap || yday==CA04+leap 
       || yday==CA05+leap || yday==CA06+leap || yday==CA07+leap 
       || yday==CA08+leap || yday==CA09+leap || yday==CA10+leap 
       || yday==CA11+leap || yday==CA12+leap ) 
    {month++;  day = 1;}
    else if(yday > 365+leap)
    {
        year++;
        month=1;
        day=1;
        yday=1;
        leap = isLeap(year);  //判断新一年是否闰年
    }
    else {}
    // 同步触发器变量
    xsSetTriggerVariable(TV_year, year);
    xsSetTriggerVariable(TV_month, month);
    xsSetTriggerVariable(TV_day, day);
    xsSetTriggerVariable(TV_yday, yday);
    solar_transform(1.0*month+0.01*day);    //将month.day组合值传入季节系统
    runs++;
}

void LoadCA() 
{
    xsOpenFile("../resources/_common/xsdat/&args");
    xsSetFilePosition(0);
    // Read data and save intp params.
    CA02 = xsReadInt();
    CA03 = xsReadInt();
    CA04 = xsReadInt();
    CA05 = xsReadInt();
    CA06 = xsReadInt();
    CA07 = xsReadInt();
    CA08 = xsReadInt();
    CA09 = xsReadInt();
    CA10 = xsReadInt();
    CA11 = xsReadInt();
    CA12 = xsReadInt();
    xsCloseFile();
}
// LoadCA();


/*
    日历系统使用方式：
    在你的场景中新建以下触发器：
    触发器0：（开启）
        效果：在场景中修改触发器变量名称
            变量11： TV_year
            变量12： TV_month
            变量13： TV_day
            变量14： TV_yday
            变量15： TV_solar
            变量16： TV_season
    
    触发器1：（开启）
        修改该触发的UI面板显示信息，如下：
        日期：<TV_year>年<TV_month>月<TV_day>日
        季节：<TV_season> | 节气：<TV_solar>
    
    触发器2：（开启）
        触发循环开启，循环间隔自定义，代表”1天“的间隔。
        效果：
          脚本调用： calendar_system();
    
    以上设置之后，日历系统就能够正常工作了！
        在日期更新期间，季节系统 season_buffs 和 solar_buffs 也随之联动产生效果，详情参见模块 calendar_buffs.xs
    你也可以自定义更多功能，增加游戏乐趣。
    
    如有任何问题，请反馈给我，您的改进意见至关重要。
*/
