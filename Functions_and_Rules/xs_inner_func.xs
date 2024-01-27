/*
    XS高频内置函数重命名：
    说明：
      形如 _Function 的代表XS内置函数的简短名称
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
// xsEffectAmount -> _Effect 
void _Effect(int mode=-1, int id=0, int attr=256, float value=0.0, int p=-1) {if(mode>=0 && mode<=9){xsEffectAmount(mode,id,attr,value,p);}}
//获取玩家文明编号
int _PlayerCiv(int p=0){return(xsGetPlayerCivilization(p));}
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
//获取地图尺寸
vector xsGetMapSize() {vector map_size=xsVectorSet(xsGetMapWidth(),xsGetMapHeight(),xsGetMapID()); return(map_size);}
// 设置上下文玩家（修改属性的默认玩家） xsSetContextPlayer -> _ContextP 
void _ContextP(int p=1){xsSetContextPlayer(p);}
