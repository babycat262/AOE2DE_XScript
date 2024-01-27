
/* 
                            数组高级篇
    在基础篇中，我们学习了XS数组的创建，赋值和访问。在本部分，我们将学到一些关于Array的高级知识，大致包括以下几个部分：
    1. 一维数组的基本运算（数学运算，数组切片，数组尺寸伸缩，线性代数相关的数组运算）
    2. 二维伪数组及其构建（二维数组，也称为“矩阵”）
    3. 矩阵的基本操作（数学运算，矩阵与数组的相互转化，矩阵变形reshape，矩阵乘法，统计学相关的矩阵运算）
    4. 向量数组（vector in array）
    5. 数组和矩阵实用功能封装
    6. 数组和矩阵在机器学习中的运用和启发（**目前处于开发阶段，功能有待完善**）
    7. 数组和矩阵在 帝国2决定版 中的运用场景举例
    
*/
include "./array_tools.xs";    // 引入 array_tools 模块


/// 一维数组的基本运算 ///
//  创建一个浮点型数组 [-2.0, 1.0, 2.5, 4.0, 8.0]
int my_arr1 = -1;    // 数组ID
int arr1_size = 5;    // 数组长度

void arr1_init() 
{
    my_arr1 = xsArrayCreateFloat(arr1_size, 0.0, "my_arr1");
    xsArraySetFloat(my_arr1, 0,-2.0);
    xsArraySetFloat(my_arr1, 1, 1.0);
    xsArraySetFloat(my_arr1, 2, 2.5);
    xsArraySetFloat(my_arr1, 3, 4.0);
    xsArraySetFloat(my_arr1, 4, 8.0);
}
arr1_init();  // 调用该函数，进行数组的初始化，得到数组ID my_arr1

/* 
  1.数组元素的算术运算：加法（+），减法（-），乘法（*），除法（/）
    数组与数字的运算，实质是数组中每个元素分别与数字的算术运算。
    我们从引入的 "array_tools.xs" 模块中，调用相关的函数功能。
    
    原数组 my_arr1 = [-2.0, 1.0, 2.5, 4.0, 8.0]
*/
void iter_array(int arr_id=-1, string arr_name="") 
{// 该函数用于循历数组元素，并打印输出
    int arr_len = xsArrayGetSize(arr_id);
    if(arr_name == "") {arr_name = ""+arr_id;}
    int e = 0.0;
    for(i = 0; < arr_len) 
    {
        e = xsArrayGetFloat(arr_id, i);
        xsChatData("Array("+arr_name+")["+i+"] = " + e);
    }
}
my_arr1 = xsArrayAddNum(my_arr1, 2);  // 数组与 2 相加。运算结果：[ 0.0, 3.0, 4.5, 6.0, 10.0]
iter_array(my_arr1);
my_arr1 = xsArraySubNum(my_arr1, 4);  // 数组与 4 相减。运算结果：[-4.0,-1.0, 0.5, 2.0, 6.0]
iter_array(my_arr1);
my_arr1 = xsArrayMulNum(my_arr1, 3);  // 数组与 3 相乘。运算结果：[-12.0,-3.0, 1.5, 6.0, 18.0]
iter_array(my_arr1);
my_arr1 = xsArrayDivNum(my_arr1, 6);  // 数组被 6 除法。运算结果：[-2.0,-0.5, 0.25, 1.0, 3.0]
iter_array(my_arr1);


/* 
  2.数组切片操作
    从一个数组中取出其中一部分元素组成的片段，就是数组的切片。
    例如，对以下数组做切片：
        数组 [0, 2, 4, 6, 8, 10] 取出其中的片段 [4,6,8]，要将索引为 2 ~ 4 的元素取出，存放于切片中。
        注意：切片索引范围 [start_idx, end_idx) 是左闭右开区间，能取到起始索引的元素值，但取不到结束索引的元素值。
*/
// 存储数组ID和数组长度的变量
int my_arr2 = -1; 
int arr2_size = 6;
void arr2_init() 
{
    my_arr2 = xsArrayCreateInt(arr2_size, 0, "my_arr2");
    xsArraySetFloat(my_arr2, 0, 0);
    xsArraySetFloat(my_arr2, 1, 2);
    xsArraySetFloat(my_arr2, 2, 4);
    xsArraySetFloat(my_arr2, 3, 6);
    xsArraySetFloat(my_arr2, 4, 8);
    xsArraySetFloat(my_arr2, 5, 10);
}
arr2_init();  // my_arr2 = [0, 2, 4, 6, 8, 10]
// 取数组my_arr2的切片[4,6,8]，索引范围为 [2, 5)
int piece_arr = xsArrayPiece(my_arr2, 2, 5);
iter_array(my_arr2);  // 运算结果： [4, 6, 8]


/* 
  3.数组长度调整（Resize）
    将数组的长度（元素个数）可以通过resize操作，使其具有新的长度。
    例如：现在有记录联系人名称的数组（长度为3） my_contacts = ["Lisa", "John", "Smith"]，现在要新增联系人"David"，通常的做法是
        (1).扩充通讯录数组的长度
        (2).将新增联系人加入通讯录数组
*/
int my_contacts = -1;
void my_contacts_init() 
{// 通讯录数组初始化
    my_contacts = xsArrayCreateString(3, "", "my_contacts");
    xsArraySetString(my_contacts, 0, "Lisa");
    xsArraySetString(my_contacts, 1, "John");
    xsArraySetString(my_contacts, 2, "Smith");
}
my_contacts_init();
// 获取数组原来的长度
int old_size = xsArrayGetSize(my_contacts);
// 对数组 my_contacts 进行Resize操作，使其长度加 1，用以存储新联系人
int n = 1; _xsArrayResize(my_contacts, "string", n);
// 新的数组长度
int new_size = xsArrayGetSize(my_contacts);
// 把新增联系人加入数组，在索引 new_size-1（数组索引的最大值 = 数组长度-1） 处新增数据
xsArraySetString(my_contacts, new_size-1, "David");
iter_array(my_contacts);


/* 
  2.数组之间的运算
    2个或以上的数组之间数组，也能像数字那样进行加减乘除运算。数组之间进行运算，是对应位置的元素分别进行运算，得到结果数组
    【注意】：数组间算术运算的前提条件是，参与运算的数组的长度相等。
    设有2个数组 arr1 和 arr2，存在以下几种运算：
        加法：arr1 + arr2 = [arr1[0]+arr2[0], arr1[1]+arr2[1], ... , arr1[N-1]+arr2[N-1], arr1[N]+arr2[N]]
        减法：arr1 - arr2 = [arr1[0]-arr2[0], arr1[1]-arr2[1], ... , arr1[N-1]-arr2[N-1], arr1[N]-arr2[N]]
        乘法：arr1 * arr2 = [arr1[0]*arr2[0], arr1[1]*arr2[1], ... , arr1[N-1]*arr2[N-1], arr1[N]*arr2[N]] （要求arr2的数组元素均不为0）
        除法：arr1 / arr2 = [arr1[0]/arr2[0], arr1[1]/arr2[1], ... , arr1[N-1]+arr2[N-1], arr1[N]/arr2[N]]
*/
// 创建2个整型数组，并对其元素进行赋值
int my_arr3 = xsArrayCreateFloat(5, 0, "my_arr3");
int my_arr4 = xsArrayCreateFloat(5, 0, "my_arr4");
// 赋值（此处省略不再螯述，相应大家对数组赋值已经很熟悉了），结果如下：
// my_arr3 = [1, 2, 4, 8, 16]
// my_arr4 = [10, 8, 6, 4, 0]
// 数组加法
xsArraysAdd(my_arr3, my_arr4);  // [11, 10, 10, 12, 16]
// 数组元素乘法
xsArraysMul(my_arr3, my_arr4);  // [10, 16, 24, 32, 0]
/* 数组元素除法
    两数组中对应元素相除，且作为除数的数组不能有0值的元素。此处的my_arr4最后一个元素是0，因此运算结果异常ERROR.
    在XS中，计算出现异常时，往往并不会抛出异常信息，而是得到错误的结果，这显然不是我们想要的！因此在利用XS设计功能时，应当尽量避免出现这种情况
*/
// 16/0没有意义，函数对该对该情况进行了处理，返回提示信息：message: Can't divide by 0.
xsArraysDiv(my_arr3, my_arr4);  // 错误的结果，不会输出 [0, 0, 0, 2, 16/0]

/* 
    数组的点乘：数组之间的点乘，运算规则与线性代数中向量的乘法一样。
    dot_val = xsArraysDot(arr1, arr2);
    对上面的 my_arr3 和 my_arr4 数组，进行点乘：
*/
float dot_val = xsArraysDot(my_arr3, my_arr4);
xsChatData("arr1.dot(arr2) = " + dot_val);    // 82


/* 
    向量数组（vector in array）
    向量数组，顾名思意就是由向量（vector）组成的数组，即数组中的元素都是向量。
    提醒：这里提及的向量，是XS里的vector类型，并非上文说的 一维数组。
    向量数组中的向量与普通vector一样是3维，其中每个分量分别代表向量在 X轴、Y轴、Z轴上的投影。
    长度为m的向量数组，其形态如下：
        vec_arr = [V0, V1, ..., Vm-1] ，其中 V0 ... Vm 代表数组在索引 [0, Vm] 处的vector元素
    
    下面来看看，向量数组的创建，赋值，访问。
*/
/* 
    创建向量数组
    函数原型：
        int xsArrayCreateVector(int size, vector default_val, string arrayName);
    说明：
        1. size: 数组长度（元素个数）
        2. default_value: 创建数组时，元素的默认值
        3. arrayName: 数组名称，字符串类型，数组的唯一标识
        4. return: 返回值为int，表示数组的 ID
    
    在XS中有2个比较特殊的向量：
        cInvalidVector 是一个预定义的常值向量，它表示向量： (-1,-1,-1) 
        cOriginVector  是一个预定义的常值向量，它表示向量： ( 0, 0, 0)
        vector cOnesVector() {return (vector(1,1,1));}  // 该函数返回一个元素全为1的 vector
*/
// 创建一个长度为3的向量数组，，并给元素赋值，赋值后的数组形态为：  [(-1,-1,-1), (0,0,0), (1,1,1)]
int v_arr1 = -1;
void vector_array_init() 
{
    // 这些vector用于给向量数组的元素赋值
    vector v1 = vector(-1,-1,-1);    // 等价于向量 cInvalidVector
    vector v2 = vector(0, 0, 0);    // 等价于向量 cOriginVector
    vector v3 = vector(1, 1, 1);    // 该向量由"vector_tools.xs"模块的cOnesVector()函数实现
    // 创建向量数组，并初始化元素值为0
    v_arr1 = xsArrayCreateVector(3, cOriginVector, "v_arr1");
    // 给向量元素赋值
    xsArraySetVector(v_arr1, 0, v1);
    xsArraySetVector(v_arr1, 1, v2);
    xsArraySetVector(v_arr1, 2, v3);
}

void iter_vecArray(int arr_id=-1, string arr_name="") 
{// 遍历向量数组，打印输出其中的每个元素
    int arr_size = xsArrayGetSize(arr_id);
    if(arr_name == "") {arr_name = ""+arr_id;}
    vector v_ = cOriginVector;
    for(i = 0; < arr_size) 
    {
        v_ = xsArrayGetVector(arr_id, i);
        xsChatData("vec_arr("+arr_name+").X["+i+"] = " + xsVectorGetX(v_));
        xsChatData("vec_arr("+arr_name+").Y["+i+"] = " + xsVectorGetY(v_));
        xsChatData("vec_arr("+arr_name+").Z["+i+"] = " + xsVectorGetZ(v_));
    }
}
vector_array_init();  // 初始化向量数组
iter_vecArray(v_arr1, "v_arr1");  // 遍历向量数组中的元素，并打印输出


/// 二维伪数组（矩阵）及其构建 ///
/* 
    在之前的内容，我们学习了一维数组的基本运算。现在来看看由一维数组构建的二维伪数组。
    可能你也注意到了，这里说的二维数组，加了个“伪”字，这是因为XS中没有真正意义上的二维数组。二维伪数组是由一维数组根据其ID关联起来，并非像其他语言如 C/C++ 里那样，自带行索引和列索引。
    XS数组不支持像其他语言里二维数组的索引方式如： arr[1][0], arr[3, 3]。因此，想创建XS的二维数组，需要另寻他法。
    
    在介绍二维伪数组（后文称“矩阵”）之前，先简单介绍下 行索引，列索引，和 一维数组的方向性 的概念。
      num_arr1 = [1,2,3,4,5] 是一个整数元素组成的数组。长度5，索引范围 0 ~ 4。
      【注意】在线性代数中，通常将一维数组数组看作是列向量，即元素是自上而下纵向排列的。num_arr1的索引是行所引（自上而下有R个元素，代表R行）
      因此num_arr的形态该是：
                元素    索引（行标0~4）
                  1      0
                  2      1
      num_arr1 =  3      2        数组ID: 3
                  4      3
                  5      4
    假设有另外一个数组 num_arr2 = [10, 8, 6, 4, 2] 也表示列向量，它的形态如下：
                元素    索引（行标0~4）
                 10      0
                  8      1
      num_arr2 =  6      2        数组ID: 5
                  4      3
                  2      4
    这里 num_arr1 和 num_arr2 都表示列向量。如果将他们横向并排合在一起，是不是就成为5行2列的矩阵了呢？答案是肯定的！
    现在还有一个问题是，由一维数组构成的XS矩阵，它的列索引在哪里？
        解决方法是，用另一个数组（int类型，长度为列向量的个数。这个数组的索引，就表示矩阵的列索引），存储这2个列向量的ID编号，将这2个一维数组关联起来，构成二维伪数组。
    
    // 创建size=2的整型数组 mat_arr，存储列向量 num_arr1 和 num_arr2 的数组ID
    int mat_arr = xsArrayCreateInt(2, 0, "mat_arr");
    xsArraySetInt(mat_arr, 0, 3);  // num_arr1.ID : 3
    xsArraySetInt(mat_arr, 1, 5);  // num_arr2.ID : 5
    
    二维伪数组（矩阵）的形态：

    数组名称    num_arr1   num_arr2    mat_arr
    数组  ID       3          5           9

                   3          5      mat_arr中的元素：mat_arr[0] = num_arr1.ID    mat_arr[1] = num_arr2.ID
                   |          |
                   |          |
     索  引        0          1      列索引【列标，即数组 mat_arr 的索引】
                   ------------
       0           1         10
       1           2          8
行索引 2           3          6      数组 num_arr1 和 num_arr2 中的元素
       3           4          4
       4           5          2
                   ------------
    
    从上图不难看出，XS中，将一维数组关联起来的方法是创建一个新的数组，用于存储其他数组的ID编号。就可以进行矩阵元素的遍历了。
    现在，你知道“二维伪数组”的意思了吧。（为了方便记忆，避免混淆，以后都称之为矩阵。读者只要清楚，这里的二维伪数组，并不像C/C++语言里的二维数组那样的创建，赋值，访问）。
    下面来看一个例子。
*/
/*
  创建3个数组 hero_names, hero_hps, hero_damages .分别存放 英雄人物的3个属性，并将他们合并为矩阵 hero_mat
    英雄信息如下：（样本数5）
    name         HP      damage
    
    XiangYu      80      288.44
    LiZiCheng    96      250.10
    HanXin       65      327.75
    LiuBang     100      301.01
    
*/
int hero_names = -1;    // 名称  string
int hero_hps = -1;      // 生命值  int
int hero_damages = -1;  // 技能伤害  float
int hero_mat = -1;    // 存放hero人物属性数组ID的矩阵

int hero_amt = 4;    // 人物数量（样本数）
int hero_attr_amt = 3;    // 人物属性数量（特征数）

void hero_attrs_init() 
{// hero各项属性初始化和赋值
    hero_names = xsArrayCreateString(hero_amt, "", "hero_names");
    xsArraySetString(hero_names, 0, "XiangYu");
    xsArraySetString(hero_names, 1, "LiZiCheng");
    xsArraySetString(hero_names, 2, "HanXin");
    xsArraySetString(hero_names, 3, "LiuBang");
    
    hero_hps = xsArrayCreateInt(hero_amt, 0, "hero_hps");
    xsArraySetInt(hero_hps, 0, 80);
    xsArraySetInt(hero_hps, 1, 96);
    xsArraySetInt(hero_hps, 2, 65);
    xsArraySetInt(hero_hps, 3, 100);
    
    hero_damages = xsArrayCreateFloat(hero_amt, 0.0, "hero_damages");
    xsArraySetFloat(hero_damages, 0, 288.44);
    xsArraySetFloat(hero_damages, 1, 250.10);
    xsArraySetFloat(hero_damages, 2, 327.75);
    xsArraySetFloat(hero_damages, 3, 301.01);
    
    // 将这些表示人物特征的一维数组ID添加进 hero_mat，聚合成矩阵
    hero_mat = xsArrayCreateInt(hero_attr_amt, 0, "hero_mat");
    xsArraySetInt(hero_mat, 0, hero_names);
    xsArraySetInt(hero_mat, 1, hero_hps);
    xsArraySetInt(hero_mat, 2, hero_damages);
    
}
hero_attrs_init();  // 调用函数，就创建了英雄属性的矩阵

/* 
    访问矩阵中的元素
    由于XS的矩阵是由一维数组聚合而成，要访问矩阵中的元素，大致分为一下几个步骤：
    1. 遍历列索引，找到该索引对应的列数组的ID
    2. 根据列索引标识的ID，访问该ID表示的一维数组中的元素
    
    【矩阵的重要属性】：
        若矩阵 matrix 由C个一维数组聚合而成，每个一维数组的长度为 R
        
    矩阵列数： cols = xsArrayGetSize(matrix)
    矩阵行数： rows = xsArrayGetSize(xsArrayGetInt(matrix, 0))
              *说明：xsArrayGetInt(matrix, 0) 表示取出matrix矩阵中列索引 cidx=0 处对应的一维数组的ID，然后用xsArrayGetSize()求出该数组的长度，就是矩阵的行数
    矩阵元素总个数： mat_size = cols * rows
    
*/
// 遍历矩阵，输出所有英雄的各项基本属性
// 获取矩阵的列和行
int mat_cols = xsArrayGetSize(hero_mat);
int mat_rows = xsArrayGetSize(xsArrayGetInt(hero_mat, 0));
// 由于 hero_mat 矩阵中存储了不同类型的数组数据，进行元素遍历时，要将这些元素分别存储在对应类型的缓存变量中，方便处理。
// 遍历矩阵的完整实现如下：
void iter_hero_matrix(int mat_id=-1, string mat_name="") 
{
    // 获取矩阵的行和列
    int cols = xsArrayGetSize(mat_id);
    int rows = xsArrayGetSize(xsArrayGetInt(mat_id, 0));
    if(mat_name == "") {mat_name = ""+mat_id;}
    // 这些变量用于暂时存储 matrix 遍历过程中不同类型的元素值，将其打印输出
    int    ie_ = 0;
    float  fe_ = 0.0;
    string se_ = "";
    bool   be_ = false;
    
    int col_arr = -1;
    string arr_name = "";
    for(c = 0; < cols) {
        col_arr = xsArrayGetInt(mat_id, c);
        arr_name = xsArrayGetString(array_list, col_arr);
        // 数组管理列表array_list，用于管理创建数组时，ID和名称的对应关系。详情请见 "./array_tools.xs"
        for(r = 0; < rows) 
        {
            if(arr_name == "hero_names") 
            {
                se_ = xsArrayGetString(col_arr, r);
                xsChatData("Matrix("+mat_name+")["+r+","+c+"] = " + se_);
            }
            else if(arr_name == "hero_hps") 
            {
                ie_ = xsArrayGetInt(col_arr, r);
                xsChatData("Matrix("+mat_name+")["+r+","+c+"] = " + ie_);
            }
            else if(arr_name == "hero_damages") 
            {
                fe_ = xsArrayGetFloat(col_arr, r);
                xsChatData("Matrix("+mat_name+")["+r+","+c+"] = " + fe_);
            }
            else {}
            
        }
    }
}
// 调用函数，输出所有英雄的属性信息
iter_hero_matrix(hero_mat, "hero_attrs");
// 输出英雄"HanXin"的所有信息（索引为2的行向量）
int hx_attrs = xsArrayInMatrix(hero_mat, 2, -1);
iter_array(hx_attrs, "hero_attrs");
/* Output: 
    Array(hero_attrs)[2,0] = HanXin
    Array(hero_attrs)[2,1] = 65
    Array(hero_attrs)[2,2] = 327.75
*/

// 属性矩阵中，获取技能伤害hero_damages的最大值
hero_damages = xsArrayGetInt(hero_mat, 2);
float max_damage = xsArrayMax(hero_damages);    // 求数组最大值的函数
xsChatData("The max of `hero_damages` is: " + max_damage);  // 327.75
// 求矩阵中各英雄 生命值HP 的平均值
hero_hps = xsArrayGetInt(hero_mat, 1);
int mean_hp = xsArrayMean(hero_hps);    // 求数组均值的函数
xsChatData("The mean of `hero_hps` is: " + mean_hp);    // 85


/* 
    数组/矩阵 的变形操作（reshape）
    reshape操作是对数组或矩阵的形状进行调整，使得它们之间能够相互转化。
    原数据结构      操作        目标数据结构    原数据结构的元素个数    目标据结构的元素个数
      Array       reshape    ->    Matrix                x                   m*n [== x]
      Matrix      reshape    ->    Array                m*n                  x [== m*n]
    
    reshape操作的几个要点：
    1.reshape操作，默认将一维数组看作列向量。
    2.reshape操作后，生成的目标数据结构的元素个数，与原数据结构的元素个数相等。
    3.对一维数组进行reshape操作，可以看作是将一维数组的几个等长切片横向堆叠（切片是列向量）；对矩阵进行reshape操作，可以看作
      将矩阵展平成为一维的数组。
    4.在"array_tools.xs"模块中实现的 xsArrayToMatrix(int arr_id=-1, int row=-1, int col=-1) 函数，形参列标的赋值需要满足：
        row * col == array.size
      才能进行正确的变形。
    
*/
// 创建一个具有16个元素的正整数数组 my_arr5 = [1, 2, ... , 15, 16]
int my_arr5 = -1;
int arr5_size = 16;

my_arr5 = xsArrayCreateInt(arr5_size, 0, "nature16");
// 赋值：my_arr5 = [1, 2, ... , 15, 16]
for(i = 0; < arr5_size) {xsArraySetInt(my_arr5, i, i+);}
// 检查数组my_arr5元素个数（输出：The size of my_arr5: 16）
xsChatData("The size of my_arr5: " + xsArrayGetSize(my_arr5));

// 数组reshape操作：将数组reshape成一个4行*4列的矩阵，存储其ID
int res_mat1 = xsArrayToMatrix(my_arr5, 4, 4);
// 调用函数 xsMatrixDims()，查看结果矩阵的维度
xsMatrixDims(res_mat1, "nature16");  // 输出：The dimisions of Matrix(nature16): (4, 4) 
// 现在，将矩阵 res_mat1 展平还原为一维数组，长度为16
int res_arr1 = xsMatrixToArray(res_mat1);
// 检查结果数组元素个数（输出：The size of res_arr1: 16）
xsChatData("The size of res_arr1: " + xsArrayGetSize(res_arr1));
// 迭代 res_arr1，打印输出其中元素
iter_array(res_arr1);



/// 数组和矩阵一些实用功能的实现与封装 ///
/* 
    之前我们已经引入过 array_tools.xs 模块。该模块中的大部分函数功能，均由babycat实现。
    这些函数实现了数组和矩阵的一些基本操作，下面就对其进行分类介绍：
    【注意】：以下划线 _ 结尾的函数名（形如 funcName_() ），是对传入的数组或矩阵本身进行操作，函数执行之后，原对象发生改变 ！
    
    输出函数：
    printf()    // 基于内置函数xsChatData()的封装。新增快速设置文本颜色的功能（color_id参数）
    
    （一）数组操作函数
    1. 数组和数字的基本运算： +  -  *  /  %
    xsArrayAddNum()    // 数组与数字相加
    xsArraySubNum()    // 数组与数字相减
    xsArrayMulNum()    // 数组与数字相乘
    xsArrayDivNum()    // 数组与数字相除
    xsArrayModNum()    // 数组与数字取余
    
    2.数组间的基本运算： Add, Sub, Mul, Div, Dot, Product, Square
    xsArraysAdd()    // 2个数组的加法运算
    xsArraysSub()    // 2个数组的减法运算
    xsArraysMul()    // 2个数组的乘法运算
    xsArraysDiv()    // 2个数组的除法运算
    xsArraysDot()    // 2个数组的点乘运算（内积）
    xsArraysProduct()    // 2个数组的叉乘运算（外积）
    xsArrayPower()    // 数组元素的幂指运算
    
    3.数组切片
    xsArrayPiece()    // 返回数组在指定索引区间的 切片（数组的子数组）
    
    4.统计学相关
    xsArrayMax()    // 求数组元素的最大值
    xsArrayMin()    // 求数组元素的最小值
    xsArraySum()    // 数组元素求和
    xsArrayMean()    // 求数组元素的平均值
    xsArrayVariance()    // 求数组元素的方差
    
    5.数组尺寸&元素 操作
    xsArrayResize_()    // 数组尺寸伸缩
    xsArrayAppendInt_()    // 在整型数组末尾新增一个元素
    xsArrayAppendFloat_()    // 在浮点型数组末尾新增一个元素
    xsArrayAppendBool_()    // 在布尔数组末尾新增一个元素
    xsArrayAppendString_()    // 在字符串数组末尾新增一个元素
    xsArrayAppendVector_()    // 在向量数组末尾新增一个元素
    xsArrayClearInt_()    // 清空整型数组中的数据，并设置新的数组长度
    xsArrayClearFloat_()    // 清空浮点型数组中的数据，并设置新的数组长度
    xsArrayClearBool_()    // 清空布尔型数组中的数据，并设置新的数组长度
    xsArrayClearString_()    // 清空字符串数组中的数据，并设置新的数组长度
    xsArrayClearVector_()    // 清空向量数组中的数据，并设置新的数组长度
    
    6.排序与索引
    xsArraySortInt()    // 对整型数组元素进行排序（升序:"ASC"  降序:"DESC"）
    xsArraySortFloat()    // 对浮点型数组元素进行排序（升序:"ASC"  降序:"DESC"）
    xsArgSortInt()    // 对整型数组元素排序，得到其元素索引的 argsort
    xsArgSortFloat()    // 对浮点型数组元素排序，得到其元素索引的 argsort
    
    （二）矩阵操作函数
    1.矩阵和数组的相互转化，矩阵变形（reshape）
    xsMatrixToArray()    // 将矩阵变形为一维数组
    xsArrayToMatrix()    // 将一维数组变形为row行col列的矩阵
    xsMatrixReshape()    // 矩阵reshape操作
    xsMatrixElement()    // 获取矩阵中的1个元素
    xsMatrixDims()    // 获取矩阵的维度
    
    2.矩阵和数字的基本运算： +  -  *  /  %
    xsMatrixAddNum()    // 矩阵和数字相加
    xsMatrixSubNum()    // 矩阵和数字相减
    xsMatrixMulNum()    // 矩阵和数字相乘
    xsMatrixDivNum()    // 矩阵和数字相除
    xsMatrixModNum()    // 矩阵和数字取余
    
    3.线性代数相关的矩阵运算
    xsArrayInMatrix()    // 获取矩阵中特定行或列的数组
    xsMatrixDotArray()    // 矩阵与向量的乘法
    xsMatrixsDot()    // 矩阵与矩阵的乘法
    xsSubMatrix()    // 获取矩阵的子矩阵
    
    4.矩阵的聚合操作
    xsConcatMatrix()    // 将2个矩阵进行横向拼接，结果矩阵的列数是原先2个矩阵之和
    
 */
