<<<<<<< HEAD
include "./number_tools.xs";

const float epsilon = 0.000001;
const float PI = 3.1416;
const float E_ = 2.7183;
const int Inf = -32768;
const string NULL = "";

// 数组管理列表 array_list ：ID编号为0的数组。该列表用于管理场景中创建的数组ID和数组名称
int array_list = 0;    // ID:0

rule array_register
    active
    group ArrRegister
    runImmediately
    priority 100
{// 此规则用于创建 array_list 列表
    array_list = xsArrayCreateString(1, "ArrayNames", "array_list");
    xsEnableRule("predef_arrays");
    xsDisableSelf();
}

int xsCreateArray(string dtype="float", string arr_name="", int arr_size=1) 
{// 创建数组，将数组名称加入管理列表
    if(arr_size <= 0) {xsChatData("Array.size must greater than 0."); return (Inf);}
=======
const float mEPS = 0.000001;    //浮点数的最小精度
const float mPI = 3.1416;    //圆周率
const float mE = 2.7183;    // 自然底数 E
const float mRAD = 180.0/mPI ;    // 弧度(约等于57.3°)
const int RAND_MAX = 32767;    // 随机函数产生的最大整数
const int INT_MAX = 999999999;    //int类型的最大值


// 数组管理列表 array_list ：ID编号为0的数组。该列表用于管理场景中创建的数组ID和数组名称
extern int array_list = 0;
mutable 
int xsCreateArray(string dtype="float", string arr_name="", int arr_size=1) 
{// 创建数组，将数组名称加入管理列表
    if(arr_size <= 0) {xsChatData("Array.size must greater than 0."); return (-32768);}
>>>>>>> b797119 (Release 2.0)
    int arr_id = -1;
         if(dtype == "int") {arr_id = xsArrayCreateInt(arr_size, 0, arr_name);}
    else if(dtype == "float") {arr_id = xsArrayCreateFloat(arr_size, 0.0, arr_name);}
    else if(dtype == "bool") {arr_id = xsArrayCreateBool(arr_size, false, arr_name);}
    else if(dtype == "string") {arr_id = xsArrayCreateString(arr_size, "", arr_name);}
    else if(dtype == "vector") {arr_id = xsArrayCreateVector(arr_size, cOriginVector, arr_name);}
<<<<<<< HEAD
    else {xsChatData("Create array failed, invalid data type."); return (Inf);}
=======
    else {xsChatData("Create array failed, invalid data type."); return (-32768);}
>>>>>>> b797119 (Release 2.0)
    // 将创建数组的 ID 和名称，添加进数组管理列表 array_list
    int list_size = xsArrayGetSize(array_list);
    // 当array_list的size小于新增数组ID+1时，扩充数组管理列表的长度
    if(list_size < arr_id+1) {xsArrayResizeString(array_list, list_size+1);}
    // 若arr_id 的数组未注册进 array_list，则进行注册操作
    if(xsArrayGetString(array_list, arr_id) == "") 
    {xsArraySetString(array_list, arr_id, arr_name);
    //xsChatData("Register array successed.");
    }
<<<<<<< HEAD
    else {xsChatData("Register array failed, the array already exists."); return (Inf);}
    return (arr_id);
}

/*
    数组 xs_arr01 -- xs_arr10 是函数 __xsPreDefinedArrays() 函数创建的10个预留数组的ID。
    这些ID指向的数组，在缓存某些函数的中间结果数组元素及其索引时提供方便。
*/
=======
    else {xsChatData("Register array failed, the array already exists."); return (-32768);}
    return (arr_id);
}

>>>>>>> b797119 (Release 2.0)
int xs_arr01 = -1;  int xs_arr02 = -1;
int xs_arr03 = -1;  int xs_arr04 = -1;
int xs_arr05 = -1;  int xs_arr06 = -1;
int xs_arr07 = -1;  int xs_arr08 = -1;
<<<<<<< HEAD
int xs_arr09 = -1;  int xs_arr10 = -1;  
void __xsPreDefinedArrays(int pre_size=1) 
{// 暂存数组 元素值 和 索引 的预留数组
    // 参数说明：pre_size: 预留数组创建时的数组长度，默认为 1
    xs_arr01 =    // arr.id = 1 , 该数组用于暂存bool型数组的元素值
        xsCreateArray("bool", "barr_vals", pre_size);
    xs_arr02 =    // arr.id = 2 , 该数组用于暂存 xs_arr01 数组的 argsort
        xsCreateArray("int", "barr_args", pre_size);
    xs_arr03 =    // arr.id = 3 , 该数组用于暂存int型数组的元素值
        xsCreateArray("int", "iarr_vals", pre_size);
    xs_arr04 =    // arr.id = 4 , 该数组用于暂存 xs_arr03 数组的 argsort
        xsCreateArray("int", "iarr_args", pre_size);
    xs_arr05 =    // arr.id = 5 , 该数组用于暂存float型数组的元素值
        xsCreateArray("float", "farr_vals", pre_size);
    xs_arr06 =    // arr.id = 6 , 该数组用于暂存 xs_arr05 数组的 argsort
        xsCreateArray("int", "farr_args", pre_size);
    xs_arr07 =    // arr.id = 7 , 该数组用于暂存string型数组的元素值
        xsCreateArray("string", "sarr_vals", pre_size);
    xs_arr08 =    // arr.id = 8 , 该数组用于暂存 xs_arr07 数组的 argsort
        xsCreateArray("int", "sarr_args", pre_size);
    xs_arr09 =    // arr.id = 9 , 该数组用于暂存vector型数组的元素值
        xsCreateArray("vector", "varr_vals", pre_size);
    xs_arr10 =    // arr.id = 10, 该数组用于暂存 xs_arr09 数组的 argsort
        xsCreateArray("int", "varr_args", pre_size);
}
// 注册10个预留数组的rule
rule predef_arrays
    inactive
    group PreArrays
    //minInterval 0
    runImmediately
    priority 99
{   __xsPreDefinedArrays(); xsDisableSelf();}



/// 资源投资复利机制 ///
void u1647_srcs_gen(float src242=0.0, float src243=0.0, float src244=0.0, float src245=0.0, int p=1) 
{// 贸易工厂4项资源生成率(点/秒)
    xsEffectAmount(1, 242, 0, src242/2.25, p);    // 食物生成率[点/秒]
    xsEffectAmount(1, 243, 0, src243/2.25, p);    // 木材生成率[点/秒]
    xsEffectAmount(1, 244, 0, src244/2.25, p);    // 石头生成率[点/秒]
    xsEffectAmount(1, 245, 0, src245/2.25, p);    // 黄金生成率[点/秒]
}

int resgen_ratios = -1;    // 存储 食物，木材，石头 资源每秒生成率的数组
int inv_list = -1;    // 投资列表
int back_rates = -1;    // 记录每期本金返还比例的数组

const int keep_gold = 300;    // 黄金预留库存
int inv_batches = 0;    // 累计投资批次
int off_batch = 0;    // 已经完成的投资批次
const int inv_terms = 10;    // 回款期数
const int reward_T = 30;    // 回款周期T

void inv_return_infos() 
{
    // 每100点投资利润每秒产生的 肉、木、石 奖励点数
    resgen_ratios = xsCreateArray("float", "resgen_ratios", 4);
    xsArraySetFloat(resgen_ratios, 0, 0.20);
    xsArraySetFloat(resgen_ratios, 1, 0.16);
    xsArraySetFloat(resgen_ratios, 2, 0.10);
    //xsArraySetFloat(resgen_ratios, 3, 0.00);
    // 各期返还总本金和总利息比例的数组（索引值代表期数）
    back_rates = xsCreateArray("float", "back_rates", 11);
    xsArraySetFloat(back_rates, 0, 0.0);
=======
int xs_arr09 = -1;  int xs_arr10 = -1;
void __xsPreDefinedArrays(int init_size=1) 
{
/*
    array_list : 数组管理列表，记录游戏中创建的数组ID及名称
    xs_arr01 ~ xs_arr10 : __xsPreDefinedArrays 函数创建的10个预留数组
    这些ID指向的数组，用于缓存某些操作的中间结果
*/
    array_list = xsArrayCreateString(1, "Arrays", "array_list");
    // 用于缓存变量的 值数组 ，索引数组
    // 参数说明：init_size: 预留数组创建时的数组长度，默认为 1
    xs_arr01 =    // arr.id = 1 , 该数组用于暂存bool型数组的元素值
        xsCreateArray("bool", "barr_vals", init_size);
    xs_arr02 =    // arr.id = 2 , 该数组用于暂存 xs_arr01 数组的 argsort
        xsCreateArray("int", "barr_args", init_size);
    xs_arr03 =    // arr.id = 3 , 该数组用于暂存int型数组的元素值
        xsCreateArray("int", "iarr_vals", init_size);
    xs_arr04 =    // arr.id = 4 , 该数组用于暂存 xs_arr03 数组的 argsort
        xsCreateArray("int", "iarr_args", init_size);
    xs_arr05 =    // arr.id = 5 , 该数组用于暂存float型数组的元素值
        xsCreateArray("float", "farr_vals", init_size);
    xs_arr06 =    // arr.id = 6 , 该数组用于暂存 xs_arr05 数组的 argsort
        xsCreateArray("int", "farr_args", init_size);
    xs_arr07 =    // arr.id = 7 , 该数组用于暂存string型数组的元素值
        xsCreateArray("string", "sarr_vals", init_size);
    xs_arr08 =    // arr.id = 8 , 该数组用于暂存 xs_arr07 数组的 argsort
        xsCreateArray("int", "sarr_args", init_size);
    xs_arr09 =    // arr.id = 9 , 该数组用于暂存vector型数组的元素值
        xsCreateArray("vector", "varr_vals", init_size);
    xs_arr10 =    // arr.id = 10, 该数组用于暂存 xs_arr09 数组的 argsort
        xsCreateArray("int", "varr_args", init_size);
}


// Round: 对实数 f_ 按照小数位数 n 进行四舍五入
float Round(float f_=0.0,int n=0){float num=0;int pn=pow(10,n);float pf=f_*pn;int ipf=1*pf; if(abs(pf-ipf)<0.5){num=1.0*ipf/pn;} else{num=1.0*(ipf+1)/pn;} return(num);}

/// 资源投资复利机制 ///
void Fac1647ResRate(float WR=0, float FR=0, float GR=0, float SR=0, int p=-1) 
{// 贸易工厂1647资源生成率设置[amt/sec]
    xsEffectAmount(1,243,0,WR/2.25,p); 
    xsEffectAmount(1,242,0,FR/2.25,p); 
    xsEffectAmount(1,245,0,GR/2.25,p); 
    xsEffectAmount(1,244,0,SR/2.25,p); 
}

// 每100点投资利润每秒产生的 肉、木、石 奖励点数
const float FOOD_RATE = 0.20;
const float WOOD_RATE = 0.16;
const float STONE_RATE= 0.10;
const float GOLD_RATE = 0.00;

int inv_history = -1;    // 投资历史列表
int back_rates = -1;    // 记录每期本金返还比例的数组
void inv_return_infos() 
{
    // 各期返还总本金和总利息比例的数组（索引值代表期数）
    back_rates = xsCreateArray("float", "back_rates", 11);
    xsArraySetFloat(back_rates, 0, 0.00);
>>>>>>> b797119 (Release 2.0)
    xsArraySetFloat(back_rates, 1, 0.06);
    xsArraySetFloat(back_rates, 2, 0.07);
    xsArraySetFloat(back_rates, 3, 0.08);
    xsArraySetFloat(back_rates, 4, 0.09);
    xsArraySetFloat(back_rates, 5, 0.10);
    xsArraySetFloat(back_rates, 6, 0.10);
    xsArraySetFloat(back_rates, 7, 0.11);
    xsArraySetFloat(back_rates, 8, 0.12);
    xsArraySetFloat(back_rates, 9, 0.13);
    xsArraySetFloat(back_rates,10, 0.14);
    // 记录投资历史的向量数组
<<<<<<< HEAD
    inv_list = xsCreateArray("vector", "inv_list", 21);
    xsArraySetVector(inv_list, 0, cOriginVector);
    
}

float wave_rate() 
{// invest的波动利率
    float wave_r = 0.0;
    int rand_i = xsGetRandomNumberLH(0, 100) + 1;
    if(rand_i <= 25) {wave_r = 0.09;}  // p=0.25
    else if(rand_i > 25 && rand_i <= 55) {wave_r = 0.1;}  // p=0.3
    else if(rand_i > 55 && rand_i <= 80) {wave_r = 0.11;}  // p=0.25
    else if(rand_i > 80 && rand_i <= 100) {wave_r = 0.12;}  // p=0.2
    else {}
    return (wave_r);
=======
    inv_history = xsCreateArray("vector", "inv_history", 21);
    xsArraySetVector(inv_history, 0, vector(0,0,0));
    
}

float inv_rate() 
{// 投资波动利率 [0.09, 0.12]
    float rate_ = 0.0;
    int rand_i = xsGetRandomNumberLH(0, 100) + 1;
    if(rand_i <= 25) {rate_ = 0.09;}  // p=0.25
    else if(rand_i > 25 && rand_i <= 55) {rate_ = 0.1;}  // p=0.30
    else if(rand_i > 55 && rand_i <= 80) {rate_ = 0.11;}  // p=0.25
    else if(rand_i > 80 && rand_i <= 100) {rate_ = 0.12;}  // p=0.20
    else {}
    return (rate_);
>>>>>>> b797119 (Release 2.0)
}

float invest_risk(float amount=0.0) 
{// 投资风险，会造成本金亏损
    int risk_fac = xsGetRandomNumberLH(0, 100)+1;
    if(risk_fac%2 == 0) {return(amount);}  // (100%, 0.50)
    else if(risk_fac%3 == 0) {return (0.9*amount);}  // (90%, 0.17)
    else if(risk_fac%5 == 0) {return (0.7*amount);}  // (70%, 0.07)
    else if(risk_fac%7 == 0) {return (0.5*amount);}  // (50%, 0.04)
<<<<<<< HEAD
    else if(risk_fac%11== 0) {return (0.0); }  // (0, 0.01)
=======
    else if(risk_fac%11== 0) {return (0.0);       }  // ( 0%, 0.01)
>>>>>>> b797119 (Release 2.0)
    else {}
    return (amount);
}

<<<<<<< HEAD
int offinvest_midx(int arr_id=-1, int midx=1) 
{// 返回投资已完成批次的最小索引值
    vector v_ = cOriginVector;
    float v_z = 0.0;
    for(i = 1; <= 20) 
    {
        v_ = xsArrayGetVector(inv_list, i);
        v_z = xsVectorGetZ(v_);
        if(v_z == 0) {midx = i; break;}
=======
int finished_inv_midx(int arr_id=-1, int midx=1) 
{// 返回投资已完成批次的最小索引值
    float inv_term = 0.0;
    for(i = 1; <= 20) 
    {
        inv_term = xsVectorGetZ(xsArrayGetVector(inv_history, i));
        if(inv_term == 0) {midx = i; break;}
>>>>>>> b797119 (Release 2.0)
    }
    return (midx);
}
void benefit_src_gen(float benefit=0.0) 
{//与本期返还利润对应的资源生成率
<<<<<<< HEAD
    float f_gen = benefit/100.0 * xsArrayGetFloat(resgen_ratios, 0);
    float w_gen = benefit/100.0 * xsArrayGetFloat(resgen_ratios, 1);
    float s_gen = benefit/100.0 * xsArrayGetFloat(resgen_ratios, 2);
    xsEffectAmount(1, 242, 0, f_gen/2.25, 1);
    xsEffectAmount(1, 243, 0, w_gen/2.25, 1);
    xsEffectAmount(1, 244, 0, s_gen/2.25, 1);
}

=======
    float food_ = benefit/100.0 * FOOD_RATE;
    float wood_ = benefit/100.0 * WOOD_RATE;
    float stone_= benefit/100.0 * STONE_RATE;
    xsEffectAmount(1, 242, 0, food_/2.25, 1);
    xsEffectAmount(1, 243, 0, wood_/2.25, 1);
    xsEffectAmount(1, 244, 0, stone_/2.25, 1);
}

int inv_batches = 0;    // 累计投资批次
int finished_batch = 0;    // 已经完成的投资批次
const int reward_T = 60;    // 回款周期T
>>>>>>> b797119 (Release 2.0)
rule invest_reward
    inactive
    group INVEST
    minInterval reward_T
    maxInterval reward_T
<<<<<<< HEAD
    //runImmediately
=======
>>>>>>> b797119 (Release 2.0)
    priority 50
{
    float reward_g1 = 0.0;    // 当期返还本金
    float reward_g2 = 0.0;    // 当期返还利息
    float reward_g = 0.0;    // 当期返还本息和
    int term_i =  -1;    // 期数缓存值
<<<<<<< HEAD
    vector invest_info = cOriginVector;
    //int inv_list_size = xsArrayGetSize(inv_list);
    for(batch_i=1; <=inv_batches) 
    {// 第 batch_i 次的投资详情
        invest_info = xsArrayGetVector(inv_list, batch_i);
        term_i = xsVectorGetZ(invest_info);
        if(term_i == 0) {// 若该次投资剩余期数为0，则该投资完成，跳过
            off_batch++;
            printf("Closed invest_batch: ", off_batch , 2);
=======
    vector invest_info = vector(0,0,0);
    //int history_size = xsArrayGetSize(inv_history);
    for(batch_i=1; <=inv_batches) 
    {// 第 batch_i 次的投资详情
        invest_info = xsArrayGetVector(inv_history, batch_i);
        term_i = xsVectorGetZ(invest_info);
        if(term_i == 0) {// 若该次投资剩余期数为0，则该投资完成，跳过
            finished_batch++;
            //xsChatData("Finished invest_batch: "+ finished_batch);
>>>>>>> b797119 (Release 2.0)
            continue;
        }
        else 
        {
            reward_g1 = reward_g1 + xsArrayGetFloat(back_rates, 11-term_i) * xsVectorGetX(invest_info);
            reward_g2 = reward_g2 + xsArrayGetFloat(back_rates,    term_i) * xsVectorGetY(invest_info);
            // 更新该投资批次剩余期数
            invest_info = xsVectorSetZ(invest_info, term_i-1);
<<<<<<< HEAD
            xsArraySetVector(inv_list, batch_i, invest_info);
        }
    }
    reward_g1 = invest_risk(reward_g1);    // 风险投资，亏本概率 29%
    printf("reward_g1: ", reward_g1, 3);
    printf("reward_g2: ", reward_g2, 4);
    reward_g = round(reward_g1+reward_g2);
    xsEffectAmount(1, 3, 1, reward_g, 1);
    benefit_src_gen(reward_g2);    // 设置food, wood, stone 生成点数
    if(off_batch >= inv_batches) 
    {// 若失效的投资 >= 投资最大批次，则禁用规则
        u1647_srcs_gen(0, 0, 0, 0, 1);
        off_batch = 0;
=======
            xsArraySetVector(inv_history, batch_i, invest_info);
        }
    }
    // 进行风险投资，有29%概率亏损本金
    reward_g1 = invest_risk(reward_g1);
    //xsChatData("reward_g1: "+ reward_g1);
    //xsChatData("reward_g2: "+ reward_g2);
    reward_g = Round(reward_g1+reward_g2);
    xsEffectAmount(1, 3, 1, reward_g, 1);
    // 设置food, wood, stone 生成点数
    //benefit_src_gen(reward_g2);
    xsEffectAmount(1, 242, 0, (0.01*FOOD_RATE*reward_g2)/2.25, 1);
    xsEffectAmount(1, 243, 0, (0.01*WOOD_RATE*reward_g2)/2.25, 1);
    xsEffectAmount(1, 244, 0, (0.01*STONE_RATE*reward_g2)/2.25,1);
    //xsEffectAmount(1, 245, 0, (0.01*GOLD_RATE*reward_g2)/2.25, 1);
    if(finished_batch >= inv_batches) 
    {// 若失效的投资 >= 投资最大批次，则禁用规则
        Fac1647ResRate(0, 0, 0, 0, 1);
        finished_batch = 0;
>>>>>>> b797119 (Release 2.0)
        xsDisableSelf();
    }  
}

<<<<<<< HEAD
void begin_invest() 
{// 通过点击物体追加投资，更新投资金额
    float golds = xsPlayerAttribute(1, 3);
    golds = golds - keep_gold;    // 超出预留金额keep_gold的部分用作投资
    xsEffectAmount(1, 3, 1, 0-golds, 1);  // 更新黄金库存
    // 将该次投资信息(本金，利息，期数)加入投资历史列表
    vector golds_v = xsVectorSet(golds, golds*wave_rate(), 10.0);
    //int off_midx = offinvest_midx(inv_list);
    //printf("Valid min idx of inv_list: ", off_midx, 7);
    xsArraySetVector(inv_list, offinvest_midx(inv_list), golds_v);
    if(inv_batches < 20) {inv_batches++;}
    //iter_array(inv_list, "", "vector");
    if(xsIsRuleEnabled("invest_reward") == false) 
    {xsEnableRule("invest_reward");}
}

void main() 
{
    u1647_srcs_gen(0,0,0,0,1);  // P1贸易工厂生成率初始化：0
}

=======
const int inv_terms = 10;    // 回款期数
const int keep_gold = 300;    // 黄金预留库存
void begin_invest() // 通过点击物体追加投资，更新投资金额
{
    // 超出预留金额keep_gold的部分用作投资
    float inv_gold = 1.0*xsPlayerAttribute(1, 3) - keep_gold;
    //从玩家黄金储存中扣除投资金额 inv_gold
    xsEffectAmount(1, 3, 1, 0-inv_gold, 1);
    // 将该次投资(本金，利息，期数)加入投资历史列表
    vector golds_v = xsVectorSet(inv_gold, inv_gold*inv_rate(), inv_terms);
    //int finished_midx = finished_inv_midx(inv_history);
    //xsChatData("Earliest finished invest idx: %d", finished_midx);
    xsArraySetVector(inv_history, finished_inv_midx(inv_history), golds_v);
    if(inv_batches < 20) {inv_batches++;}
    //iter_array(inv_history, "", "vector");
    if(xsIsRuleEnabled("invest_reward")==false) {xsEnableRule("invest_reward");}
}


void main() 
{
    Fac1647ResRate(0,0,0,0,1);  // P1贸易工厂生成率初始化：0
}
>>>>>>> b797119 (Release 2.0)
