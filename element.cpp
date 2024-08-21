#include "element.h"

/// @brief 堆中元素
/// @param val 键值
Element::Element(long long val,State st)
    :value{val},state{st}
{

}


Element::Element():value{0},state{Invalid}
{

}

Element::Element(const Element &other)
    :value{other.value},state{other.state}
{

}

Element &Element::operator=(const Element &other)
{
    if (this != &other) {
        this->value = other.value;
        this->state = other.state;
    }
    return *this;
}

/// @brief 析构函数
Element::~Element()
{

}
