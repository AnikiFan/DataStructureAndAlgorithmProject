#include "formatter.h"
#include<cmath>
#include<stdexcept>
#include<QDebug>
/// @brief 构造函数
/// @param sz 一维list中元素的个数
Formatter::Formatter(long long sz):size{sz}
{
    row = static_cast<long long>(log2(sz))+1;
    col = (1LL<<row)-1;
    //qDebug()<<std::to_string(size)<<"  "<<std::to_string(row)<<"  "<<std::to_string(col)<<"\n";
}


/// @brief 堆用二维数组表示所需的行数
/// @return 行数
long long Formatter::rowNum() const
{
    return row;
}

/// @brief 堆用二维数组表示所需的列数
/// @return 列数
long long Formatter::colNum() const
{
    return col;
}

/// @brief 给定二维数组中的位置，判断其在一维list中对应的位置
/// @param row
/// @param col
/// @return
long long Formatter::transform(long long r, long long c)const
{
    if(r<0||r>=row||c<0||c>=col){throw std::invalid_argument("Formatter::transform");}
    r = row-r;//转化为从左下角开始，并且下标从1开始
    c = c + 1;
    //qDebug()<<"r:"<<r<<"    c:"<<std::to_string(c)<<"    (c&-c)&(1LL<<(r-1)):"<<std::to_string((c&-c)&(1LL<<(r-1)))<<"   (1<<(row-r))+(c>>r)"<<std::to_string((1<<(row-r))+(c>>r))<<"\n";
    if(!((c&-c)&(1LL<<(r-1)))||(1<<(row-r))+(c>>r)>size){return null;}
    return (1<<(row-r))+(c>>r)-1;
    //判断c的第一个非0位是否是第r位
    //c&-c：提取出最低非0位；1LL<<(r-1)第r位为1的数
    //c>>r：所在行中排在第几位，从0开始
    //从上往下在第row-r层，从1开始
}

void Formatter::transform(long long i,long long&r,long long&c)const
{
    if(i<0||i>=size){throw std::invalid_argument("Formatter:transform");}
    r = -1;
    long long tmp{i};
    for(tmp++;tmp;tmp>>=1){r++;}
    //第i+1个元素，从1开始
    //在第r行，从0开始
    //在其上方，有r行完整的，共2^{r}-1个元素
    //在同一行，有(i+1)-(2^{r}-1)个元素
    //第一个元素位于1<<(row-r-1)列，从1开始
    //后续元素列数增加值为1<<(row-r)
    c = (1<<(row-r-1))+(i-(1<<r)+1)*(1<<(row-r))-1;

    //qDebug()<<"i:"<<i<<"   "<<"r:"<<r<<"    "<<"c:"<<c<<"\n";
    //qDebug()<<"(1<<(row-r-1)):"<<(1<<(row-r-1))<<"    (i-(1<<r)+1):"<<(i-(1<<r)+1)<<"       (1<<(row-r)):"<<(1<<(row-r))<<"\n";
    return;
}

void Formatter::update(long long sz)
{
    size = sz;
    row = static_cast<long long>(log2(sz))+1;
    col = (1LL<<row)-1;
    return;
}
