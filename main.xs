// 数组管理列表 array_list ：ID编号为0的数组。该列表用于管理场景中创建的数组ID和数组名称
int array_list = 0;
mutable 
int xsCreateArray(string dtype="float", string arr_name="", int arr_size=1) 
{// 创建数组，将数组名称加入管理列表
    if(arr_size <= 0) {xsChatData("Array.size must greater than 0."); return (-32768);}
    int arr_id = -1;
         if(dtype == "int") {arr_id = xsArrayCreateInt(arr_size, 0, arr_name);}
    else if(dtype == "float") {arr_id = xsArrayCreateFloat(arr_size, 0.0, arr_name);}
    else if(dtype == "bool") {arr_id = xsArrayCreateBool(arr_size, false, arr_name);}
    else if(dtype == "string") {arr_id = xsArrayCreateString(arr_size, "", arr_name);}
    else if(dtype == "vector") {arr_id = xsArrayCreateVector(arr_size, cOriginVector, arr_name);}
    else {xsChatData("Create array failed, invalid data type."); return (-32768);}
    // 将创建数组的 ID 和名称，添加进数组管理列表 array_list
    int list_size = xsArrayGetSize(array_list);
    // 当array_list的size小于新增数组ID+1时，扩充数组管理列表的长度
    if(list_size < arr_id+1) {xsArrayResizeString(array_list, list_size+1);}
    // 若arr_id 的数组未注册进 array_list，则进行注册操作
    if(xsArrayGetString(array_list, arr_id) == "") 
    {xsArraySetString(array_list, arr_id, arr_name);
    //xsChatData("Register array successed.");
    }
    else {xsChatData("Register array failed, the array already exists."); return (-32768);}
    return (arr_id);
}

int xs_arr01 = -1;  int xs_arr02 = -1;
int xs_arr03 = -1;  int xs_arr04 = -1;
int xs_arr05 = -1;  int xs_arr06 = -1;
int xs_arr07 = -1;  int xs_arr08 = -1;
int xs_arr09 = -1;  int xs_arr10 = -1;
void __xsPreDefinedArrays(int init_size=1) 
{
/*
    array_list : 数组管理列表，记录游戏中创建的数组ID及名称
    xs_arr01 ~ xs_arr10 : __xsPreDefinedArrays 函数创建的10个预留数组
    这些ID指向的数组，用于缓存某些操作的中间结果
*/
    array_list = xsArrayCreateString(1, "ArrayNames", "array_list");
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



void main() {
    __xsPreDefinedArrays();    //创建预留数组
}

