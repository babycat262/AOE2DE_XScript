/// 修道院源玩家圣物驻扎，为目标玩家提供单位的一些属性加成 机制///


/*
  该案例，通过源玩家（P2）的圣物捕获数量，给目标玩家（P1）的单位 894，1275 提供相应的增益
  详情：玩家2每 驻扎/丢失1个圣物，玩家1单位的增益情况： 
    894单位生命值 +3/-3，移动速度 +0.02/-0.02 ；
    1275单位远程攻击 +1/-1，近战防御 +1/-1
*/
const int src_p = 2;    //驻扎圣物的源玩家
const int dist_p = 1;    //圣物增益的目标玩家
const int reInterval = 1;    //rule运行间隔重置
const int TV_relic = 7;    // 记录捕获圣物数的触发器变量
rule RelicsBuff
    inactive
    group Buffs
    minInterval 0
    priority 100
{
    static int runs = 0;    //rule运行次数
    static int relic_pre = 0;    // 之前时刻圣物获取数（圣物增益倍率） [1圣物 = 1倍]
    static int relic_wave = 0;    // 当前时刻圣物变化数量
    //初始化Rule执行间隔为reInterval
    if(runs==0) {xsSetRuleMinIntervalSelf(reInterval);}
    // 获取源玩家圣物数
    int relic_cur = xsPlayerAttribute(src_p, 7);
    if((relic_cur > 0) && (relic_cur == relic_pre)) {}
    else if(relic_cur == 0) 
    {// 当前拥有圣物数量减为0，清空增益
        xsEffectAmount(4, 894, 0, -3.00*relic_pre, dist_p);
        xsEffectAmount(4, 894, 5, -0.02*relic_pre, dist_p);
        //攻击力|护甲 +- 1/圣物
        //xsEffectAmount(mod, unit, uAttack, T*256+N, p);
        xsEffectAmount(4, 1275, 9, 3*256-relic_pre, dist_p);
        xsEffectAmount(4, 1275, 8, 4*256-relic_pre, dist_p);
        // 同步圣物捕获数至触发器变量
        relic_pre = relic_cur;
        xsSetTriggerVariable(TV_relic, relic_pre);
        //xsDisableSelf();
    }
    else 
    {
        relic_wave = relic_cur - relic_pre;
        // 设置单位属性（非攻防）
        xsEffectAmount(4, 894, 0, 3*relic_wave, dist_p);
        xsEffectAmount(4, 894, 5, 0.02*relic_wave, dist_p);
        // 攻防 标志位WS：relic_wave>0时WS=1，relic_wave<0时WS=-1 
        int WS = relic_wave/abs(relic_wave);
        xsEffectAmount(4, 1275, 9, WS*3*256+relic_wave, dist_p);
        xsEffectAmount(4, 1275, 8, WS*4*256+relic_wave, dist_p);
        // 同步圣物获取数至 TriggerVariable
        relic_pre = relic_cur;
        xsSetTriggerVariable(TV_relic, relic_pre);
        //xsChatData("<GREY>Current Relics: "+ relic_cur);
    }
    runs++;
}

// 触发A: 源玩家 圣物数大于0 时调用该函数，同时激活触发B
void openRelicsBuff(){xsEnableRule("RelicsBuff");}
// 触发B: 源玩家 圣物数小于0 时调用该函数，同时激活触发A
void  offRelicsBuff(){xsDisableRule("RelicsBuff");}

