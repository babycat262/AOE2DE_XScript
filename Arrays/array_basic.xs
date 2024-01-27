
/* 
                                数组基础篇
    数组的概念：
    将若干个具有相同类型的数据组合在一起，使其具有一定的排列顺序，这样的一组数据叫做数组。
    如下2个数组，分别是由同种类型的数据组成：
        [1, 3, 5, 7, 9]
        以上数组中的元素均是整数，该数组是整型数组。
      
        ["how", "do", "you", "playing", "AOE II", "?"]
        以上数组中的元素均是字符串，该数组是字符串数组。
    
    在 AOE2 XS 中，数组有以下几种类型：
        整型（int），浮点型（float），布尔型（bool），字符串型（string），向量型（vector）
    
    【注意】：
        1.在 AOE2 XS 中，数组的创建、元素赋值、数组访问方式，与 C/C++ 语言有较大的区别：
          如C/C++中 int arr[3]={1,2,3}; arr[2]; 等数组的创建和访问方式，在AOE2-XS中均不适用！
        2.在 AOE2 XS 中，数组的初始化，元素赋值，元素读取（访问）操作，都需要在 函数体 或 规则体 内部执行；
          如果在外部执行，则会报错（etc: Error: parseIntegerConstant failed.）
    
*/


/// XS数组的创建
/*  
    创建数组
    函数原型：
        int xsArrayCreate[Dtype](int size, [dtype] defaultValue, string arrayName);
    说明：
        1. xsArrayCreate[Dtype] 是创建数组时调用的内置函数，
           [Dtype]代表数组类型(Bool, Int, Float, String, Vector)，
           [dtype]代表数据类型(bool, int, float, string, vector)
        2. size参数是数组的长度（元素个数）
        3. defaultValue 表示数组创建时，元素的默认值
        4. arrayName 数组名称，用一个字符串表示，具有唯一性
        5. 函数返回值是int类型，它表示数组的ID
*/  

// 创建5个int变量，用于存放数组ID
int arr1_id = -1;
int arr2_id = -1;
int arr3_id = -1;
int arr4_id = -1;
int arr5_id = -1;

void array_init() // 该函数用于数组的初始化
{// 注：数组长度，即数组中的元素个数！
    // 创建一个长度为5的整型数组，元素默认值0，返回创建数组的ID
    arr1_id = xsArrayCreateInt(5, 0, "arr1");    // [0, 0, 0, 0, 0]

    // 创建一个长度为4的浮点型数组，元素默认值3.14，返回创建数组的ID
    arr2_id = xsArrayCreateFloat(4, 3.14, "arr2");    // [3.14, 3.14, 3.14, 3.14]

    // 创建一个长度为3的布尔型数组，元素默认值 false，返回创建数组的ID
    arr3_id = xsArrayCreateBool(3, false, "arr3");    // [false, false, false]

    // 创建一个长度为100的字符串数组，元素默认值 " " ，返回创建数组的ID
    arr4_id = xsArrayCreateString(100, " ", "arr4");    // [" ", " ", ... , " ", " "] （由100个 " " 组成）

    // 创建一个长度为3的向量数组，其中每个元素都是向量，默认值是预设的向量 def_vec ，返回创建数组的ID
    vector def_vec = vector(1.0, 1.0, 1.0);  // 用于设置向量型数组默认值的向量
    arr5_id = xsArrayCreateVector(3, def_vec, "arr5");    // [(1.0, 1.0, 1.0), (1.0, 1.0, 1.0), (1.0, 1.0, 1.0)]
}


/*  
    数组元素赋值：
    函数原型：
        int xsArraySet[Dtype](int arrayID, int index, [dtype] value);
    说明：
        1. [Dtype]代表数组类型(Bool, Int, Float, String, Vector)
           [dtype]代表数据类型(bool, int, float, string, vector)
        2. arrayID 是要访问数组的ID编号，在数组创建时定义；
        3. index 是要赋值元素的位置编号（元素位置编号从0开始，即index取值范围是: [0, 数组长度(size)-1] ）
        4. value 是 index 位置对应的元素值，这是你想要给它赋予的值
        4. 函数返回值是int类型，成功操作时，返回1
*/  
void array_assignment() 
{
    // 给 arr1 数组index=0的元素赋值为 3， index=4的元素赋值为 -10
    xsArraySetInt(arr1_id, 0, 3);    // [3, 0, 0, 0, 0]
    xsArraySetInt(arr1_id, 4, -10);    // [3, 0, 0, 0, -10]
    
    // 给 arr3 数组中最后1个元素赋值为 true
    int arr3_len = xsArrayGetSize(arr3_id);    // 获取数组的长度（元素个数）
    xsArraySetBool(arr3_id, arr3_len-1, true);
    
    // 给 arr4 数组index为偶数的元素赋值为 "str"
    int arr4_len = xsArrayGetSize(arr4_id);
    for(idx = 0; < arr4_len) 
    {
        if(idx%2 == 0) {xsArraySetString(arr4_id, idx, "str");}
        // 赋值操作完成后，arr4数组中元素情况是 ["str", " ", ... , "str", " "] 
        // index = 0,2,4, ... ,94,96,98 位置的元素值是"str"，其余元素是" "
    }

    // 给向量数组arr5中，index=1 的元素赋值为向量 (3.0, 5.8, -1.0)
    xsArraySetVector(arr5_id, 1, vector(3.0, 5.8, -1.0));  // [(1.0, 1.0, 1.0), (3.0, 5.8, -1.0), (1.0, 1.0, 1.0)]
}


/*  
    访问数组中的元素
    函数原型：
        [dtype] xsArrayGet[Dtype](int arrayID, int index);
    说明：
        1. [Dtype]代表数组类型(Bool,Int,Float,String,Vector)，[dtype]代表数据类型(bool,int,float,string,vector)
        2. arrayID 是要访问数组的ID编号，在数组创建时定义；
        3. index 是要访问元素的位置编号（元素位置编号从0开始，即index取值范围是: [0, 数组长度(size)-1] ）
        4. 函数返回相应类型的元素值
*/  

void visit_arr_element() 
{
/*
    // 访问数组 arr1 中 index=4 的元素
    int e1 = xsArrayGetInt(arr1_id, 4);
    xsChatData("the value of arr1[4] = " + e1);    // -10
    
    // 访问数组 arr3 中最后一个元素
    int arr3_len = xsArrayGetSize(arr3_id);
    bool e3 = xsArrayGetBool(arr3_id, arr3_len-1);
    xsChatData("the value of arr3[arr3_len-1] = " + e3);    // true
    
    // 访问数组 arr4 中的所有元素
    int arr4_len = xsArrayGetSize(arr4_id);
    string e4 = "";
    for(idx = 0; < arr4_len) 
    {
        e4 = xsArrayGetString(arr4_id, idx);
        xsChatData("the element of arr4["+idx+"] = " + e4);
    }
    */
    // 访问数组 arr5 中 index=1 的元素
    vector e5 = xsArrayGetVector(arr5_id, 1);  // e5是一个vector
    xsChatData("the X component of e5 is: " + xsVectorGetX(e5));  // 获取e5元素的X分量  3.0
    xsChatData("the Y component of e5 is: " + xsVectorGetY(e5));  // 获取e5元素的X分量  5.8
    xsChatData("the Z component of e5 is: " + xsVectorGetZ(e5));  // 获取e5元素的X分量 -1.0
    
}

/// 测试 ///
rule run_array_init
    active
    group Arrays
    //minInterval 1
    //maxInterval 1
    runImmediately
    priority 10
{
    array_init(); 
    array_assignment(); 
    visit_arr_element();
    
    xsDisableSelf();
}








