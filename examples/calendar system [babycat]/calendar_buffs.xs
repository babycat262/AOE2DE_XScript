
// 季节增益效果
void season_buffs(int flag1=-1, int flag2=-1, int flag3=-1, int flag4=-1, int p=0) 
{
/*
  参数说明：
  flag1: 该标志为1代表春季，为-1代表非春季
  flag2: 该标志为1代表夏季，为-1代表非夏季
  flag3: 该标志为1代表秋季，为-1代表非秋季
  flag4: 该标志为1代表冬季，为-1代表非冬季
      这些标志位是互斥事件，只能有一个是1，其余均为 -1
  
*/
    // 设置四个季节对应的效果
    // . . . 
    static int spring_flag = -1;  //春季标志位
    static int summer_flag = -1;  //夏季标志位
    static int autumn_flag = -1;  //秋季标志位
    static int winter_flag = -1;  //冬季标志位
    
    if(spring_flag != flag1) {// 春季：芒种季节，耕种成本减少
        spring_flag = flag1;
        //农田建造成本 -10%
        xsEffectAmount(4, 50, 104, -6.0*spring_flag, -1);
    }
    
    if(summer_flag != flag2) {// 夏季：万物生长（木材产量增加）
        summer_flag = flag2;
        //大自然 树木A[399]--L[410] 木材量增加20%
        for(tree=399; <=410) {xsEffectAmount(4, tree, 21, (0.2*125)*summer_flag, 9);}
        //沿海鱼鲜食物产量+30
        xsEffectAmount(4, 69, 21, 30*summer_flag, 9);
    }
    
    if(autumn_flag != flag3) {// 秋季：水果丰收
        autumn_flag = flag3;
        if(autumn_flag==1) {//浆果丛循环再生
            xsEffectAmount(0, 59, 57, 1059, 9);  //浆果丛59 -> 浆果丛1059
            xsEffectAmount(0, 1059, 57, 59, 9);  //浆果丛1059 -> 浆果丛59
        }
        else if(autumn_flag==-1) {//取消浆果丛循环再生
            xsEffectAmount(0, 59, 57, -1, 9);
            xsEffectAmount(0, 1059, 57, -1, 9);
        }
    }
    
    if(winter_flag != flag4) {// 冬季：积雪天气，影响士兵行驶速度
        winter_flag = flag4;
        //所有步兵移动速度 -0.08
        xsEffectAmount(4, 906, 5, -0.08*winter_flag, -1);
        //所有骑兵移动速度 -0.08
        xsEffectAmount(4, 912, 5, -0.12*winter_flag, -1);
    }
}

//概率事件函数，根据prob概率返回逻辑值 true/false。实现细节请参阅 Statistics.xs 模块
bool Probability(float prob=0.5) {return (false);}
void solar_buffs(float comb_date=0.0, int solar=1) 
{// 节气效果
    if(comb_date == 7.15) {
        //7月15中元节，有50%概率出现“百鬼夜行”现象
        bool spirit = Probability(0.5);  //概率 0.5
        if(spirit) {
            int spirit_id = 1135;    //幽灵单位ID：科莫多巨蜥
            int building_id = 1089;    //生成建筑ID：谷仓
            int building_amt = 999999999;    //建筑数量上限
            int gen_times = 1;    //生成次数
            //在特定建筑周围生成幽灵单位
            xsEffectAmount(1, 234, 0, building_amt, 9);
            xsEffectAmount(7, spirit_id, building_id, gen_times, 9);
        }
    }
    //凶残的狼群
    static int wolf_hunger = 0;
    int hunger = 0;
    if(comb_date>=11.07 || comb_date<=1.20) {
        //冬季缺少食物，狼群饥饿凶残，攻击力+5
        hunger = 1;
        if(wolf_hunger != hunger) {
            wolf_hunger = hunger;
            xsEffectAmount(4, 126, 9, 5*wolf_hunger, -1);
        }
    }
    else {//狼群饥饿解除，攻击力-5
        hunger = -1;
        if(wolf_hunger != hunger) {
            wolf_hunger = hunger;
            xsEffectAmount(4, 126, 9, 5*wolf_hunger, -1);
        }
    }
    
    // 更多效果 ...
    
}

