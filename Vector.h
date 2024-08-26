#ifndef VECTOR_H
#define VECTOR_H
#include <stdexcept>
template <typename T>
class Heap;
/// @brief Vector类实现
/// @tparam T
template <typename T>
class Vector
{
public:
    Vector();
    explicit Vector(long long s);
    Vector(std::initializer_list<T> initList);
    Vector(const Vector<T> &);
    Vector(T *, T *);
    Vector(T *, const long long);
    ~Vector();
    T &operator[](long long i);
    const T &operator[](long long i) const;
    long long length() const;
    void push_back(const T &value);
    virtual void swap(long long x, long long y);
    void empty();
    T *begin() const;
    T *end() const;
    void sort(T *, T *, bool (*cmp)(const T &, const T &));

protected:
    /// @brief 指向元素指针
    T *elem;
    /// @brief 已存储的元素个数
    long long len;
    /// @brief 已分配的个数
    long long sz;
    long long size() const;
    void extend();
};
#include "Heap.h"

/// @brief begin
/// @tparam T
/// @param x
/// @return 返回指向首元素的指针
template <typename T>
T *begin(Vector<T> &x)
{
    return x.length() ? &x[0] : nullptr;
}

/// @brief end
/// @tparam T
/// @param x
/// @return 返回末尾元素的指针
template <typename T>
T *end(Vector<T> &x)
{
    return x.length() ? &x[0] + x.length() : nullptr;
}

/// @brief begin const版本
/// @tparam T
/// @param x
/// @return 返回指向首元素的指针
template <typename T>
const T *begin(const Vector<T> &x)
{
    return x.length() ? &x[0] : nullptr;
}

/// @brief end const 版本
/// @tparam T
/// @param x
/// @return 返回末尾元素的指针
template <typename T>
const T *end(const Vector<T> &x)
{
    return x.length() ? &x[0] + x.length() : nullptr;
}

/// @brief 构造函数，指定初始时的申请的个数
/// @tparam T
/// @param s 个数，应非负
template<typename T>
inline Vector<T>::Vector()
{
    elem = nullptr;
    len = 0;
    sz = 0;
}

template <typename T>
inline Vector<T>::Vector(long long s)
{
    if (s < 0)
    {
        throw std::invalid_argument("Vector::Vector");
    }
    if(!s){
        elem = nullptr;
        len = 0;
        sz = 0;
        return;
    }
    elem = new T[s];
    if (!elem)
    {
        throw std::overflow_error("Vector::Vector");
    }
    len = 0;
    sz = s;
}

/// @brief 列表初始化方式
/// @tparam T
/// @param initList
template <typename T>
inline Vector<T>::Vector(std::initializer_list<T> initList)
{
    if (!initList.size())
    {
        len = 0;
        sz = 0;
        elem = nullptr;
        return;
    }
    elem = new T[initList.size()];
    if (!elem)
    {
        throw std::overflow_error("Vector::Vector");
    }
    len = 0;
    sz = static_cast<long long>(initList.size());
    for (auto &x : initList)
    {
        push_back(x);
    }
}

template <typename T>
inline Vector<T>::Vector(const Vector<T> &origin)
{
    if (!origin.size())
    {
        sz = 0;
        len = 0;
        elem = nullptr;
        return;
    }
    elem = new T[origin.size()];
    if (!elem)
    {
        throw std::overflow_error("Vector::Vector");
    }
    len = 0;
    sz = origin.size();
    for (auto &x : origin)
    {
        push_back(x);
    }
}

template <typename T>
inline Vector<T>::Vector(T *begin, T *end)
{
    if (end - begin < 0)
    {
        throw std::invalid_argument("Vector::Vector");
    }
    len = end - begin;
    sz = end - begin;
    if (!sz)
    {
        elem = nullptr;
        return;
    }
    elem = new T[sz];
    if (!elem)
    {
        throw std::overflow_error("Vector::Vector");
    }
    for (long long i{0}; i < len; i++)
    {
        elem[i] = *(begin + i);
    }
}

template <typename T>
inline Vector<T>::Vector(T *base, const long long length)
{
    elem = base;
    sz = length;
    len = length;
}

/// @brief 析构函数
/// @tparam T
template <typename T>
inline Vector<T>::~Vector()
{
    delete[] elem;
}

/// @brief 重载[]，用于非const的Vector
/// @tparam T
/// @param i
/// @return *(elem+i)
template <typename T>
inline T &Vector<T>::operator[](long long i)
{
    if (i < 0 || length() <= i)
    {
        throw std::out_of_range("Vector::operator[]");
    }
    return elem[i];
}

/// @brief 重载[]，用于const的Vector
/// @tparam T
/// @param i
/// @return *(elem+i)
template <typename T>
inline const T &Vector<T>::operator[](long long i) const
{
    if (i < 0 || length() <= i)
    {
        throw std::out_of_range("Vector::operator[]");
    }
    return elem[i];
}

/// @brief len接口
/// @tparam T
/// @return 返回已有元素个数
template <typename T>
inline long long Vector<T>::length() const
{
    return len;
}

/// @brief 在末尾添加元素
/// @tparam T
/// @param value 待添加元素
template <typename T>
inline void Vector<T>::push_back(const T &value)
{
    if (size() == length())
    {
        extend();
    }
    elem[len++] = value;
    return;
}

/// @brief 互换x和y处的元素
/// @tparam T
/// @param x
/// @param y
template <typename T>
inline void Vector<T>::swap(long long x, long long y)
{
    if (x < 0 || length() <= x)
    {
        throw std::out_of_range("Vector::swap");
    }
    if (y < 0 || length() <= y)
    {
        throw std::out_of_range("Vector::swap");
    }
    if (x == y)
    {
        return;
    }
    T tmp{std::move(elem[x])};
    elem[x] = std::move(elem[y]);
    elem[y] = std::move(tmp);
    return;
}

template <typename T>
inline void Vector<T>::empty()
{
    delete[] elem;
    elem = nullptr;
    sz = 0;
    len = 0;
    return;
}

template <typename T>
inline T *Vector<T>::begin() const
{
    return len ? elem : nullptr;
}

template <typename T>
inline T *Vector<T>::end() const
{
    return len ? elem + len : nullptr;
}

template <typename T>
inline void Vector<T>::sort(T *beg, T *ed, bool (*cmp)(const T &, const T &))
{
    if (beg - begin() < 0 || ed - end() > 0)
    {
        throw std::invalid_argument("Vector::sort");
    }
    if (beg == ed)
    {
        return;
    }
    Heap<T> H{beg, ed, cmp};
    H.sort();
    for (long long i{0}; i < ed - beg; i++)
    {
        *(beg + i) = H[i];
    }
    return;
}

/// @brief sz接口
/// @tparam T
/// @return 返回已申请个数
template <typename T>
inline long long Vector<T>::size() const
{
    return sz;
}

/// @brief 扩容，扩容至原先的两倍
/// @tparam T
template <typename T>
inline void Vector<T>::extend()
{
    sz = (size() == 0) ? 1 : 2 * size();
    T *tmp = new T[sz];
    if (!tmp)
    {
        throw std::overflow_error("Vector::extend");
    }
    for (long long i = 0; i < length(); ++i)
    {
        tmp[i] = std::move(elem[i]);
    }
    delete[] elem;
    elem = tmp;
    return;
}
#endif // VECTOR_H
