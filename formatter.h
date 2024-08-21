#ifndef FORMATTER_H
#define FORMATTER_H
/// @brief 用于处理可视化堆时在一维list与二维table之间的下标转换，都从0开始
class Formatter
{
public:
    Formatter(long long sz);
    long long rowNum()const;
    long long colNum()const;
    long long transform(long long row,long long col)const;
    void transform(long long i,long long &r,long long&c)const;
    /// @brief 表示该位置没有对应的一维list中的元素
    const long long null = -1LL;
    void update(long long sz);
private:
    /// @brief 一维list的元素个数
    long long size;
    /// @brief 对应二维table的行数
    long long row;
    /// @brief 对应二维table的列数
    long long col;
};

#endif // FORMATTER_H
