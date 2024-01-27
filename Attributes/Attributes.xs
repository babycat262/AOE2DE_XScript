/// 单位属性常量 ///
extern const int uHP = 0;    //生命值
extern const int uSight = 1;    //视野
extern const int uGarrCap = 2;    //驻扎单位容量
extern const int uSizeX = 3;    //碰撞体积X，单位碰撞体积框的长度
extern const int uSizeY = 4;    //碰撞体积Y，单位碰撞体积框的宽度
extern const int uMovSpeed = 5;    //移动速度
extern const int uRotSpeed = 6;    //旋转速度
extern const int uArmor = 8;    //护甲
extern const int uAttack = 9;    //攻击
extern const int uAttInterval = 10;    //攻击间隔（重载延迟）
extern const int uAccPercent = 11;    //命中率
extern const int uMaxRange = 12;    //最大攻击范围
extern const int uWorkRate = 13;    //工作效率
extern const int uCarryCap = 14;    //资源最大携带量
extern const int uBaseArmor = 15;    //基础护甲
extern const int uProjUnit = 16;    // 单位主抛射物的ID
extern const int uBuildIcon = 17;    // 建筑单位的图标
extern const int uTerrDefBonus = 18;    //地形防御奖励
extern const int uProjMode = 19;    //抛掷物智能模式  {0:"无弹道学", 1:"弹道学追踪模式", 2:"偏射全伤", 3:"弹道学模式+偏射全伤"}
extern const int uMinRange = 20;    //最小攻击范围
extern const int u1stRes = 21;    //第一资源存储
extern const int uBlastWidth = 22;    //践踏半径
extern const int uSearchR = 23;    //查找半径
extern const int uResistBonus = 24;    //附加伤害减免系数
extern const int uIconID = 25;    //（非建筑）单位图标ID
extern const int u2ndRes = 26;    //第二资源存储
extern const int u3rdRes = 27;    //第三资源存储
extern const int uFogVis = 28;    //战争迷雾可见性  {0:"迷雾中不可见", 1:"在迷雾中始终可见", 2:"迷雾中可见，死亡不立即消失", 3:"完全不可见（无任何图像，能被攻击，但单位不被控制）", 4:"参考战雾留影"}
extern const int uOccMode = 29;    //单位轮廓遮挡模式
extern const int uGarrType = 30;    //可驻扎的单位类型 {0:"不能驻扎单位", 1:"村民/国王/皇后", 2:"步兵单位（火焰骆驼除外）", 4:"骑兵/斥候/火焰骆驼", 8:"僧侣", 16:"牲畜", 32:"攻城武器（目前无效）", 64:"渔船"}
//extern const int u = 31;    //
extern const int uSizeZ = 32;    //碰撞体积Z，单位碰撞体积框的高度
extern const int uClearMode = 33;    //清扫模式
extern const int uBuildGenTerrain = 34;    //建筑建成地形（建筑下面留下的）

extern const int uHeroStatus = 40;    //英雄状态  {0:"非英雄状态", 1:"完全体英雄状态", 2:"免疫招降", 4:"可缓慢自愈（30HP/min）", 8:"默认防御状态", 16:"在阵型中受保护", 32:"安全删除（del需要确认）", 64:"英雄光环效果", 128:"反转除1外的其他标志位"}
extern const int uFrameDelay = 41;    //帧延迟
extern const int uTrainLocation = 42;    //训练场所
extern const int uTrainButton = 43;    //训练按钮
extern const int uBlastAttLev = 44;    //溅射攻击等级  {0:"可伤害任何单位（包括树木，资源，悬崖，山脉，鸟类，地形物）", 1:"可伤害树木、附近单位", 2:"可伤害附近单位", 3:"只伤害目标单位（效果同2）", 4:"可伤害附近单位，但不会对友军造成误伤", 64:"溅射伤害随着与攻击中心距离的增加而减弱 (仅限近战兵种)", 128:"攻击时可对目标正后方 X 格内单位产生溅射伤害 (X 为溅射半径)" }
extern const int uBlastDefLev = 45;    //溅射防御等级  {0:"可伤害任何单位（包括树木，资源，悬崖，山脉，鸟类，地形物）", 1:"可伤害树木、附近单位", 2:"可伤害附近单位", 3:"只伤害目标单位（效果同2）"}
extern const int uShowAttack = 46;    //显示攻击力数值
extern const int uShowRange = 47;    //显示最大攻击范围
extern const int uShowArmor04 = 48;    //显示近战护甲值
extern const int uShowArmor03 = 49;    //显示远程护甲值
extern const int uObjNameID = 50;    //物体名称ID（字符串表）
extern const int uObjDescID = 51;    //物体简短描述的ID（字符串表）
//extern const int u = 52;    //
extern const int uTerrainID = 53;    //地形限制ID（单位可通行的地形ID）
extern const int uTrait = 54;    //单位特技  {0:"无特征属性或技能（默认）", 1:"允许单位进驻", 2:"舰船属性", 4:"建造特定建筑（需要绑定特技单位）", 8:"变身为另一单位", 16:"自动侦察（起始斥候功能）"}
//extern const int u = 55;    //
extern const int uTraitPiece = 56;    //特技配套对应单位（54号属性设置为8时转换到的目标物体）
extern const int uDeathUnit = 57;    //死亡单位ID
extern const int uHotKey = 58;    //训练单位热键ID
extern const int uMaxCharge = 59;    //最大蓄力值
extern const int uChargeRate = 60;    //蓄力回复率（点/秒）
extern const int uChargeEvent = 61;    //蓄力事件  {0:"无蓄力", 1:"有蓄力"}
extern const int uChargeType = 62;    //蓄力类型  {0:"无蓄力攻击，不能闪避抛射物", 1:"蓄力攻击", 3:"蓄力范围攻击", 4:"闪避抛射物"}
extern const int uCombat = 63;    //作战能力，可组合的位字段。  {0:"无战斗能力（默认）", 1:"破防（攻击敌人无视护甲）", 2:"免疫破防（免疫敌人无视护甲的攻击）", 4:"破甲（每次攻击敌方护甲-1）", 8:"强制对地攻击", 16:"主副抛射物齐射", 32:"光环加成启动器"}
extern const int uAttDisper = 64;    //未命中偏离因子
extern const int uSecProjUnit = 65;    //第二（次要）抛射物单位
extern const int uBloodUnit = 66;    //血迹单位
/* 抛射物命中模式： 
    {0: 抛射物遇障会无视障碍命中目标后死亡，但不会对除目标外其他单位造成伤害, 
     1: 抛射物遇障会被障碍物阻挡然后死亡,障碍物承担伤害, 在穿透模式下(属性ID 68 值为1),抛射物会对攻击路径上除目标外的其他被穿透单位造成命中主要目标的  50% 伤害,无法穿透建筑
     2: 抛射物遇障会被障碍物阻挡然后死亡,障碍物承担伤害。在穿透模式下(属性ID 68 值为1),抛射物会对攻击路径上除目标外的其他被穿透单位造成命中主要目标的 100% 伤害,可以穿透建筑
     3: 抛射物遇障会无视障碍命中目标后不会死亡,但不会对任何单位造成伤害 }
*/
extern const int uProjHitMode = 67;
extern const int uProjPassMode = 68;    //抛掷物越障模式： {0: 击中目标后抛射物立即消失, 1: 击中目标后抛射物不会立即消失,而是穿透目标单位继续向前飞行(弩炮穿透效果)
extern const int uProjArc = 69;    //抛射物角度，控制抛射物发射时的最大高度
extern const int uAttackImage = 70;    //单位进行攻击时的图像。详情参考 AGE
extern const int uStandImage1 = 71;    //站立图像1 绝大多数单位都拥有该图像
extern const int uStandImage2 = 72;    //站立图像2 某些单位除了拥有站立图像1，还拥有站立图像2.各有50%几率显示这些图像
extern const int uDeathImage = 73;    //单位死亡图像
extern const int uGhostImage = 74;    //亡灵图像（无效）
extern const int uMoveImage1 = 75;    //移动奔跑时的图像1
extern const int uMoveImage2 = 76;    //移动奔跑时的图像2
extern const int uSpecialImage = 77;    //特殊图像（无效）

extern const int uResCost = 100;    //单位的资源花费（设置该属性时，原成本属性都做对应的修改）
extern const int uTrainTime = 101;    // 单位训练时间|建筑建造时间（单人建造所需时间）
extern const int uTotalMiss = 102;    //抛掷物初始总数N（通常为 1+M, M为附加抛掷物数量）
extern const int uFoodCost = 103;    //单位花费的食物成本
extern const int uWoodCost = 104;    //单位花费的木头成本
extern const int uGoldCost = 105;    //单位花费的黄金成本
extern const int uStoneCost = 106;    //单位花费的石头成本
extern const int uMaxTotalMiss = 107;    //抛掷物最大总数（单位的主要+附加抛掷物总数量，不会超过该数值）
extern const int uGarrCureRate = 108;    //驻扎治疗速率（点/秒）单位驻扎于建筑中每秒自动回复的生命值
extern const int uCureRate = 109;    //单位自愈速率（点/分钟），该属性可与"英雄模式[40]"的4状态叠加效果
extern const int uPopulation = 110;    //修改单位的人口空间系数。人口空间系数会直接影响玩家的人口余量(资源ID 4)以及人口占用(资源ID 11)。当单位的人口空间系数为0时,其人口占用和人口余量尽数为0
                                // {-1："绝大部分单位（默认）", -0.9:"村民、僧侣类单位（需研究大乘佛教）", 0:"单位不占用人口"}
extern const int uMinTransTime = 111;    //单位最小转化时间修改器（秒）  {0:"绝大部分单位（默认）", 1:"孟加拉象类单位", 4:"斥候骑兵，鹰勇士"}
extern const int uMaxTransTime = 112;    //单位最大转化时间修改器（秒）  {0:"绝大部分单位（默认）", 2:"孟加拉象类单位"}
extern const int uTransResist = 113;    //单位转化抗性  {0:"大部分单位", 2:"孟加拉象类单位", 3:"建筑类单位、舰船单位"}
extern const int uFormationType = 114;    //编队类型，表示单位在行伍队列中的前后顺序,取值范围 {0,1,2,3,4,5,255}
extern const int uBlastRate = 115;    //区域溅射伤害。负数代表固定溅射攻击，－X 表示单位攻击敌人造成X点固定溅射伤害；正数代表溅射伤害比例；X 表示单位攻击敌人造成100X% 比例的溅射伤害 0.25表示造成25%比例的伤害 
