/// 向量工具类 ///
const vector V0 = vector(0,0,0);    // 零向量
const vector Vx = vector(1,0,0);    // X轴单位向量
const vector Vy = vector(0,1,0);    // Y轴单位向量
const vector Vz = vector(0,0,1);    // Z轴单位向量


/// 向量运算 ///
vector xsVectorNumOP(vector vec=cOriginVector, float num=0.0, string operator="") 
{
/*
  向量与数字之间的运算
  参数说明：
    vec: 要进行运算的向量
    num: 要进行运算的数字
    operator: 操作符。可能的情况有：{"": 不做操作，返回原向量, "+": 相加, "-": 相减, "*": 相乘, "/": 相除, 
                                     "%": 取余数, "pow": 对各分量求幂 }
*/
    float Xc = 0.0;  float Yc = 0.0;  float Zc = 0.0;
    if(operator=="") {return (vec);}
    else if(operator=="+") 
    {
        Xc = xsVectorGetX(vec) + num;
        Yc = xsVectorGetY(vec) + num;
        Zc = xsVectorGetZ(vec) + num;
    }
    else if(operator=="-") 
    {
        Xc = xsVectorGetX(vec) - num;
        Yc = xsVectorGetY(vec) - num;
        Zc = xsVectorGetZ(vec) - num;
    }
    else if(operator=="*") 
    {
        Xc = xsVectorGetX(vec) * num;
        Yc = xsVectorGetY(vec) * num;
        Zc = xsVectorGetZ(vec) * num;
    }
    else if(operator=="/") 
    {
        if(num == 0) {xsChatData("Vector can't div by zero."); return(vector(-1,-1,-1));}
        Xc = xsVectorGetX(vec) / num;
        Yc = xsVectorGetY(vec) / num;
        Zc = xsVectorGetZ(vec) / num;
    }
    else if(operator=="%") 
    {
        Xc = xsVectorGetX(vec) % num;
        Yc = xsVectorGetY(vec) % num;
        Zc = xsVectorGetZ(vec) % num;
    }
    else if(operator=="pow") 
    {
        Xc = pow(xsVectorGetX(vec),num);
        Yc = pow(xsVectorGetY(vec),num);
        Zc = pow(xsVectorGetZ(vec),num);
    }
    else {xsChatData("Invalid operate for vector."); return(vector(-1,-1,-1));}
    //根据匹配的operator，计算结果向量
    vec = xsVectorSet(Xc, Yc, Zc);
    return (vec);
}

float xsVectorS2(vector vec=cOriginVector) 
{//求向量vec的平方（向量模的平方））
  //float vec_S2 = pow(xsVectorGetX(vec),2) + pow(xsVectorGetY(vec),2) + pow(xsVectorGetZ(vec),2);
    float vec_S2 = pow(xsVectorLength(vec),2);
    return (vec_S2);
}

vector xsVectorsOP(vector vec1=cOriginVector, vector vec2=cOriginVector, string operator="+") 
{
/*
  两个向量之间进行运算。
  参数说明：
    vec1: 进行运算的第一个向量
    vec2: 进行运算的第二个向量
    operator: 操作符。可能的情况有：{"+": 逐元素相加, "-": 逐元素相减, "*": 逐元素相乘, "%": 逐元素取余数}
*/
    vector v_res = vector(0,0,0);
    float Xc = 0.0;  float Yc = 0.0;  float Zc = 0.0;
    if(operator=="+") 
    {
        Xc = xsVectorGetX(vec1) + xsVectorGetX(vec2);
        Yc = xsVectorGetY(vec1) + xsVectorGetY(vec2);
        Zc = xsVectorGetZ(vec1) + xsVectorGetZ(vec2);
    }
    else if(operator=="-") 
    {
        Xc = xsVectorGetX(vec1) - xsVectorGetX(vec2);
        Yc = xsVectorGetY(vec1) - xsVectorGetY(vec2);
        Zc = xsVectorGetZ(vec1) - xsVectorGetZ(vec2);
    }
    else if(operator=="*") 
    {
        Xc = xsVectorGetX(vec1) * xsVectorGetX(vec2);
        Yc = xsVectorGetY(vec1) * xsVectorGetY(vec2);
        Zc = xsVectorGetZ(vec1) * xsVectorGetZ(vec2);
    }
    else if(operator=="%")
    {
        Xc = xsVectorGetX(vec1) % xsVectorGetX(vec2);
        Yc = xsVectorGetY(vec1) % xsVectorGetY(vec2);
        Zc = xsVectorGetZ(vec1) % xsVectorGetZ(vec2);
    }
    else {xsChatData("Invalid operate for vectors."); return(vector(-1,-1,-1));}
    v_res = xsVectorSet(Xc, Yc, Zc);
    return (v_res);
}

float xsVectorDot(vector vec1=cOriginVector, vector vec2=cOriginVector) 
{//两个向量的点乘：v1.dot(v2)
    float v_dot = xsVectorGetX(vec1)*xsVectorGetX(vec2) + 
                  xsVectorGetY(vec1)*xsVectorGetY(vec2) + 
                  xsVectorGetZ(vec1)*xsVectorGetZ(vec2) ;
    return (v_dot);
}


/// Map（键值对映射）集合相关功能 ///
/*
  由键数组和值数组组成的Map，代表键值对（key : value）的映射，每个key（string类型）都有一个值（bool|int|float）与之对应
  Map 的结构示意图如下：
  0 --------------------------- N  索引顺序 index
    key1  key2 ... keyN-1  keyN    key_arr（键数组）
     |     |    |   |       |
     |     |    |   |       |
    val1  val2 ... valN-1  valN    val_arr（值数组）
    
    Map在创建时，key_arr 和 val_arr的长度总是相等的，可以指定初始长度 map_size；
    Map遍历时，根据index找到对应的键值对；
    对Map插入和删除元素，可以用过 index 和 key 两种方式删除对应的键值对。以key方式删除，会删掉该Map中所有与指定key相同的索引处的键值对
    以下Map相关函数的调用方式，普遍采用 vector(key_arr,val_arr,val_type) 的方式将Map传入给函数形参；
    其中 val_type 表示值数组数据类型的ID具体如下：
    {0: string, 1: int, 2: float, 3: vector（该类型存在BUG,不使用）, 4: bool}
*/
int valArr_i = 0;  //Map键数组ID暂存值
vector xsMap(string map_name="new_map", string dtype="float", int map_size=0) 
{
/*
  根据key和val的T类型，创建对应的Map映射
  参数说明：
    map_name: Map集合的名称
    dtype: Map值类型 {0:"string", 1:"int", 2:"float", 3:"vector", 4:"bool"}
    map_size: Map初始键值对个数
    返回值：vector类型，返回由 key_arr，val_arr，val_type 组成的向量
*/
    if(map_size<0) {map_size = 0;}
    int key_arr = xsArrayCreateString(map_size, "", map_name);
    if(key_arr == -1) {//若该map_name已经存在
        xsChatData("Create map failed, `"+map_name+"` map is already exists.");
        return(cInvalidVector);
    }
    //值数组的类型：int | bool | float | string | vector
    int val_arr = -1;
    int val_type = -1;
         if(dtype=="int"   ){val_arr = xsArrayCreateInt(map_size,  0,    map_name+"_vals"+valArr_i); valArr_i++; val_type=1;}
    else if(dtype=="bool"  ){val_arr = xsArrayCreateBool(map_size, false,map_name+"_vals"+valArr_i); valArr_i++; val_type=4;}
    else if(dtype=="float" ){val_arr = xsArrayCreateFloat(map_size, 0.0, map_name+"_vals"+valArr_i); valArr_i++; val_type=2;}
    else if(dtype=="string"){val_arr = xsArrayCreateString(map_size, "", map_name+"_vals"+valArr_i); valArr_i++; val_type=0;}
    else {xsChatData("Invalid dtype with val_arr, create map failed."); return(cInvalidVector);}
    // 将 key_arr，val_arr，val_type 加入到Map中
    vector map_ = xsVectorSet(key_arr, val_arr, val_type);
    return (map_);
}

string xsMapGetKey(vector map_=vector(-1,-1,-1), int index=0) 
{
/*
  根据指定的索引，查找到Map对应的key值并返回
  参数说明：
    map_ : 要查找的Map对象
    index : 要查找的索引位置
    返回值[string]：找到的key值，未找到返回"NULL"
*/
    int key_arr = xsVectorGetX(map_);
    int map_size = xsArrayGetSize(key_arr);
    if(index < -1 || index >= map_size) {xsChatData("Index out of range."); return("NULL");}
    if(index == -1) {index = map_size-1;}
    string key_ = xsArrayGetString(key_arr, index);
    return (key_);
}

float xsMapGetValue(vector map_=vector(-1,-1,-1), int index=0) 
{
/*
  根据指定的索引，查找到对应的value值并返回
  参数说明：
    map_ : 要查找的Map对象
    index : 要查找的索引位置
    返回值[int | float]：找到的val值，未找到返回 -32768
*/
    int val_arr = xsVectorGetY(map_);
    int val_type = xsVectorGetZ(map_);
    int map_size = xsArrayGetSize(val_arr);
    if(index < -1 || index >= map_size) {xsChatData("Index out of range."); return(0-32768);}
    if(index == -1) {index = map_size-1;}
    //根据val_type类型，返回数组 val_arr 在index处的元素
    float val_i = 0;
    switch(val_type) {
      //case 0: {return (xsArrayGetString(val_arr, index)); break;}
        case 1: {return (xsArrayGetInt(val_arr, index)); break;}
        case 2: {return (xsArrayGetFloat(val_arr, index)); break;}
      //case 3: {return (xsArrayGetVector(val_arr, index)); break;}
        case 4: {return (xsArrayGetBool(val_arr, index)); break;}
        default: {val_i= -32768;}
    }
    return (val_i);
}

vector xsMapInsertInt(vector map_=vector(-1,-1,0), string key_="new_key", int val_=-1, int index=-1, bool sort_keys=false) 
{
/*
  在Int型的Map中插入元素
  参数说明：
    map_ : 要插入键值对的Map对象
    key_ : 插入Map的 键
    val_ : 插入键对应的值
    index: 索引，表示元素的插入位置
    sort_keys: 若为true，插入数据后，重新对key数组进行升序排序
*/
    //从形参map_中获取key_arr和val_arr
    int key_arr = xsVectorGetX(map_);
    int val_arr = xsVectorGetY(map_);
    int val_type = xsVectorGetZ(map_);
    // check key_arr & val_arr is valid or not.
    if(key_arr<=0) {xsChatData("Error, this map's key_arr is not exist."); return (cInvalidVector);}
    if(val_arr<=0) {xsChatData("Error, this map's val_arr is not exist."); return (cInvalidVector);}
    //检查数据类型是否为 Int
    if(val_type != 1) {xsChatData("Incorrect val_ dtype."); return (cInvalidVector);}

    int map_size = xsArrayGetSize(key_arr);
    map_size++;  //key数组长度+1
    xsArrayResizeString(key_arr, map_size);
    xsArrayResizeInt(val_arr, map_size);
    //数据插入位置纠正
    if(index == -1 || index >= map_size) {index = map_size-1;}
    else if(index < -1) {index = 0;}
    if(index != map_size-1) 
    {//若插入数据的位置不在尾部，该位置后的元素依次向后移动1
        for(idx = map_size-1; >index) {
            xsArraySetString(key_arr, idx, xsArrayGetString(key_arr, idx-1));
            xsArraySetInt(val_arr, idx, xsArrayGetInt(val_arr, idx-1));
        }
    }
    //在索引index处插入新数据
    xsArraySetString(key_arr, index, key_);
    xsArraySetInt   (val_arr, index, val_);
    if(sort_keys) {//对 key_arr 顺序重新排序
        // ...
    }
    return (map_);
}

vector xsMapInsertFloat(vector map_=vector(-1,-1,0), string key_="new_key", float val_=-1.0, int index=-1, bool sort_keys=false) 
{
/*
  在Float型的Map中插入元素
  参数说明：
    map_ : 要插入键值对的Map对象
    key_ : 插入Map的 键
    val_ : 插入键对应的值
    index: 索引，表示元素的插入位置
    sort_keys: 若为true，插入数据后，重新对key数组进行升序排序
*/
    //从形参map_中获取key_arr和val_arr
    int key_arr = xsVectorGetX(map_);
    int val_arr = xsVectorGetY(map_);
    int val_type = xsVectorGetZ(map_);
    // check key_arr & val_arr is valid or not.
    if(key_arr<=0) {xsChatData("Error, this map's key_arr is not exist."); return (cInvalidVector);}
    if(val_arr<=0) {xsChatData("Error, this map's val_arr is not exist."); return (cInvalidVector);}
    //检查数据类型是否为 Float
    if(val_type != 2) {xsChatData("Incorrect val_ dtype."); return (cInvalidVector);}

    int map_size = xsArrayGetSize(key_arr);
    map_size++;  //key数组长度+1
    xsArrayResizeString(key_arr, map_size);
    xsArrayResizeFloat(val_arr, map_size);
    //数据插入位置纠正
    if(index == -1 || index >= map_size) {index = map_size-1;}
    else if(index < -1) {index = 0;}
    if(index != map_size-1) 
    {//若插入数据的位置不在尾部，该位置后的元素依次向后移动1
        for(idx = map_size-1; >index) {
            xsArraySetString(key_arr, idx, xsArrayGetString(key_arr, idx-1));
            xsArraySetFloat(val_arr, idx, xsArrayGetFloat(val_arr, idx-1));
        }
    }
    //在索引index处插入新数据
    xsArraySetString(key_arr, index, key_);
    xsArraySetFloat (val_arr, index, val_);
    if(sort_keys) {//对 key_arr 顺序重新排序
        // ...
    }
    return (map_);
}

vector xsMapInsertString(vector map_=vector(-1,-1,0), string key_="new_key", string val_="", int index=-1, bool sort_keys=false) 
{
/*
  在String型的Map中插入元素
  参数说明：
    map_ : 要插入键值对的Map对象
    key_ : 插入Map的 键
    val_ : 插入键对应的值
    index: 索引，表示元素的插入位置
    sort_keys: 若为true，插入数据后，重新对key数组进行升序排序
*/
    //从形参map_中获取key_arr和val_arr
    int key_arr = xsVectorGetX(map_);
    int val_arr = xsVectorGetY(map_);
    int val_type = xsVectorGetZ(map_);
    // check key_arr & val_arr is valid or not.
    if(key_arr<=0) {xsChatData("Error, this map's key_arr is not exist."); return (cInvalidVector);}
    if(val_arr<=0) {xsChatData("Error, this map's val_arr is not exist."); return (cInvalidVector);}
    //检查数据类型是否为 String
    if(val_type != 0) {xsChatData("Incorrect val_ dtype."); return (cInvalidVector);}

    int map_size = xsArrayGetSize(key_arr);
    map_size++;  //key数组长度+1
    xsArrayResizeString(key_arr, map_size);
    xsArrayResizeString(val_arr, map_size);
    //数据插入位置纠正
    if(index == -1 || index >= map_size) {index = map_size-1;}
    else if(index < -1) {index = 0;}
    if(index != map_size-1) 
    {//若插入数据的位置不在尾部，该位置后的元素依次向后移动1
        for(idx = map_size-1; >index) {
            xsArraySetString(key_arr, idx, xsArrayGetString(key_arr, idx-1));
            xsArraySetString(val_arr, idx, xsArrayGetString(val_arr, idx-1));
        }
    }
    //在索引index处插入新数据
    xsArraySetString(key_arr, index, key_);
    xsArraySetString(val_arr, index, val_);
    if(sort_keys) {//对 key_arr 顺序重新排序
        // ...
    }
    return (map_);
}

float xsMapFindElement(vector map_=cInvalidVector, string find_way="key", string key_="", int val_=0) 
{
/*
  通过指定方式，查找Map集合中的键值对元素，返回其所在索引位置
  参数说明：
    map_ : 要查找的Map对象
    find_way : 查找方式：{"key": 根据键查找, "val": 根据值查找}
    key_ : "key"方式对应查找的key值
    val_ : "value"方式对应查找的val值
    返回值：若找到元素，返回对应的索引位置，未找到返回 -1
*/
    //从形参map_中获取key_arr和val_arr
    int key_arr = xsVectorGetX(map_);
    int val_arr = xsVectorGetY(map_);
    int val_type = xsVectorGetZ(map_);
    if(key_arr<=0 || val_arr<=0) {xsChatData("This map is not exist."); return (-1);}
    int map_size = xsArrayGetSize(key_arr);
    
    int idx = 0;
    if(find_way=="key") {for(i=0; <map_size){if(key_ == xsArrayGetString(key_arr, i)) {idx = i; break;}}}
    else if(find_way=="val") {
        if(val_type==1) {for(i=0; <map_size) {if(val_ == xsArrayGetInt(val_arr, i)){idx = i; break;}}}
      //if(val_type==4) {for(i=0; <map_size) {if(val_ == xsArrayGetBool(val_arr, i)){idx = i; break;}}}
        if(val_type==2) {for(i=0; <map_size) {if(val_ == xsArrayGetFloat(val_arr, i)){idx = i; break;}}}
      //if(val_type==0) {for(i=0; <map_size) {if(val_ == xsArrayGetString(val_arr, i)){idx = i; break;}}}
    }
    else {xsChatData("Invalid `find_way`, exit find the map.");}
    return (idx);
}

vector xsMapDelElement(vector map_=cInvalidVector, int index=-1, string key_="") 
{
/*
  根据key或者index，删除Map中的一个键值对元素
  参数说明：
    map_ : 要删除键值对的Map对象
    key_ : 指定的键
    index: 要删除元素的索引位置
    返回值：返回删除指定键值对后的Map对象。
*/
    //vector v_res = vector(-1,-1,-1);
    int key_arr = xsVectorGetX(map_);
    int val_arr = xsVectorGetY(map_);
    int val_type = xsVectorGetZ(map_);
    int map_size = xsArrayGetSize(key_arr);
    if(key_ == "") { //根据index删除键值对
        if(index < -1 || index >= map_size) {xsChatData("Index out of range. delete element failed."); return(cInvalidVector);}
        else if(index == -1) {index = map_size-1;}
        else {}
        for(idx = index; < map_size) {
            if(idx < map_size-1) {//将index位置后的元素依次前移
                xsArraySetString(key_arr, idx, xsArrayGetString(key_arr, idx+1));
                if(val_type==1) {xsArraySetInt(val_arr, idx, xsArrayGetInt(val_arr, idx+1));}
                if(val_type==4) {xsArraySetBool(val_arr, idx, xsArrayGetBool(val_arr, idx+1));}
                if(val_type==2) {xsArraySetFloat(val_arr, idx, xsArrayGetFloat(val_arr, idx+1));}
                if(val_type==0) {xsArraySetString(val_arr, idx, xsArrayGetString(val_arr, idx+1));}
            }
            else {//删除最后一个元素
                xsArrayResizeString(key_arr, map_size-1);
                if(val_type==1) {xsArrayResizeInt(val_arr, map_size-1);}
                if(val_type==4) {xsArrayResizeBool(val_arr, map_size-1);}
                if(val_type==2) {xsArrayResizeFloat(val_arr, map_size-1);}
                if(val_type==0) {xsArrayResizeString(val_arr, map_size-1);}
                map_size--;
            }
        }
    }
    else {//若指定了key_ ，删除所有键等于指定key_值的键值对
        int same_keys = 0;    //Map集合中与指定键相同的key的数量
        for(i = 0; < map_size) { if(key_ == xsArrayGetString(key_arr, i)){same_keys++;} }
        //xsChatData("<GREY>same_keys: %d", same_keys);
        //暂存map中keys的数组
        const int karr_temp = 7;  xsArrayResizeString(karr_temp, map_size-same_keys);
        //暂存map中vals的数组
        const int varr_I = 3;  xsArrayResizeInt(varr_I, map_size-same_keys);
        const int varr_B = 1;  xsArrayResizeBool(varr_B, map_size-same_keys);
        const int varr_F = 5;  xsArrayResizeFloat(varr_F, map_size-same_keys);
      //const int varr_S = 11;  xsArrayResizeString(varr_S, map_size-same_keys);
        //遍历数组 karr_temp 和 varr_T 的索引
        int idx2 = 0;
        string key_i= string;
        int val_i = -1; bool val_b = false; float val_f = 0.0; string val_s = "";
        for(i = 0; < map_size) 
        {
            key_i = xsArrayGetString(key_arr, i);
            if(key_i != key_) {//将key_arr中与指定key_不相同的键值对存入 karr_temp, varr_I
                xsArraySetString(karr_temp, idx2, key_i);
                if(val_type==1) {xsArraySetInt(varr_I, idx2, xsArrayGetInt(val_arr, i));}
                if(val_type==4) {xsArraySetBool(varr_B, idx2, xsArrayGetBool(val_arr, i));}
                if(val_type==2) {xsArraySetFloat(varr_F, idx2, xsArrayGetFloat(val_arr, i));}
              //if(val_type==0) {xsArraySetString(varr_S, idx2, xsArrayGetString(val_arr, i));}
                idx2++;
            }
        }
        //将 karr_temp 和 varr_T 中的数据拷贝到 key_arr, val_arr
        xsArrayResizeString(key_arr, map_size-same_keys);
        if(val_type==1) {xsArrayResizeInt(val_arr, map_size-same_keys);}
        if(val_type==4) {xsArrayResizeBool(val_arr, map_size-same_keys);}
        if(val_type==2) {xsArrayResizeFloat(val_arr, map_size-same_keys);}
      //if(val_type==0) {xsArrayResizeString(val_arr, map_size-same_keys);}
        for(j = 0; < map_size-same_keys) 
        {
            xsArraySetString(key_arr, j, xsArrayGetString(karr_temp, j));
            if(val_type==1) {xsArraySetInt(val_arr, j, xsArrayGetInt(varr_I, j));}
            if(val_type==4) {xsArraySetBool(val_arr, j, xsArrayGetBool(varr_B, j));}
            if(val_type==2) {xsArraySetFloat(val_arr, j, xsArrayGetFloat(varr_F, j));}
          //if(val_type==0) {xsArraySetString(val_arr, j, xsArrayGetString(varr_S, j));}
        }
        switch(val_type) {
            case 1: {xsArrayResizeInt   (varr_I, 1); break;}
            case 4: {xsArrayResizeBool  (varr_B, 1); break;}
            case 2: {xsArrayResizeFloat (varr_F, 1); break;}
            //case 0: {xsArrayResizeString(varr_S, 1); break;}
            default: {}
        }
        xsArrayResizeString(karr_temp, 1);
        //map_ = xsVectorSet(key_arr, val_arr, val_type);
    }
    return (map_);
}

void xsMapIterator(vector map_=cInvalidVector, string map_name="") 
{//对Map集合中的元素进行迭代，打印输出
    string key_ = "";
    int    vI = -1; 
    bool   vB = false; 
    float  vF = 0.0; 
    string vS = ""; 
    vector vVec = vector(-1,-1,-1);
    
    int key_arr = xsVectorGetX(map_);
    int val_arr = xsVectorGetY(map_);
    int val_type = xsVectorGetZ(map_);
    int map_size = xsArrayGetSize(key_arr);
    
    if(val_type == 1) 
    {// 遍历 整型Map
        for(i=0; <map_size) {
            key_ = xsArrayGetString(key_arr,i);
            vI = xsArrayGetInt(val_arr,i);
            xsChatData("Map("+map_name+")["+key_+"] : "+vI);
        }
    }
    else if(val_type == 4) 
    {// 遍历 布尔型Map
        for(i=0; <map_size) {
            key_ = xsArrayGetString(key_arr,i);
            vB = xsArrayGetBool(val_arr,i);
            xsChatData("Map("+map_name+")["+key_+"] : "+vB);
        }
    }
    else if(val_type == 2) 
    {// 遍历 浮点型Map
        for(i=0; <map_size) {
            key_ = xsArrayGetString(key_arr,i);
            vF = xsArrayGetFloat(val_arr,i);
            xsChatData("Map("+map_name+")["+key_+"] : "+vF);
        }
    }
    else if(val_type == 0) 
    {// 遍历 字符型Map
        for(i=0; <map_size) {
            key_ = xsArrayGetString(key_arr,i);
            vS = xsArrayGetString(val_arr,i);
            xsChatData("Map("+map_name+")["+key_+"] : "+vS);
        }
    }
    else if(val_type == 3) 
    {// 遍历 vector型Map
        for(i=0; <map_size) {
            key_ = xsArrayGetString(key_arr,i);
            vVec = xsArrayGetVector(val_arr,i);
            xsChatData("Map("+map_name+")["+key_+"] : "+vVec);
        }
    }
}
