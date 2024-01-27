
// RandInt: 返回区间[(+/-)low, (+/-)high)之间的随机整数（不含high）
int RandInt(int low=0,int high=0,bool sign_=false){static int sign=1;if(sign_){sign=0-sign;} return(sign*(xsGetRandomNumberLH(0,high-low)+low));}


mutable 
void iter_array(int arr_id=-1, string arr_name="", string dtype="float", string color="") 
{
/*
    循环遍历数组元素，并打印输出。
    参数说明：
      arr_id: 要遍历的数组ID
      arr_name: 要遍历的数组名称字符串
      dtype: 数组数据类型
*/ 
    int arr_size = xsArrayGetSize(arr_id);
    if(arr_name == "") {arr_name = ""+arr_id;}
    // 这些变量存储array迭代中元素的缓存值
    int    ie = 0;
    float  fe = 0.0;
    bool   be = false;
    string se = "";
    vector ve = cOriginVector; //float ve_x = 0.0; float ve_y = 0.0; float ve_z = 0.0;
    
    if(dtype == "int") // 遍历int型数组
    {for(i = 0; < arr_size) {ie = xsArrayGetInt(arr_id, i); xsChatData(color+"Array("+arr_name+")["+i+"] = " + ie);}}
    else if(dtype == "float") // 遍历float型数组
    {for(i = 0; < arr_size) {fe = xsArrayGetFloat(arr_id, i); xsChatData(color+"Array("+arr_name+")["+i+"] = " + fe);}}
    else if(dtype == "bool") // 遍历bool型数组
    {for(i = 0; < arr_size) {be = xsArrayGetBool(arr_id, i); xsChatData(color+"Array("+arr_name+")["+i+"] = " + be);}}
    else if(dtype == "string") // 遍历string型数组
    {for(i = 0; < arr_size) {se = xsArrayGetString(arr_id, i); xsChatData(color+"Array("+arr_name+")["+i+"] = " + se);}}
    else if(dtype == "vector") // 遍历vector型数组
    {
        for(i = 0; < arr_size) 
        {
            ve = xsArrayGetVector(arr_id, i);
            //xsChatData("Array("+arr_name+").vector["+i+"].X = " + xsVectorGetX(ve));
            //xsChatData("Array("+arr_name+").vector["+i+"].Y = " + xsVectorGetY(ve));
            //xsChatData("Array("+arr_name+").vector["+i+"].Z = " + xsVectorGetZ(ve));
            xsChatData(color+"Array("+arr_name+")["+i+"] = " + ve);
        }
    }
    else {xsChatData("Data type is invalid.");}
}


int iarr_temp = 0;
int farr_temp = 0;
int adds_arr_i = 0;
<<<<<<< HEAD
int IntArrOperateNum(int arr_id=-1, string operate="+", int num=0) 
=======
int IntArrOperateNum(int arr_id=-1, string operator="+", int num=0) 
>>>>>>> b797119 (Release 2.0)
{
/* 
  整型数组与数字间的运算：
  参数说明：
    arr_id: 数组ID
<<<<<<< HEAD
    operate: 数组操作运算符。可能的情况为：{"+":加, "-":减, "*":乘, "/":除, "%":取余数, "pow":幂运算}
    num: operate运算符操作的数值
    返回值[int]：数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    //根据operate的不同情况进行数组操作
    if(operate == "+") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) + num);}}
    else if(operate == "-") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) - num);}}
    else if(operate == "*") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) * num);}}
    else if(operate == "/") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) / num);}}
    else if(operate == "%") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) % num);}}
    else if(operate == "pow") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, pow(xsArrayGetInt(arr_id,idx),num) );}}
=======
    operator: 数组操作运算符。可能的情况为：{"+":加, "-":减, "*":乘, "/":除, "%":取余数, "pow":幂运算}
    num: operator运算符操作的数值
    返回值[int]：数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    //根据operator的不同情况进行数组操作
    if(operator == "+") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) + num);}}
    else if(operator == "-") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) - num);}}
    else if(operator == "*") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) * num);}}
    else if(operator == "/") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) / num);}}
    else if(operator == "%") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, xsArrayGetInt(arr_id, idx) % num);}}
    else if(operator == "pow") {for(idx=0; <arr_size) {xsArraySetInt(arr_id, idx, pow(xsArrayGetInt(arr_id,idx),num) );}}
>>>>>>> b797119 (Release 2.0)
    else {xsChatData("Invalid operator for array."); return (-1);}
    return (arr_id);
}

<<<<<<< HEAD
int FloatArrOperateNum(int arr_id=-1, string operate="+", float num=0.0) 
=======
int FloatArrOperateNum(int arr_id=-1, string operator="+", float num=0.0) 
>>>>>>> b797119 (Release 2.0)
{
/* 
  浮点型数组与数字间的运算：
  参数说明：
    arr_id: 数组ID
<<<<<<< HEAD
    operate: 数组操作运算符。可能的情况为：{"+":加, "-":减, "*":乘, "/":除, "%":取余数, "pow":幂运算}
    num: operate运算符操作的数值
    返回值[int]：数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    //根据operate的不同情况进行数组操作
    if(operate == "+") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) + num);}}
    else if(operate == "-") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) - num);}}
    else if(operate == "*") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) * num);}}
    else if(operate == "/") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) / num);}}
    else if(operate == "%") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) % num);}}
    else if(operate == "pow") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, pow(xsArrayGetFloat(arr_id,idx),num) );}}
=======
    operator: 数组操作运算符。可能的情况为：{"+":加, "-":减, "*":乘, "/":除, "%":取余数, "pow":幂运算}
    num: operator运算符操作的数值
    返回值[int]：数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    //根据operator的不同情况进行数组操作
    if(operator == "+") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) + num);}}
    else if(operator == "-") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) - num);}}
    else if(operator == "*") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) * num);}}
    else if(operator == "/") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) / num);}}
    else if(operator == "%") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, xsArrayGetFloat(arr_id, idx) % num);}}
    else if(operator == "pow") {for(idx=0; <arr_size) {xsArraySetFloat(arr_id, idx, pow(xsArrayGetFloat(arr_id,idx),num) );}}
>>>>>>> b797119 (Release 2.0)
    else {xsChatData("Invalid operator for array."); return (-1);}
    return (arr_id);
}

<<<<<<< HEAD
int IntArrsOperate(int arr1_id=-1, int arr2_id=-1, string operate="") 
=======
int IntArrsOperate(int arr1_id=-1, int arr2_id=-1, string operator="") 
>>>>>>> b797119 (Release 2.0)
{
/* 两个整型数组间的运算：
    参数说明：
      arr1_id: 数组1的ID
      arr2_id: 数组2的ID
<<<<<<< HEAD
      operate: 数组运算符。可能的情况为：{"+":加, "-":减, "*":乘, "/":除, "%":取余数}
=======
      operator: 数组运算符。可能的情况为：{"+":加, "-":减, "*":乘, "/":除, "%":取余数}
>>>>>>> b797119 (Release 2.0)
      返回值[int]：运算结果数组的ID （错误返回 -1）
*/
    int arr1_size = xsArrayGetSize(arr1_id);
    int arr2_size = xsArrayGetSize(arr2_id);
    //找出最短数组的元素个数
    int min_size = 0;
    if(arr1_size < arr2_size){min_size = arr1_size;} else{min_size = arr2_size;}
    
    int res_arr = xsArrayCreateInt(min_size, 0, "adds_arr"+adds_arr_i); adds_arr_i++;
<<<<<<< HEAD
         if(operate == "+") {
        for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) + xsArrayGetInt(arr2_id,idx)));}
    }
    else if(operate == "-") {
        for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) - xsArrayGetInt(arr2_id,idx)));}
    }
    else if(operate == "*") {
        for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) * xsArrayGetInt(arr2_id,idx)));}
    }
    else if(operate == "/") {
        for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) / xsArrayGetInt(arr2_id,idx)));}
    }
    else if(operate == "%") {
        for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) % xsArrayGetInt(arr2_id,idx)));}
    }
=======
    if(operator == "+") {for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) + xsArrayGetInt(arr2_id,idx)));}}
    else if(operator == "-") {for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) - xsArrayGetInt(arr2_id,idx)));}}
    else if(operator == "*") {for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) * xsArrayGetInt(arr2_id,idx)));}}
    else if(operator == "/") {for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) / xsArrayGetInt(arr2_id,idx)));}}
    else if(operator == "%") {for(idx=0; <min_size) {xsArraySetInt(res_arr, idx, (xsArrayGetInt(arr1_id,idx) % xsArrayGetInt(arr2_id,idx)));}}
>>>>>>> b797119 (Release 2.0)
    else {xsChatData("Invalid operator for arrays."); return (-1);}
    return (res_arr);
}

<<<<<<< HEAD
int FloatArrsOperate(int arr1_id=-1, int arr2_id=-1, string operate="") 
=======
int FloatArrsOperate(int arr1_id=-1, int arr2_id=-1, string operator="") 
>>>>>>> b797119 (Release 2.0)
{
/* 两个浮点型数组间的运算：
    参数说明：
      arr1_id: 数组1的ID
      arr2_id: 数组2的ID
<<<<<<< HEAD
      operate: 数组运算符。可能的情况为：{"+":加, "-":减, "*":乘, "/":除, "%":取余数}
=======
      operator: 数组运算符。可能的情况为：{"+":加, "-":减, "*":乘, "/":除, "%":取余数}
>>>>>>> b797119 (Release 2.0)
      返回值[int]：运算结果数组的ID （错误返回 -1）
*/
    int arr1_size = xsArrayGetSize(arr1_id);
    int arr2_size = xsArrayGetSize(arr2_id);
    //找出最短数组的元素个数
    int min_size = 0;
    if(arr1_size < arr2_size){min_size = arr1_size;} else{min_size = arr2_size;}
<<<<<<< HEAD
    
    int res_arr = xsArrayCreateFloat(min_size, 0, "adds_arr"+adds_arr_i); adds_arr_i++;
    if(operate == "+") {
        for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) + xsArrayGetFloat(arr2_id,idx)));}
    }
    else if(operate == "-") {
        for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) - xsArrayGetFloat(arr2_id,idx)));}
    }
    else if(operate == "*") {
        for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) * xsArrayGetFloat(arr2_id,idx)));}
    }
    else if(operate == "/") {
        for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) / xsArrayGetFloat(arr2_id,idx)));}
    }
    else if(operate == "%") {
        for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) % xsArrayGetFloat(arr2_id,idx)));}
    }
=======
    int res_arr = xsArrayCreateFloat(min_size, 0, "adds_arr"+adds_arr_i); adds_arr_i++;
    if(operator == "+") {for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) + xsArrayGetFloat(arr2_id,idx)));}}
    else if(operator == "-") {for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) - xsArrayGetFloat(arr2_id,idx)));}}
    else if(operator == "*") {for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) * xsArrayGetFloat(arr2_id,idx)));}}
    else if(operator == "/") {for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) / xsArrayGetFloat(arr2_id,idx)));}}
    else if(operator == "%") {for(idx=0; <min_size) {xsArraySetFloat(res_arr, idx, (xsArrayGetFloat(arr1_id,idx) % xsArrayGetFloat(arr2_id,idx)));}}
>>>>>>> b797119 (Release 2.0)
    else {xsChatData("Invalid operator for arrays."); return (-1);}
    return (res_arr);
}

int IntArrsDot(int arr1_id=-1, int arr2_id=-1) 
{
/* 整型数组的点乘(内积)：对应数组元素相乘再求和
    参数说明：
        arr1_id: 数组1的ID
        arr2_id: 数组2的ID
        返回值[float]：点乘计算结果（默认返回 -1）
*/
    int arr1_size = xsArrayGetSize(arr1_id);
    int arr2_size = xsArrayGetSize(arr2_id);
    if(arr1_size == arr2_size) // 若俩数组的长度相等，进行点乘运算
    {
        float dot = 0.0;
        for(idx = 0; < arr1_size) 
        {dot = dot + (xsArrayGetInt(arr1_id, idx) * xsArrayGetInt(arr2_id, idx));}
        return (dot);
    }
    else {xsChatData("array1.size don't equal to array2.size.");}
    return (-1);
}

float FloatArrsDot(int arr1_id=-1, int arr2_id=-1) 
{
/* 浮点数组的点乘(内积)：对应数组元素相乘再求和
    参数说明：
        arr1_id: 数组1的ID
        arr2_id: 数组2的ID
        返回值[float]：点乘计算结果（默认返回 -1）
*/
    int arr1_size = xsArrayGetSize(arr1_id);
    int arr2_size = xsArrayGetSize(arr2_id);
    if(arr1_size == arr2_size) // 若俩数组的长度相等，进行点乘运算
    {
        float dot = 0.0;
        for(idx = 0; < arr1_size) 
        {dot = dot + (xsArrayGetFloat(arr1_id, idx) * xsArrayGetFloat(arr2_id, idx));}
        return (dot);
    }
    else {xsChatData("array1.size don't equal to array2.size.");}
    return (-1.0);
}


/// 数组统计相关 ///
int IntArrRandChoice(int arr_id=-1, int start_idx=0, int end_idx=-1) 
{
/*
  随机取出整型数组在索引区间 [start_idx, end_idx) 上的1个元素：
  参数说明：
    arr_id: 数组ID
    start_idx: 区间起始索引
    end_idx: 区间结束索引
    返回值[int]: 随机取出元素值
*/
    int arr_size = xsArrayGetSize(arr_id);
    if(start_idx < 0 || start_idx >= arr_size || end_idx >= arr_size) 
    {xsChatData("Array index out of range."); return(-32767);}
    if(end_idx == -1) {end_idx = arr_size-1;}
    int r_idx = xsGetRandomNumberLH(start_idx, end_idx+1) + start_idx;
    int r_e = xsArrayGetInt(arr_id, r_idx);
    return (r_e);
}

float FloatArrRandChoice(int arr_id=-1, int start_idx=0, int end_idx=-1) 
{
/*
  随机取出浮点型数组在索引区间 [start_idx, end_idx) 上的1个元素：
  参数说明：
    arr_id: 数组ID
    start_idx: 区间起始索引
    end_idx: 区间结束索引
    返回值[int]: 随机取出元素值
*/
    int arr_size = xsArrayGetSize(arr_id);
    if(start_idx < 0 || start_idx >= arr_size || end_idx >= arr_size) 
    {xsChatData("Array index out of range."); return(-32767);}
    if(end_idx == -1) {end_idx = arr_size-1;}
    int r_idx = xsGetRandomNumberLH(start_idx, end_idx+1) + start_idx;
    float r_e = xsArrayGetFloat(arr_id, r_idx);
    return (r_e);
}

string StringArrRandChoice(int arr_id=-1, int start_idx=0, int end_idx=-1) 
{
/*
  随机取出字符型数组在索引区间 [start_idx, end_idx) 上的1个元素：
  参数说明：
    arr_id: 数组ID
    start_idx: 区间起始索引
    end_idx: 区间结束索引
    返回值[int]: 随机取出元素值
*/
    int arr_size = xsArrayGetSize(arr_id);
    if(start_idx < 0 || start_idx >= arr_size || end_idx >= arr_size) 
    {xsChatData("Array index out of range."); return("NULL");}
    if(end_idx == -1) {end_idx = arr_size-1;}
    int r_idx = xsGetRandomNumberLH(start_idx, end_idx+1) + start_idx;
    string r_e = xsArrayGetString(arr_id, r_idx);
    return (r_e);
}

vector VectorArrRandChoice(int arr_id=-1, int start_idx=0, int end_idx=-1) 
{
/*
  随机取出向量型数组在索引区间 [start_idx, end_idx) 上的1个元素：
  参数说明：
    arr_id: 数组ID
    start_idx: 区间起始索引
    end_idx: 区间结束索引
    返回值[int]: 随机取出元素值
*/
    int arr_size = xsArrayGetSize(arr_id);
    if(start_idx < 0 || start_idx >= arr_size || end_idx >= arr_size) 
    {xsChatData("Array index out of range."); return(vector(-1,-1,-1));}
    if(end_idx == -1) {end_idx = arr_size-1;}
    int r_idx = xsGetRandomNumberLH(start_idx, end_idx+1) + start_idx;
    vector r_e = xsArrayGetVector(arr_id, r_idx);
    return (r_e);
}


float IntArrStatis(int arr_id=-1, string indicator="") 
{
/*
  统计整型数组的统计学指标：
  参数说明：
    arr_id: 
    indicator: 统计学指标。可能的情况有：
        max: 最大值
        min: 最小值
        sum: 求和
        mean: 均值
        median: 中位数
        S2: 方差
    返回值[float]: 返回指定的统计学指标
*/
    int max_e = 0;    //最大值的元素
    int min_e = 0;    //最小值的元素
    int sum_e = 0;    //元素求和
    float mean_e = 0.0;    //均值的元素
    float median_e = 0.0;    //中位值的元素
    float S2 = 0.0;    //元素方差
    int arr_size = xsArrayGetSize(arr_id);
    if(arr_size == 1) {return (xsArrayGetInt(arr_id,0));}
    else {
        int temp_e = 0;    //缓存当前元素值
        //计算 sum_e 和 mean_e
        for(idx=0; <arr_size) {sum_e = sum_e + xsArrayGetInt(arr_id, idx);}
        mean_e = 1.0*sum_e/arr_size ;

             if(indicator=="sum") {return (sum_e);}
        else if(indicator=="max") 
        {
            max_e = xsArrayGetInt(arr_id, 0);
            for(idx=0; <arr_size) {
                temp_e = xsArrayGetInt(arr_id, idx);
                if(max_e < temp_e) {max_e = temp_e;}
            }
            return (max_e);
        }
        else if(indicator=="min") 
        {
            min_e = xsArrayGetInt(arr_id, 0);
            for(idx=0; <arr_size) {
                temp_e = xsArrayGetInt(arr_id, idx);
                if(min_e > temp_e) {min_e = temp_e;}
            }
            return (max_e);
        }
        else if(indicator=="mean") {return (mean_e);}
        else if(indicator=="median") 
        {
            if(arr_size%2 ==1) //数组中有奇数个元素，median_e 所在索引 Floor(arr_size/2)
            { median_e = xsArrayGetInt(arr_id, 1*(arr_size/2)); }
            else //数组中有偶数个元素，median_e 所在索引 arr_size/2-1
            {
                int me1 = xsArrayGetInt(arr_id, 1*(arr_size/2)-1);
                int me2 = xsArrayGetInt(arr_id, 1*(arr_size/2));
                median_e = 0.5*(me1+me2);
            }
            return (median_e);
        }
        else if(indicator=="S2") 
        {
             for(idx=0; <arr_size) 
            {
                temp_e = xsArrayGetInt(arr_id, idx);
                S2 = S2 + pow(temp_e-mean_e, 2);
            }
            S2 = 1.0/arr_size*S2 ;
            return (S2);
        }
    }
    return (-32767.0);
}

float FloatArrStatis(int arr_id=-1, string indicator="") 
{
/*
  统计浮点型数组的统计学指标：
  参数说明：
    arr_id: 
    indicator: 统计学指标。可能的情况有：
        max: 最大值
        min: 最小值
        sum: 求和
        mean: 均值
        median: 中位数
        S2: 方差
    返回值[float]: 返回指定的统计学指标
*/
    float max_e = 0;    //最大值的元素
    float min_e = 0;    //最小值的元素
    float sum_e = 0;    //元素求和
    float mean_e = 0.0;    //均值的元素
    float median_e = 0.0;    //中位值的元素
    float S2 = 0.0;    //元素方差
    int arr_size = xsArrayGetSize(arr_id);
    if(arr_size == 1) {return (xsArrayGetFloat(arr_id,0));}
    else {
        int temp_e = 0;    //缓存当前元素值
        //计算 sum_e 和 mean_e
        for(idx=0; <arr_size) {sum_e = sum_e + xsArrayGetFloat(arr_id, idx);}
        mean_e = 1.0*sum_e/arr_size ;

             if(indicator=="sum") {return (sum_e);}
        else if(indicator=="max") 
        {
            max_e = xsArrayGetFloat(arr_id, 0);
            for(idx=0; <arr_size) {
                temp_e = xsArrayGetFloat(arr_id, idx);
                if(max_e < temp_e) {max_e = temp_e;}
            }
            return (max_e);
        }
        else if(indicator=="min") 
        {
            min_e = xsArrayGetFloat(arr_id, 0);
            for(idx=0; <arr_size) {
                temp_e = xsArrayGetFloat(arr_id, idx);
                if(min_e > temp_e) {min_e = temp_e;}
            }
            return (max_e);
        }
        else if(indicator=="mean") {return (mean_e);}
        else if(indicator=="median") 
        {
            if(arr_size%2 ==1) //数组中有奇数个元素，median_e 所在索引 Floor(arr_size/2)
            { median_e = xsArrayGetFloat(arr_id, 1*(arr_size/2)); }
            else //数组中有偶数个元素，median_e 所在索引 arr_size/2-1 + arr_size/2
            {
                float me1 = xsArrayGetFloat(arr_id, 1*(arr_size/2)-1);
                float me2 = xsArrayGetFloat(arr_id, 1*(arr_size/2));
                median_e = 0.5*(me1+me2);
            }
            return (median_e);
        }
        else if(indicator=="S2") 
        {
             for(idx=0; <arr_size) 
            {
                temp_e = xsArrayGetFloat(arr_id, idx);
                S2 = S2 + pow(temp_e-mean_e, 2);
            }
            S2 = 1.0/arr_size*S2 ;
            return (S2);
        }
    }
    return (-32767.0);
}



int rev_arr_i = 0;
int IntArrReverse(int arr_id=-1, bool inplace=false) 
{
/* 反转int数组中的元素排列顺序：swap(arr[0],arr[len-1]), swap(arr[1],arr[len-2]) ...
    参数说明：
      arr_id: 数组ID
      dtype : 数组数据类型
      inplace: false
      return: int类型，返回数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    int e1 = 0; int e2 = 0;
    int idx1 = 0; int idx2 = arr_size-1;
    if(inplace == false) // 新建数组，存储反转后的数组元素
    {
        int rev_arr = xsArrayCreateInt(arr_size, 0, "rev_iarr"+rev_arr_i); rev_arr_i++;
        while(idx1 < idx2) {
            e1 = xsArrayGetInt(arr_id, idx1);
            e2 = xsArrayGetInt(arr_id, idx2);
            xsArraySetInt(rev_arr, idx1, e2);
            xsArraySetInt(rev_arr, idx2, e1);
            idx1++; idx2--; 
        }
        return (rev_arr);
    }
    else if(inplace == true) 
    {// 对原数组反转数组元素，就地更改
        while(idx1 < idx2) {
            e1 = xsArrayGetInt(arr_id, idx1);
            e2 = xsArrayGetInt(arr_id, idx2);
            xsArraySetInt(arr_id, idx1, e2);
            xsArraySetInt(arr_id, idx2, e1);
            idx1++; idx2--; 
        }
    }
    return (arr_id);
}

int FloatArrReverse(int arr_id=-1, bool inplace=false) 
{
/* 反转float数组中的元素排列顺序：swap(arr[0],arr[len-1]), swap(arr[1],arr[len-2]) ...
    参数说明：
      arr_id: 数组ID
      dtype : 数组数据类型
      inplace: false
      return: int类型，返回数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    float e1 = 0; float e2 = 0;
    int idx1 = 0; int idx2 = arr_size-1;
    if(inplace == false) // 新建数组，存储反转后的数组元素
    {
        int rev_arr = xsArrayCreateFloat(arr_size, 0.0, "rev_farr"+rev_arr_i); rev_arr_i++;
        while(idx1 < idx2) {
            e1 = xsArrayGetFloat(arr_id, idx1);
            e2 = xsArrayGetFloat(arr_id, idx2);
            xsArraySetFloat(rev_arr, idx1, e2);
            xsArraySetFloat(rev_arr, idx2, e1);
            idx1++; idx2--; 
        }
        return (rev_arr);
    }
    else if(inplace == true) 
    {// 对原数组反转数组元素，就地更改
        while(idx1 < idx2) {
            e1 = xsArrayGetFloat(arr_id, idx1);
            e2 = xsArrayGetFloat(arr_id, idx2);
            xsArraySetFloat(arr_id, idx1, e2);
            xsArraySetFloat(arr_id, idx2, e1);
            idx1++; idx2--; 
        }
    }
    return (arr_id);
}

mutable 
int IntArrBubbleSort(int arr_id=-1, string sort_way="ASC", bool inplace=false, int temp_arr_id=3) 
{
/* 对整型数组元素进行排序（冒泡排序法）
    参数说明：
        arr_id: 要排序的数组ID
        sort_way: 排序方式。可能的取值情况：{"ASC": 升序排列, "DESC": 降序排列}
        inplace: 是否在原数组上进行操作。false代表创建新数组存储排序后的数据，true表示在原数组上进行排序操作
        temp_arr_id: [Optional]，暂存数组的ID，默认值 3
        return：int类型，返回排序结果的数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    if(arr_size > 1) 
    {
        int e_swap1 = 0;
        int e_swap2 = 0;
        
        if(inplace == false) 
        {
            //暂存数组元素重置
            xsArrayResizeInt(temp_arr_id, arr_size);
            for(i_ = 0; < arr_size) {xsArraySetInt(temp_arr_id, i_, 0);}
            
            for(idx = 0; < arr_size) // copy(arr_id.data) -> temp_arr_id.data
            {xsArraySetInt(temp_arr_id, idx, xsArrayGetInt(arr_id, idx));}
            for(i = 0; < arr_size-1) // 排序轮数 = 元素个数 - 1
            {
                for(j=0; < arr_size-i-1) 
                {
                    if(
                        (sort_way == "ASC" ) && (xsArrayGetInt(temp_arr_id, j) > xsArrayGetInt(temp_arr_id, j+1)) ||
                        (sort_way == "DESC") && (xsArrayGetInt(temp_arr_id, j) < xsArrayGetInt(temp_arr_id, j+1)) 
                    ) 
                    {// 如果 temp_arr[j] > temp_arr[j+1]，则交换这2个元素的值
                        e_swap1 = xsArrayGetInt(temp_arr_id, j);
                        e_swap2 = xsArrayGetInt(temp_arr_id, j+1);
                        xsArraySetInt(temp_arr_id, j  , e_swap2);
                        xsArraySetInt(temp_arr_id, j+1, e_swap1);
                    }
                }
            }
            return (temp_arr_id);
        }
        else if(inplace == true) 
        {
            for(i = 0; < arr_size-1) // 排序轮数 = 元素个数 - 1
            {
                for(j=0; < arr_size-i-1) 
                {
                    if(
                        (sort_way == "ASC" ) && (xsArrayGetInt(arr_id, j) > xsArrayGetInt(arr_id, j+1)) ||
                        (sort_way == "DESC") && (xsArrayGetInt(arr_id, j) < xsArrayGetInt(arr_id, j+1)) 
                    ) 
                    {// 如果 arr[j] > arr[j+1]，则交换这2个元素的值
                        e_swap1 = xsArrayGetInt(arr_id, j);
                        e_swap2 = xsArrayGetInt(arr_id, j+1);
                        xsArraySetInt(arr_id, j  , e_swap2);
                        xsArraySetInt(arr_id, j+1, e_swap1);
                    }
                }
            }
            return (arr_id);
        }
        else {}
    }
    return (arr_id);
}

mutable 
int FloatArrBubbleSort(int arr_id=-1, string sort_way="ASC", bool inplace=false, int temp_arr_id=5) 
{
/* 对浮点型数组元素进行排序（冒泡排序法）
    参数说明：
        arr_id: 要排序的数组ID
        sort_way: 排序方式。可能的取值情况：{"ASC": 升序排列, "DESC": 降序排列}
        inplace: 是否在原数组上进行操作。false代表创建新数组存储排序后的数据，true表示在原数组上进行排序操作
        temp_arr_id: [Optional]，暂存数组的ID，默认值 5
        return：float类型，返回排序结果的数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    if(arr_size > 1) 
    {
        float e_swap1 = 0.0;
        float e_swap2 = 0.0;
        
        if(inplace == false) 
        {
            //暂存数组元素重置
            xsArrayResizeFloat(temp_arr_id, arr_size);
            for(i_ = 0; < arr_size) {xsArraySetFloat(temp_arr_id, i_, 0.0);}
            
            for(idx = 0; < arr_size) // copy(arr_id.data) -> temp_arr_id.data
            {xsArraySetFloat(temp_arr_id, idx, xsArrayGetFloat(arr_id, idx));}
            for(i = 0; < arr_size-1) // 排序轮数 = 元素个数 - 1
            {
                for(j=0; < arr_size-i-1) 
                {
                    if(
                        (sort_way == "ASC" ) && (xsArrayGetFloat(temp_arr_id, j) > xsArrayGetFloat(temp_arr_id, j+1)) ||
                        (sort_way == "DESC") && (xsArrayGetFloat(temp_arr_id, j) < xsArrayGetFloat(temp_arr_id, j+1)) 
                    ) 
                    {// 如果 temp_arr[j] > temp_arr[j+1]，则交换这2个元素的值
                        e_swap1 = xsArrayGetFloat(temp_arr_id, j);
                        e_swap2 = xsArrayGetFloat(temp_arr_id, j+1);
                        xsArraySetFloat(temp_arr_id, j  , e_swap2);
                        xsArraySetFloat(temp_arr_id, j+1, e_swap1);
                    }
                }
            }
            return (temp_arr_id);
        }
        else if(inplace == true) 
        {
            for(i = 0; < arr_size-1) // 排序轮数 = 元素个数 - 1
            {
                for(j=0; < arr_size-i-1) 
                {
                    if(
                        (sort_way == "ASC" ) && (xsArrayGetFloat(arr_id, j) > xsArrayGetFloat(arr_id, j+1)) ||
                        (sort_way == "DESC") && (xsArrayGetFloat(arr_id, j) < xsArrayGetFloat(arr_id, j+1)) 
                    ) 
                    {// 如果 arr[j] > arr[j+1]，则交换这2个元素的值
                        e_swap1 = xsArrayGetFloat(arr_id, j);
                        e_swap2 = xsArrayGetFloat(arr_id, j+1);
                        xsArraySetFloat(arr_id, j  , e_swap2);
                        xsArraySetFloat(arr_id, j+1, e_swap1);
                    }
                }
            }
            return (arr_id);
        }
        else {}
    }
    return (arr_id);
}

mutable 
int IntArrSelectSort(int arr_id=-1, string sort_way="ASC", bool inplace=false, int temp_arr_id=3) 
{
/* 对整型数组元素进行排序（选择排序法）
    参数说明：
        arr_id: 要排序的数组ID
        sort_way: 排序方式。可能的取值情况：{"ASC": 升序排列, "DESC": 降序排列}
        inplace: 是否在原数组上进行操作。false代表创建新数组存储排序后的数据，true表示在原数组上进行排序操作
        temp_arr_id: [Optional]，暂存数组的ID，默认值 3
        return：int类型，返回排序结果的数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    if(arr_size > 1) 
    {
        int e_swap1 = 0;
        int e_swap2 = 0;
        int min_idx = 0;
        
        if(inplace == false) 
        {
            //暂存数组元素重置
            xsArrayResizeInt(temp_arr_id, arr_size);
            for(i_ = 0; < arr_size) {xsArraySetInt(temp_arr_id, i_, 0);}
            
            for(idx = 0; < arr_size) // copy(arr_id.data) -> temp_arr_id.data
            {xsArraySetInt(temp_arr_id, idx, xsArrayGetInt(arr_id, idx));}
            for(i = 0; < arr_size) 
            {//寻找 [i, arr_size) 区间里的最小值
                min_idx = i;
                for(j=i+1; < arr_size) 
                {
                    // if (arr[j] < arr[min_idx])
                    if((sort_way == "ASC") && (xsArrayGetInt(temp_arr_id, j) < xsArrayGetInt(temp_arr_id, min_idx))) {min_idx = j;}
                    // if (arr[j] > arr[min_idx])
                    else if((sort_way == "DESC") && (xsArrayGetInt(temp_arr_id, j) > xsArrayGetInt(temp_arr_id, min_idx))) {min_idx = j;}
                }
                // 交换 arr[i] 和 arr[min_idx] 的元素值
                e_swap1 = xsArrayGetInt(temp_arr_id, i);
                e_swap2 = xsArrayGetInt(temp_arr_id, min_idx);
                xsArraySetInt(temp_arr_id, i, e_swap2);
                xsArraySetInt(temp_arr_id, min_idx, e_swap1);
            }
            return (temp_arr_id);
        }
        else if(inplace == true) 
        {
            for(i = 0; < arr_size) 
            {//寻找 [i, arr_size) 区间里的最小值
                min_idx = i;
                for(j=i+1; < arr_size) 
                {
                    // if (arr[j] < arr[min_idx])
                    if((sort_way == "ASC") && (xsArrayGetInt(arr_id, j) < xsArrayGetInt(arr_id, min_idx))) {min_idx = j;}
                    // if (arr[j] > arr[min_idx])
                    else if((sort_way == "DESC") && (xsArrayGetInt(arr_id, j) > xsArrayGetInt(arr_id, min_idx))) {min_idx = j;}
                    else {}
                }
                // 交换 arr[i] 和 arr[min_idx] 的元素值
                e_swap1 = xsArrayGetInt(arr_id, i);
                e_swap2 = xsArrayGetInt(arr_id, min_idx);
                xsArraySetInt(arr_id, i, e_swap2);
                xsArraySetInt(arr_id, min_idx, e_swap1);
            }
            return (arr_id);
        }
        else {}
    }
    return (arr_id);
}

mutable 
int FloatArrSelectSort(int arr_id=-1, string sort_way="ASC", bool inplace=false, int temp_arr_id=5) 
{
/* 对浮点型数组元素进行排序（选择排序法）
    参数说明：
        arr_id: 要排序的数组ID
        sort_way: 排序方式。可能的取值情况：{"ASC": 升序排列, "DESC": 降序排列}
        inplace: 是否在原数组上进行操作。false代表创建新数组存储排序后的数据，true表示在原数组上进行排序操作
        temp_arr_id: [Optional]，暂存数组的ID，默认值 5
        return：float类型，返回排序结果的数组ID
*/
    int arr_size = xsArrayGetSize(arr_id);
    if(arr_size > 1) 
    {
        float e_swap1 = 0.0;
        float e_swap2 = 0.0;
        int min_idx = 0;
        
        if(inplace == false) 
        {
            //暂存数组元素重置
            xsArrayResizeFloat(temp_arr_id, arr_size);
            for(i_ = 0; < arr_size) {xsArraySetFloat(temp_arr_id, i_, 0.0);}
            
            for(idx = 0; < arr_size) // copy(arr_id.data) -> temp_arr_id.data
            {xsArraySetFloat(temp_arr_id, idx, xsArrayGetFloat(arr_id, idx));}
            for(i = 0; < arr_size) 
            {//寻找 [i, arr_size) 区间里的最小值
                min_idx = i;
                for(j=i+1; < arr_size) 
                {
                    // if (arr[j] < arr[min_idx])
                    if((sort_way == "ASC") && (xsArrayGetFloat(temp_arr_id, j) < xsArrayGetFloat(temp_arr_id, min_idx))) {min_idx = j;}
                    // if (arr[j] > arr[min_idx])
                    else if((sort_way == "DESC") && (xsArrayGetFloat(temp_arr_id, j) > xsArrayGetFloat(temp_arr_id, min_idx))) {min_idx = j;}
                }
                // 交换 arr[i] 和 arr[min_idx] 的元素值
                e_swap1 = xsArrayGetFloat(temp_arr_id, i);
                e_swap2 = xsArrayGetFloat(temp_arr_id, min_idx);
                xsArraySetFloat(temp_arr_id, i, e_swap2);
                xsArraySetFloat(temp_arr_id, min_idx, e_swap1);
            }
            return (temp_arr_id);
        }
        else if(inplace == true) 
        {
            for(i = 0; < arr_size) 
            {//寻找 [i, arr_size) 区间里的最小值
                min_idx = i;
                for(j=i+1; < arr_size) 
                {
                    // if (arr[j] < arr[min_idx])
                    if((sort_way == "ASC") && (xsArrayGetFloat(arr_id, j) < xsArrayGetFloat(arr_id, min_idx))) {min_idx = j;}
                    // if (arr[j] > arr[min_idx])
                    else if((sort_way == "DESC") && (xsArrayGetFloat(arr_id, j) > xsArrayGetFloat(arr_id, min_idx))) {min_idx = j;}
                    else {}
                }
                // 交换 arr[i] 和 arr[min_idx] 的元素值
                e_swap1 = xsArrayGetFloat(arr_id, i);
                e_swap2 = xsArrayGetFloat(arr_id, min_idx);
                xsArraySetFloat(arr_id, i, e_swap2);
                xsArraySetFloat(arr_id, min_idx, e_swap1);
            }
            return (arr_id);
        }
        else {}
    }
    return (arr_id);
}


int sIntArr_i = 0;
int IntArrShuffle(int arr_id=-1, bool replace=true) 
{
/* 
    对给定Int型数组的元素进行乱序处理:
    参数说明：
      arr_id: 要进行元素乱序的数组ID
      replace: 是否要在原数组上进行乱序操作 {true: 对原数组操作, false: 创建新数组进行乱序}
*/
    int arr_size = xsArrayGetSize(arr_id);
    int new_arr = -1;
    if(replace) {new_arr = arr_id;} 
    else {//创建新数组new_arr，并将原数组数据拷贝到新数组
        new_arr = xsArrayCreateInt(arr_size, 0, "sIntArr_"+sIntArr_i); sIntArr_i++;
        for(i=0; <arr_size) {xsArraySetInt(new_arr, i, xsArrayGetInt(arr_id,i));}
    }
    int temp1 = 0;
    int temp2 = 0;
    for(i=arr_size; >0) {
        int idx = RandInt(0, i);  //在区间[0, i)上随机生成索引idx
        if(idx != i-1) {// 将idx处的元素与i-1位置的元素交换
            temp1 = xsArrayGetInt(new_arr, idx);
            temp2 = xsArrayGetInt(new_arr, i-1);
                    xsArraySetInt(new_arr, idx, temp2);
                    xsArraySetInt(new_arr, i-1, temp1);
        }
    }
    return (new_arr);
}

int sFloatArr_i = 0;
int FloatArrShuffle(int arr_id=-1, bool replace=true) 
{
/* 
    对给定Float型数组的元素进行乱序处理:
    参数说明：
      arr_id: 要进行元素乱序的数组ID
      replace: 是否要在原数组上进行乱序操作 {true: 对原数组操作, false: 创建新数组进行乱序}
*/
    int arr_size = xsArrayGetSize(arr_id);
    int new_arr = -1;
    if(replace) {new_arr = arr_id;}
    else {//创建新数组new_arr，并将原数组数据拷贝到新数组
        new_arr = xsArrayCreateFloat(arr_size, 0.0, "sFloatArr_"+sFloatArr_i); sFloatArr_i++;
        for(i=0; <arr_size) {xsArraySetFloat(new_arr, i, xsArrayGetFloat(arr_id,i));}
    }
    float temp1 = 0.0;
    float temp2 = 0.0;
    for(i=arr_size; >0) {
        int idx = RandInt(0, i);  //在区间[0, i)上随机生成索引idx
        if(idx != i-1) {// 将idx处的元素与i-1位置的元素交换
            temp1 = xsArrayGetFloat(new_arr, idx);
            temp2 = xsArrayGetFloat(new_arr, i-1);
                    xsArraySetFloat(new_arr, idx, temp2);
                    xsArraySetFloat(new_arr, i-1, temp1);
        }
    }
    return (new_arr);
}

int sStringArr_i = 0;
int StringArrShuffle(int arr_id=-1, bool replace=true) 
{
/* 
    对给定String型数组的元素进行乱序处理:
    参数说明：
      arr_id: 要进行元素乱序的数组ID
      replace: 是否要在原数组上进行乱序操作 {true: 对原数组操作, false: 创建新数组进行乱序}
*/
    int arr_size = xsArrayGetSize(arr_id);
    int new_arr = -1;
    if(replace) {new_arr = arr_id;}
    else {//创建新数组new_arr，并将原数组数据拷贝到新数组
        new_arr = xsArrayCreateString(arr_size, "", "sStringArr_"+sStringArr_i); sStringArr_i++;
        for(i=0; <arr_size) {xsArraySetString(new_arr, i, xsArrayGetString(arr_id,i));}
    }
    string temp1 = "";
    string temp2 = "";
    for(i=arr_size; >0) {
        int idx = RandInt(0, i);  //在区间[0, i)上随机生成索引idx
        if(idx != i-1) {// 将idx处的元素与i-1位置的元素交换
            temp1 = xsArrayGetString(new_arr, idx);
            temp2 = xsArrayGetString(new_arr, i-1);
                    xsArraySetString(new_arr, idx, temp2);
                    xsArraySetString(new_arr, i-1, temp1);
        }
    }
    return (new_arr);
}

int sVectorArr_i = 0;
int VectorArrShuffle(int arr_id=-1, bool replace=true) 
{
/* 
    对给定Vector型数组的元素进行乱序处理:
    参数说明：
      arr_id: 要进行元素乱序的数组ID
      replace: 是否要在原数组上进行乱序操作 {true: 对原数组操作, false: 创建新数组进行乱序}
*/
    int arr_size = xsArrayGetSize(arr_id);
    int new_arr = -1;
    if(replace) {new_arr = arr_id;}
    else {//创建新数组new_arr，并将原数组数据拷贝到新数组
        new_arr = xsArrayCreateVector(arr_size, cOriginVector, "sVectorArr_"+sVectorArr_i); sVectorArr_i++;
        for(i=0; <arr_size) {xsArraySetVector(new_arr, i, xsArrayGetVector(arr_id,i));}
    }
    vector temp1 = cOriginVector;
    vector temp2 = cOriginVector;
    for(i=arr_size; >0) {
        int idx = RandInt(0, i);  //在区间[0, i)上随机生成索引idx
        if(idx != i-1) {// 将idx处的元素与i-1位置的元素交换
            temp1 = xsArrayGetVector(new_arr, idx);
            temp2 = xsArrayGetVector(new_arr, i-1);
                    xsArraySetVector(new_arr, idx, temp2);
                    xsArraySetVector(new_arr, i-1, temp1);
        }
    }
    return (new_arr);
}

