/// 统计学功能 ///
inlcude "Math.xs";

//随机数
// Random: 产生[0.0, 1.0)之间的实数（精度0.000001）
mutable float Random(){int n1=xsGetRandomNumber(); int I=xsGetRandomNumberLH(0,31); if(I>=30){n1=xsGetRandomNumberLH(0,16990);} float n2=0.000001*(n1+I*32767); return(n2);}
// RandInt: 返回区间[(+/-)low, (+/-)high)之间的随机整数（不含high）
mutable int RandInt(int low=0,int high=0,bool sign_=false){static int sign=1;if(sign_){sign=0-sign;} return(sign*(xsGetRandomNumberLH(0,high-low)+low));}
// RandLong: 产生随机大整数
//int RandLong(int max_=999999999){int I=xsGetRandomNumberLH(0,max_/999999+1); int lar=xsGetRandomNumber(); if(I==1000){lar=xsGetRandomNumberLH(0,1000);} return(I*999999+lar);}
mutable 
int RandLong(int max_=999999999) {int ri=RandInt(0,32767);int I=RandInt(0,30519); if(I>=30518){ri=RandInt(0,16693);} int Long=32767*I+ri; return(Long);}

mutable 
float RandUniform(float max_=1000000, bool sign_=false) 
{// 返回区间[-max_ , +max_)上的实数
    if(sign_){static int sign=1; sign=0-sign;}    // 数字前的符号
    int n1 = xsGetRandomNumber();
    int I1max = 1*max_/32767;
    int I1 = xsGetRandomNumberLH(0, I1max+1);
    if(I1 == I1max) {n1 = xsGetRandomNumberLH(0, 1+max_-I1max*32767);}
    n1 = 32767*I1+n1;
    int n2 = xsGetRandomNumber();
    int I2 = xsGetRandomNumberLH(0,31);
    if(I2 >= 30) {n2 = xsGetRandomNumberLH(0,16990);}
    n2 = 32767*I2+n2 ;
    float res = 0.000001*n2+n1;
    return (res);
}

mutable 
bool Probability(float prob=0.5)
{// 概率触发函数，当随机值小于prob时，函数返回true
    static int fix=1; fix=0-fix;
    int rn = xsGetRandomNumber();
    int I = xsGetRandomNumberLH(0,31);
    if(I>=30){rn = xsGetRandomNumberLH(0,16990);}
    rn = rn+32767*I;
    float rp = 0.000001*(rn+1);
    if((rp>=0.83 && rp<=0.84) && fix==1){rp = rp - 0.7;}
    if(rp < prob){return (true);}
    return (false);
}

