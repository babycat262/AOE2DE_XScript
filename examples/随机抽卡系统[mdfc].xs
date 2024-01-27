//随机抽卡系统
int arkaku=-1; 
int arinkaku=-1; 
int kw=1;
int a1=1;
int jy=1;
int player=1;
int x1=10;
int x2=3;
void create_arkaku()
{
    arkaku=xsArrayCreateInt(11,1,"ka");
    arinkaku=xsArrayCreateInt(11,0,"inka");
}
void Kaku()
{
xsArraySetInt(arkaku,1,1732);
xsArraySetInt(arkaku,2,1731);
xsArraySetInt(arkaku,3,1730);
xsArraySetInt(arkaku,4,1729);
xsArraySetInt(arkaku,5,1727);
xsArraySetInt(arkaku,6,1725);
xsArraySetInt(arkaku,7,1721);
xsArraySetInt(arkaku,8,1718);
xsArraySetInt(arkaku,9,1715);
xsArraySetInt(arkaku,10,1713);
}
void get_ka()
{
int change=xsGetObjectCount(player,0);
if(change>=1)
{
    while(jy<=x1)
    {
        xsEffectAmount(2,xsArrayGetInt(arkaku,jy),0,0,player);
        jy++;
    }
    jy=1;    
    while(kw<=x2)
    {
        int rand1=xsGetRandomNumberLH(1,x1+1)+1;
        int a=xsArrayGetInt(arinkaku,1);
        int b=xsArrayGetInt(arinkaku,2);
        int c=xsArrayGetInt(arinkaku,3);
        if(a!=rand1&&b!=rand1&&c!=rand1)
        {
            xsArraySetInt(arinkaku,kw,rand1);
            xsEffectAmount(0,xsArrayGetInt(arkaku,rand1),42,1264,player);
            xsEffectAmount(0,xsArrayGetInt(arkaku,rand1),43,kw,player);
            xsEffectAmount(2,xsArrayGetInt(arkaku,rand1),1,0,player);
            kw++;
        }  
    }
    kw=1;
    xsArraySetInt(arinkaku,1,0);
    xsArraySetInt(arinkaku,2,0);
    xsArraySetInt(arinkaku,3,0);
    xsArraySetInt(arinkaku,4,0);
    xsEffectAmount(0,0,0,0,player);
    xsEffectAmount(0,0,0,1,player);
}
}
void play1_8()
{
    while(a1<=8)
    {
        xsEffectAmount(2,0,1,0,a1);
        xsEffectAmount(0,0,42,1264,a1);
        xsEffectAmount(0,0,43,14,a1);
        xsEffectAmount(0,0,110,0,a1);
        xsEffectAmount(0,0,101,3,a1);
        xsEffectAmount(0,0,58,16691,a1);
        xsEffectAmount(0,0,50,0,a1);
        xsEffectAmount(0,0,51,105121,a1);
        xsEffectAmount(0,0,25,14,a1);
        xsEffectAmount(5,0,106,-1,a1);
        xsEffectAmount(0,0,106,0,a1);
        a1++;
    }
    a1=1;
}
rule initialize
active
runImmediately
priority 100
{
    create_arkaku();
    Kaku();
    play1_8();
    xsDisableSelf();
}
rule circulate
active
minInterval 1
{
    while(player<=8)
    {
        get_ka();
        player++;
    }
    player=1;
}
