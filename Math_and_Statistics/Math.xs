/// 数学工具模块 ///

<<<<<<< HEAD
=======
//数据类型
const bool   _BOOL = false;    //bool类型的默认值
const int    _INT = int;    //int类型的默认值
const float  _FLOAT = float;    //float类型的默认值
      string _STR = string;    //string类型的默认值


>>>>>>> b797119 (Release 2.0)
//常量
extern const float mEPS = 0.000001;    //浮点数的最小精度
extern const float mPI = 3.1416;    //圆周率
extern const float mE = 2.7183;    // 自然底数 E
extern const float mRAD = 180.0/mPI ;    // 弧度(约等于57.3°)
extern const int RAND_MAX = 32767;    // 随机函数产生的最大整数
extern const int INT_MAX = 999999999;    //int类型的最大值

<<<<<<< HEAD
//数据类型
const bool   _bool = false;    //bool类型的默认值
const int    _int = 0;    //int类型的默认值
const float  _float = 0.0;    //float类型的默认值
//const string _str="";    //string类型的默认值
const vector V0 = vector(0,0,0);    // 零向量 vector(0,0,0)

// 数值转bool类型 {0: false, !0: true}
bool _Bool(float val=0.0) {if(abs(val)>0){return(true);} return(false);}
// 将布尔数值转化为字符串 {true: "true", false: "false"}
string _Bool2Str(bool val=false) {if(val){return("true");} return("false");}

=======

string Num2Str(int val=-999999999, bool logic=false) 
/*
  返回一个字符串型的数字，默认构造则返回空字符串""。
  参数说明：
    val: 玩家传来的数字，取值范围在(-E9, E9)之间
    logic: 是否返回bool形式的字符串，该参数为true时，由val值决定返回结果：{val>0: "true", val<=0: "false"}
*/ 
{
    string s_="";
         if(logic){if(val>0){s_="true";} else{s_="false";}}
    else if(val==0){s_="00";}
    else if(val!=0 && val!=0-999999999){s_="0"+val;}
    return(s_);
}

// 数值转bool类型 {0: false, !0: true}
bool Num2Bool(float val=0.0) {if(abs(val)>0){return(true);} return(false);}
// 将布尔数值转化为字符串 {true: "true", false: "false"}
string Bool2Str(bool val=false) {if(val){return("true");} return("false");}
>>>>>>> b797119 (Release 2.0)
// 对浮点数向下取整
int Floor(float f_=0.0){return(1*f_);}
// 对浮点数向上取整
int Ceil(float f_=0.0){int f2_=f_; if(abs(f_-f2_)>0){return(f2_+1);} return(f2_);}
// Round: 对实数 f_ 按照小数位数 n 进行四舍五入
float Round(float f_=0.0,int n=0){float num=0;int pn=pow(10,n);float pf=f_*pn;int ipf=1*pf; if(abs(pf-ipf)<0.5){num=1.0*ipf/pn;} else{num=1.0*(ipf+1)/pn;} return(num);}
<<<<<<< HEAD
=======


/// 进制转化 ///
extern const int _0xA = 10;    // 十六进制 10
extern const int _0xB = 11;    // 十六进制 11
extern const int _0xC = 12;    // 十六进制 12
extern const int _0xD = 13;    // 十六进制 13
extern const int _0xE = 14;    // 十六进制 14
extern const int _0xF = 15;    // 十六进制 15


int radix16_i = 0;
int __hex(int num=0) {//十进制 -> 十六进制
    const int k = 16;
    int arr_size = 1;
    int mod_arr = xsArrayCreateInt(arr_size, 0, "radix16"+radix16_i); radix16_i ++;
    int idx = 0;    //数组索引标号，每次向数组中添加元素后，索引 idx+1
    int m_ = 0;    //单个余数
    while(num > 0) {
        m_ = num % k;
        xsArraySetInt(mod_arr, idx, m_);
        num = num / k;    //每次除以k后， 更新被除数的值
        arr_size++;
        xsArrayResizeInt(mod_arr, arr_size);
        idx++;
    }
    arr_size = arr_size-1;
    xsArrayResizeInt(mod_arr, arr_size);
    idx = 0;
    return (mod_arr);
}

int radixK_i = 0;
int __RadixK(int num=0, int k=10) 
{// 把 十进制数 转化为 K进制数
    //存储每一位余数的数组
    int arr_size = 1;
    int mod_arr = xsArrayCreateInt(arr_size, 0, "radixK"+radixK_i); radixK_i++;
    int idx = 0;    //数组索引标号，每次向数组中添加元素后，索引 idx+1
    int m_ = 0;    //单个余数
    int k_num = 0;    //最终余数
    
    if(k >= 2 && k <= 10) //{2, 8, 10, <16>}
    {
        while(num > 0) {
        m_ = num % k;
        xsArraySetInt(mod_arr, idx, m_);
        num = num / k;    //每次除以k后， 更新被除数的值
        arr_size++;
        xsArrayResizeInt(mod_arr, arr_size);
        idx++;
        }
    }
    else {xsChatData("Invalid Radix: "+ k); return (-32768);}
    
    arr_size-- ;
    xsArrayResizeInt(mod_arr, arr_size);
    //逆向遍历余数数组，将每一位上的数字进行拼接
    for(idx = arr_size-1; >=0) {
        //xsChatData("["+idx+"]: "+xsArrayGetInt(mod_arr,idx));
        k_num = 10*k_num + xsArrayGetInt(mod_arr, idx);
    }
    return (k_num);
}
>>>>>>> b797119 (Release 2.0)
