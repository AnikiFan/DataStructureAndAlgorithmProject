#ifndef ELEMENT_H
#define ELEMENT_H
#include <QObject>
/// @brief 堆中的元素，用于可视化
class Element
{
    Q_GADGET
public:
    Element();
    Element(const Element& other);
    Element& operator=(const Element& other) ;
    ~Element();
    /// @brief 位序是否已经确定
    /// @brief 用于比较的键值
    long long value;
    /// @brief 仍需确定位序、已确定、非法位置
    enum State{
        Active = 0,
        Inactive,
        Invalid,
        Changing
    };
    State state;
    Element(long long val,State st=Active);
    Q_ENUM(State)
};

#endif // ELEMENT_H
