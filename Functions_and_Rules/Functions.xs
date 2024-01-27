<<<<<<< HEAD
include "Math.xs";


/*
    XS函数功能：
    说明：
      以 _ 开头的代表XS内置函数的简短名称（以及少数UDF函数）
      用户自定义函数（UDF）通常以大写字母开头
*/


/// 内置函数 ///
//创建Bool数组
int _BoolArr(int size=1, bool val=false, string name=""){return(xsArrayCreateBool(size,val,name));}
//设置Bool数组元素
int _BoolArrS(int arr=-1,int idx=0,bool val=false){return(xsArraySetBool(arr,idx,val));}
//获取Bool数组元素
bool _BoolArrG(int arr=-1,int idx=0){return(xsArrayGetBool(arr,idx));}
//创建Int数组
int _IntArr(int size=1, int val=-1, string name=""){return(xsArrayCreateInt(size,val,name));}
//设置Int数组元素
int _IntArrS(int arr=-1,int idx=0,int val=0){return(xsArraySetInt(arr,idx,val));}
//获取Int数组元素
int _IntArrG(int arr=-1,int idx=0){return(xsArrayGetInt(arr,idx));}
//创建Float数组
int _FloatArr(int size=1, float val=0.0, string name=""){return(xsArrayCreateFloat(size,val,name));}
//设置Float数组元素
int _FloatArrS(int arr=-1, int idx=0, float val=0.0){return(xsArraySetFloat(arr,idx,val));}
//获取Float数组元素
float _FloatArrG(int arr=-1, int idx=0){return(xsArrayGetFloat(arr,idx));}
//创建字符数组
int _StrArr(int size=1, string val="", string name=""){return(xsArrayCreateString(size,val,name));}
//设置字符数组元素
int _StrArrS(int arr=-1,int idx=0,string val=""){return(xsArraySetString(arr,idx,val));}
//获取字符数组元素
string _StrArrG(int arr=-1,int idx=0){return(xsArrayGetString(arr,idx));}
//创建vector数组
int _VectorArr(int size=1, vector val=cOriginVector, string name=""){return(xsArrayCreateVector(size,val,name));}
//设置vector数组的元素
int    _VectorArrS(int arr=-1,int idx=0,vector val=cOriginVector){return(xsArraySetVector(arr,idx,val));}
//获取vector数组元素
vector _VectorArrG(int arr=-1, int idx=0){return(xsArrayGetVector(arr,idx));}

//xsChatData -> Chat
void _Chat(string mes="",string c="",float n=0.000001){if((mes=="")&&(n==0.000001)){xsChatData(c);} else if((mes=="")&&(n!=0.000001)){xsChatData(c+n);} else if((mes!="")&&(n==0.000001)){xsChatData(c+mes);} else if((mes!="")&&(n!=0.000001)){xsChatData(c+mes+n);}}
//xsEffectAmount -> _Effect 
// auto _Effect = xsEffectAmount;
void _Effect(int mode=-1, int id=0, int attr=256, float value=0.0, int p=-1) {if(mode>=0 && mode<=9){xsEffectAmount(mode,id,attr,value,p);}}
//获取游戏中的玩家数量
int _NPlayers(){return(xsGetNumPlayers());}
//获取玩家文明编号
int _PCiv(int p=0){return(xsGetPlayerCivilization(p));}
//获取玩家拥有指定单位的总数量
int _GetOC(int p=0, int unit=0){return(xsGetObjectCount(p,unit));}
//获取玩家拥有指定单位的总数量（含地基）
int _GetOCT(int p=0, int unit=0){return(xsGetObjectCountTotal(p,unit));}
// 获取指定玩家的资源
float _GetPA(int p=0, int attr=0){return(xsPlayerAttribute(p,attr));}
//获取指定玩家的资源
void _SetPA(int p=0, int attr=0,float val=0.0){xsSetPlayerAttribute(p,attr,val);}
// 获取触发器变量的值
int _GetTV(int var=0){return(xsTriggerVariable(var));}
// 获取触发器变量的值
void _SetTV(int var=0,int val=0){xsSetTriggerVariable(var,val);}
// xsResearchTechnology -- _ResTech
bool _ResTech(int tech=0,bool force=true,bool abled=false,int p=0){return(xsResearchTechnology(tech,force,abled,p));}
//获取当前游戏时间秒数
int _GameT(){return (xsGetGameTime());}


/// User Defined Functions ///
// 退出游戏
mutable void _Exit(bool exit=true){ }
// 添加运行时事件 xsAddRuntimeEvent -> ARE
//bool xsAddRuntimeEvent(string runtime, string function, int arg);
bool ARE(string udf="", int arg=0, string runtime="Scenario Triggers") {return(xsAddRuntimeEvent(runtime,udf,arg));}

/*
    该函数通过调用udf指定的但参数函数，达到效果。
    udf参数为string类型，包括但不限于 标识副名称，某些无用关键字名称（如 goto, label 等）以这些名字命名的函数，不能通过普通方式调用
    Example: 
        goto(0);  //错误调用
        _FUNC("goto",0);  //正确调用
=======
/// 新增若干UDF函数 ///

/// 1. 数据类型&文件读写 ///

int sizeof(string DT="") 
{/*
  查看指定内置数据类型占用字节空间：
  参数说明：
    DT: 内置数据类型。有以下几种情况： {"string": 0, "int": 1, "bool": 1, "float": 2, "vector": 3}
    返回值：该数据类型占用内存的字节数
*/
    int _size = 0;
         if(DT=="string") {_size = xsGetDataTypeSize(0);}  // 4+len(s)
    else if(DT=="int"   ) {_size = xsGetDataTypeSize(1);}  // 4
    else if(DT=="bool"  ) {_size = xsGetDataTypeSize(1);}  // 4
    else if(DT=="float" ) {_size = xsGetDataTypeSize(2);}  // 4
    else if(DT=="vector") {_size = xsGetDataTypeSize(3);}  // 12
    else {_size = -1;}
    return (_size);
}

int xsObjectSize(int object=-1, string DT="int", vector map_obj=vector(-1,-1,-1)) 
{
/*
  查看集合对象 {Array, Vector, Map} 占用的内存空间
  参数说明： 
    object : 集合对象的ID编号（创建该集合时的int返回值）
    DT     : 集合对象存储的数据类型 {"string": 0, "int": 1, "bool": 1, "float": 2, "vector": 3}
    map_obj: Map 集合对象
    返回值：该数据类型占用内存的字节数
*/
    int  objLen = 0;  int _size = 0;
    if(object >= 0 && DT == "") {_size = xsArrayGetSize(object);}
    else if(object >= 0 && DT != "") 
    {
         if(DT=="int"   ) {_size = 4*xsArrayGetSize(object);}
    else if(DT=="bool"  ) {_size = 4*xsArrayGetSize(object);}
    else if(DT=="float" ) {_size = 4*xsArrayGetSize(object);}
    else if(DT=="string") {_size = 1*xsArrayGetSize(object)*xsGetDataTypeSize(0);}  // 4+len(s)
    else if(DT=="vector") {_size = 12*xsArrayGetSize(object);}
    else {_size = 0-1;}
    }
    else if(DT=="map" && (map_obj!=cInvalidVector)) 
    {
        objLen = xsArrayGetSize(xsVectorGetY(map_obj));
        _size = 8*objLen;
    }
    else {_size = 0-1;}
    return (_size);
}

// xsGetFilePosition -> _GetFP
int  _GetFP() {return(xsGetFilePosition());}
// xsSetFilePosition -> _SetFP
bool _SetFP(int byte=0){return(xsSetFilePosition(byte));}


// Exit game.
mutable void xsExit(bool exit=true){if(exit){xsChatData("%NULL");}}
// xsGetFunctionID -> FuncID
int FuncID(string fname=""){return(xsGetFunctionID(fname));}

// 添加运行时事件 xsAddRuntimeEvent -> ARE
bool ARE(string udf="", int arg=0, string runtime="Scenario Triggers") {return(xsAddRuntimeEvent(runtime,udf,arg));}
/*
  该函数通过调用udf参数指定的自定义函数，并将形参arg传入该函数中。
  参数说明：
    udf: string类型，指定要调用的函数名称。该名称遵循标识符命名规则；
         此外还包括一些无效键字名称如 goto, label 等。（以这些名字命名的函数，不能通过普通方式调用，正确调用方式参见下叙Example）
    arg: 传入udf函数的参数
  
    Example: 
      goto(0);  //错误调用
      _FUNC("goto",0);  //正确调用
>>>>>>> b797119 (Release 2.0)
*/
bool _FUNC(string udf="", int arg=0){return(xsAddRuntimeEvent("Scenario Triggers",udf,arg));}


/// 单位属性相关功能封装 ///
void UnitVolume(int unit=0, vector volume=vector(-1,-1,-1), int p=-1) 
{// 设置单位的 碰撞体积
    float x_dim = xsVectorGetX(volume);
    float y_dim = xsVectorGetY(volume);
    float z_dim = xsVectorGetZ(volume);
    if(x_dim>0 && x_dim<8){xsEffectAmount(0, unit, 3, x_dim, p);}
    if(y_dim>0 && y_dim<8){xsEffectAmount(0, unit, 4, y_dim, p);}
    if(z_dim>0 && z_dim<8){xsEffectAmount(0, unit,32, z_dim, p);}
}

void GenerateUnit(int unit=74,int times=1,int buildId=12,int max_builds=0,int p=1) 
{
/*
    在指定建筑周围生成单位
    参数说明：
      unit: 产生单位的ID
      times: 产生次数（每次1个）
      buildId: 产生单位的建筑ID
      max_builds: 最大产生建筑数
*/
    if(unit > 0 && buildId > 0) {
    xsEffectAmount(1,234,0,max_builds,p); 
    xsEffectAmount(7,unit,buildId,times,p);
    }
}

/// 英雄技能相关 ///
void UnitHeroStatus(int unit=1, int h_stat=0, int p=-1, float cure_rate=0.0) 
/*
    设置单位的英雄状态：
    参数说明：
    unit: 单位ID
    h_stat: 英雄状态，取值情况如下：
        {0:"非英雄状态", 1:"完全体英雄状态", 2:"免疫招降", 4:"可缓慢自愈（30HP/min）", 8:"默认防御状态", 16:"在阵型中受保护", 32:"安全删除（del需要确认）", 64:"英雄光环效果", 128:"反转除1外的其他标志位"} 
    p: 玩家序号
    cure_rate: 自愈速率（min）
*/
{
    xsEffectAmount(0, unit, 40, h_stat, p);
    xsEffectAmount(0, unit, 109, cure_rate, p);
}

void UnitBlasts(int unit=0, 
        int blast_att=-1,    // 溅射攻击等级（伤害附近敌军）
        int blast_def=-1,    // 溅射防御等级
        float blast_w=0.0,    // 溅射宽度
        float blast_rate=0.0,    // 溅射伤害比例
        int p=-1) 
{// 设置单位 践踏|溅射 属性
    if(blast_att== 0 || blast_att== 1 || blast_att== 2 || 
       blast_att== 4 || blast_att==64 || blast_att==128) 
       {xsEffectAmount(0, unit, 44, blast_att, p);}    
    
    if(blast_def== 0 || blast_def== 1 || 
       blast_def== 2 || blast_def== 4 ) 
       {xsEffectAmount(0, unit, 45, blast_def, p);}
    
    if(blast_w > 0.0 && blast_w <= 10.0) {xsEffectAmount(0, unit, 22, blast_w, p);}
    // blast_rate > 0 时，对附近敌军造成百分比伤害
    if(blast_rate > 0 && blast_rate <= 1.0) {xsEffectAmount(0, unit, 115, blast_rate, p);}
    // blast_rate < 0 时，对目标正后方敌军造成固定 X点伤害
    else if(blast_rate < 0 && blast_rate > -256) {xsEffectAmount(0, unit,115, 0+blast_rate, p);}
}

bool UnitCharges(int unit=0, int charge_event=0, int charge_type=0, float max_charge=0.0, float recharge_rate=0.0,  int p=-1 )
{
/*
    设置单位蓄力：
    unit: 单位ID
    charge_event: 蓄力事件
    charge_type: 蓄力类型
    max_charge: 最大蓄力值
    recharge_rate: 蓄力再生率（秒）
    返回值[bool]: 若成功设置蓄力，返回true，否则返回false
*/
    if(charge_event==0 || (charge_type<0 || charge_type>4 || charge_type==2)) {return (false);}
    xsEffectAmount(0, unit, 61, charge_event, p);
    xsEffectAmount(0, unit, 62, charge_type, p);
    xsEffectAmount(0, unit, 59, max_charge, p);
    xsEffectAmount(0, unit, 60, recharge_rate, p);
    return (true);
}

void UnitTraits(int  unit1=0, int _trait=-1, int p=-1, int unit2=0) 
{//单位特技设置
    // 特技：[1]可驻扎单位，[2]舰船属性，[4]可建造建筑，[16]自动侦察（初始斥候）
    if(_trait==0 || _trait==1 || _trait==2 || _trait==16) {xsEffectAmount(0, unit1, 54, _trait, p);}
    else if(_trait==4) //单位1 可建造 单位2（建筑）
    {xsEffectAmount(0, unit1, 54, 4, p);}
    else if(_trait==8 && unit2 > 0) {// 单位1 变身 单位2
        xsEffectAmount(0, unit1, 54, 8, p);
        xsEffectAmount(0, unit2, 54, 8, p);
        xsEffectAmount(0, unit1, 56, unit2, p);
        xsEffectAmount(0, unit2, 56, unit1, p);
    }
    else {}
}

void clear_trait(int unit=0, int p=-1) 
{//清除单位特技
    xsEffectAmount(0, unit, 54, 0, p); 
    xsEffectAmount(0, unit, 56,-1, p);
}

void ProjectileUnitMode(int proj_id= -1, 
                        int smart_mode= -1, int hit_mode= -1, int pass_mode= -1, 
                        float proj_arc= -1, 
                        int p=-1)
/*
    设置抛掷物单位模式：
    参数说明：
        proj_id: 抛掷物ID
        smart_mode: 弹道学模式
        hit_mode: 命中模式
        pass_mode: 穿透模式
        proj_arc: 抛掷物弧度
        p: 玩家序号
*/
{// 设置抛掷物模式
    if(smart_mode>=0 && smart_mode<=3)
      {xsEffectAmount(0, proj_id, 19, smart_mode, p);}
    if(hit_mode>=0 && hit_mode<=3)
      {xsEffectAmount(0, proj_id, 67, hit_mode, p);}
    if(pass_mode==0 || pass_mode==1)
      {xsEffectAmount(0, proj_id, 68, pass_mode, p);}
    if(proj_arc != -1 && (proj_arc >= -0.06 && proj_arc <= 0.65))
      {xsEffectAmount(0, proj_id, 69, proj_arc, p);}
}


/// 玩家&建筑资源 设置 ///
/*
    参数说明：
    WR: 木材资源生成率
    FR: 食物资源生成率
    GR: 黄金资源生成率
    SR: 石头资源生成率
    p:  玩家编号
*/
void FeitoriaResRate(float WR=0.7, float FR=1.6, float GR=1.0, float SR=0.3, int p=-1) 
{// 大商站资源生成率设置[amt/min]
    xsEffectAmount(1,206,0,WR,p); 
    xsEffectAmount(1,205,0,FR,p); 
    xsEffectAmount(1,208,0,GR,p); 
    xsEffectAmount(1,207,0,SR,p); 
}

void PlayerResRate(float WR=0, float FR=0, float GR=0, float SR=0, int p=-1) 
{// 玩家资源生成率设置[amt/min]
    xsEffectAmount(1,231,0,WR,p); 
    xsEffectAmount(1,230,0,FR,p); 
    xsEffectAmount(1,233,0,GR,p); 
    xsEffectAmount(1,232,0,SR,p); 
}

void Fac1647ResRate(float WR=0, float FR=0, float GR=0, float SR=0, int p=-1) 
{// 贸易工厂1647资源生成率设置[amt/sec]
    xsEffectAmount(1,243,0,WR/2.25,p); 
    xsEffectAmount(1,242,0,FR/2.25,p); 
    xsEffectAmount(1,245,0,GR/2.25,p); 
    xsEffectAmount(1,244,0,SR/2.25,p); 
}
