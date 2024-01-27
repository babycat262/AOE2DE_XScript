/*
    Rule（规则）：
    rule是一种特殊的函数，它具有周期循环运行的特点。运行周期由参数 minIInterval/maxInterval 决定。

    Rule定义形式如下：

    rule <规则名称>    // 规则名称
    active(inactive)    // 规则初始状态：{active: 激活, inactive: 未激活}
    group <规则组名称>    // 规则组名称
    minInterval <int>    // 规则最小初始执行周期（常数），单位：秒
    maxInterval <int>    // 规则最大初始执行周期（常数），单位：秒
    runImmediately    // 则规则激活后立即运行一次，然后周期运行。【BUG】：经测试该参数无效，具体解决方案见后文
    highFrequency    // 高频参数，在1.7倍速度下，规则每秒循环约60次；
                     // 【注意】：在规则中，highFrequency 或 minInterval(maxInterval) 参数不能同时使用，只能使用其一。
    priority <int>    // 规则运行的优先级，取值范围在[0, 100] 之间。
                      // priority 参数的一些特点：
                      // 1.在0~100之间时，数字越大优先级越高，执行顺序越靠前；
                      // 2.若定义时 priproty>100，则优先级与 priprity 100 相同；若定义时 priority<0，其优先级与 priority 0 相同；
                      // 3.具有相同优先级的不同Rule之间，按照Rule在XS脚本中定义的先后顺序（通过xsGetFuncID("函数名称")查看函数定义顺序），决定其执行顺序
    不同 priprity 数值代表的优先级顺序简图如下：
                           priority优先级
        低  -----0------------50--------------100----->    高
             最低优先级[0]                  最高优先级[0]     |
                   (&fid=08) rule01<50>                    |
                              |                            |  rule定义顺序（函数ID）
                              |                            |
                              |                            |
                   (&fid=12) rule02<50>                    低

    {
        //规则体代码
        
    }

Rule相关函数：
   //网站文档参考 https://www.pandaai.top/zh/xs/functions/ 一下仅对部分Rule相关的常用函数进行说明！
    void xsEnableRule(string ruleName);    //在规则外部启用规则
    void xsDisableRule(string ruleName);    //在规则外部禁用规则
    void xsEnableSelf();    //在规则内部启用规则自身
    void xsDisableSelf();    //在规则内部禁用规则自身
    void xsEnableRuleGroup(string ruleGroupName);    //启用规则组。会启用该组下的所有规则
    void xsDisableRuleGroup(string ruleGroupName);    //禁用规则组。会禁用该组下的所有规则
    void xsSetRuleMinInterval(string ruleName, int interval);    //在Rule外部设置规则最小执行间隔，规则下一次执行将按照新的间隔
    void xsSetRuleMinIntervalSelf(int interval);    //在Rule内部设置规则最小执行间隔，规则下一次执行将按照新的间隔
    void xsSetRuleMaxInterval(string ruleName, int interval);    //在Rule外部设置规则最大执行间隔，规则下一次执行将按照新的间隔
    void xsSetRuleMaxIntervalSelf(int interval);    //在Rule内部设置规则最大执行间隔，规则下一次执行将按照新的间隔
    int  FunctionID(string funcName);    //根据 函数/规则 名称，获取其在脚本中的定义顺序ID（可判断priorit参数相同的规则的执行顺序）
    
    特殊情况： main 规则
    在XS中，main函数最为脚本的入口函数，会在游戏游戏开始后自动执行一次，且最先被执行。
    若我们将 main 函数改为 main 规则，会产生什么变化呢？
    
    rule main
        inactive
        minInterval 30
        priority 100
    {//该规则激活后，每隔30秒自动打印一次欢迎信息
        xsChatData("<GREEN>Welcome to AOE2, have fun playing!");
    }
    
    在场景中加载以上规则脚本后，我们可以发现：
      1. 即使 main规则初始时inactive状态，也会立即执行一次。
      2. 随后main规则处于睡眠状态，可以通过 xsEnableRule("main") 激活该规则，使其按照指定的周期运行
      3. main规则与main()函数的效果类似，在游戏开始时都会自动执行一次。 在XS脚本中，main()函数与main规则只能存在其中一个，不能同时出现！
     *4. 对于同一个函数名，其在XS脚本中可以多次出现，通过 mutable 关键字修饰。详情请参阅 函数篇（Functions.xs） 
*/

// Rule案例： 游戏开始后，每隔10秒打印一次当前游戏时间，以 "min : sec" 的形式显示
const int T_min = 0    //Rule初始执行周期
const int T_min2 = 10;    //重置Rule周期

rule show_time
    active
    group Times
    minInterval T_min
    //maxInterval T_min
    //runImmediately  立即执行一次规则，该参数无效。
    priority 50
{
    static int runs = 0;  // Rule运行次数
    //规则激活后，重置运行周期为 T_min2(大于0)；若规则初始执行周期为0，则立即运行一次后，以周期 T_min2 循环执行，以此解决 runImmediately 参数无效的问题
    if(runs==0) {xsSetRuleMinIntervalSelf(T_min2);}
    static int minute = 0;
    static int second = 0;
    int t = xsGetGameTime();  //获取当前游戏时间秒数
    minute = t / 60;
    second = t % 60;
    
    xsChatData("Current GameTime: ");
    xsChatData("<YELLOW>"+minute+" : "+second+" ");
    
    runs++;    //执行规则体代码后，运行次数 runs+1
    if(t >= 600) {xsDisableSelf();}  //当 游戏时间 >= 600s ，关闭规则自身
}

