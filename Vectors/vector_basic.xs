
/* 
    向量 vector
    向量，在几何上是指一条有方向的线段，在空间左坐标系中，向量可以在每个轴上投影，得到其分量(x,y,z)
    在生活中，向量描述了样本在不同维度上的特征。如人的 身高，肤色，性别，就表示人的3个特征，这些特征的值因人而异（样本间存在差异）

    在 AOE2 XS 中，向量的维度是固定的3维，其每个分量，能够描述单位的1个属性；也可以表示unit碰撞体积的 长，宽，高
    向量vector 的基本形态： (1, 2, 3) 是一个向量。该向量有3个维度，其在每个维度上的分量值分别为 1, 2, 3
    
    在XS中有2个比较特殊的向量：
        cInvalidVector 是一个XS预定义的常值向量，它表示向量： (-1, -1, -1) 
        cOriginVector 是一个XS预定义的常值向量，它表示向量：  (0, 0, 0)

*/

/// 创建向量，向量分量赋值与访问向量分量 的基本语法
float x = 1.1;
float y = 2.2;
float z = 3.3;

// 创建向量 (1,2,3)
vector v = vector(1, 2, 3);    // 正确创建方式
// vector v1 = vector(x, y, z);    // 错误创建方式

// 创建一个默认值为0的 vector 
vector v1 = cOriginVector;    // (0, 0, 0)
// 给向量中的元素赋值
v1 = xsVectorSetX(v1, x);    // 设置 X 分量的值
v1 = xsVectorSetY(v1, y);    // 设置 Y 分量的值
v1 = xsVectorSetZ(v1, z);    // 设置 Z 分量的值
// 同时设置向量中各个分量的值
v1 = xsVectorSet(x, y, z);

// 访问向量中各个分量的值
float x1 = xsVectorGetX(v1); // 获得 X 分量
float y1 = xsVectorGetY(v1); // 获得 Y 分量
float z1 = xsVectorGetZ(v1); // 获得 Z 分量
xsChatData("X component of vector v1: " + x1);
xsChatData("Y component of vector v1: " + y1);
xsChatData("Z component of vector v1: " + z1);
// 获取向量的长度（元素个数）
float v_length = xsVectorLength(v1);
xsChatData("the features of vector v1 is: " + v_length);


// 向量使用实例
// 已知长方体的长宽高分别为a = 8.0, b = 5.0, c = 7.5。实现函数 block_feature() 求该长方体的 周长，表面积，体积

// 分析：该函数要实现接收长方体的长宽高，求立方体的3个属性，并将结果返回，其返回值类型应是 vector
vector block_attrs(float L=0.0, float W=0.0, float H=0.0) 
{
    //周长： C = 4*(L + W + H)
    float C = 4*(L + W + H);
    //表面积： S = 2*(L*W + L*H + W*H)
    float S = 2*(L*W + L*H + W*H);
    //体积： V = L*W*H
    float V = L*W*H ;
    // 创建向量，存储长方体的3个属性，并返回结果
    vector v = xsVectorSet(C, S, V);
    return (v);
}

void main() 
{
    float a = 8.0; 
    float b = 5.0; 
    float c = 7.5;
    vector bv = block_attrs(a, b, c);
    // 打印输出长方体的各项属性
    xsChatData("this block's C = " + xsVectorGetX(bv));  //  82
    xsChatData("this block's S = " + xsVectorGetY(bv));  // 275
    xsChatData("this block's V = " + xsVectorGetZ(bv));  // 300
}
