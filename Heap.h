#ifndef HEAP_H
#define HEAP_H
#include"Vector.h"
// #include<iostream>
// using namespace std;
/// @brief 专门用于堆排序的堆
/// @tparam T
template<typename T>
class Heap:public Vector<T>
{
public:
    Heap(const Vector<T>&base,bool (*cmp)(const T&,const T&));
    ~Heap();
    /// @brief 标记是否已排序
    bool sorted=false;
    virtual void sort();
protected:
    virtual void shrink() ;
    /// @brief 用于代表空节点
    const long long null=-1LL;
    bool (*cmp)(const T&,const T&);
    long long lchild(long long i)const;
    long long rchild(long long i)const;
    /// @brief 堆的大小（elem[0]也是一个元素，没有设置哨兵）
    long long heapsz;
    virtual void maintain(long long i);
    virtual void build();
};

/// @brief 构造函数
/// @tparam T
/// @param base 用于提供构成堆的元素
/// @param compare 自定义比较函数,compare(A,B)返回true说明A，B位置不变，否则互换，默认是小于，最终从左到右升序
template <typename T>
inline Heap<T>::Heap(const Vector<T>& base,bool (*compare)(const T &, const T &))
    :Vector<T>(base.length()),cmp(compare)
{
    for(auto &x:base){Vector<T>::push_back(x);}
    heapsz = base.length();
}

/// @brief 析构函数
/// @tparam T
template <typename T>
inline Heap<T>::~Heap()
{
}

/// @brief 堆排序
/// @tparam T
template <typename T>
inline void Heap<T>::shrink()
{
    if(!heapsz){throw std::underflow_error("Heap::shrink");}
    heapsz --;
    this->swap(0,heapsz);
    return;
}

/// @brief 堆排序
/// @tparam T
template <typename T>
inline void Heap<T>::sort()
{
    if(sorted){return;}
    build();
    while(heapsz){
        // cout<<"heapsize:"<<heapsz<<endl;
        shrink();
        if(heapsz){maintain(0);};
    }
    sorted=true;
    return;
}

/// @brief 返回指定下标对应的左孩子的下标
/// @tparam T
/// @param i 指定下标
/// @return 指定下标对应的左孩子的下标
template <typename T>
inline long long Heap<T>::lchild(long long i)const
{
    return 2*i+1<heapsz?2*i+1:null;
}

/// @brief 返回指定下标对应的右孩子的下标
/// @tparam T
/// @param i 指定下标
/// @return 指定下标对应的右孩子的下标
template <typename T>
inline long long Heap<T>::rchild(long long i)const
{
    return 2*i+2<heapsz?2*i+2:null;
}

/// @brief 维护指定下标处的堆性质，并递归
/// @tparam T
/// @param i
template <typename T>
inline void Heap<T>::maintain(long long i)
{
    // cout<<"maintian("<<i<<")"<<endl;
    if(i<0||i>=heapsz){throw std::invalid_argument("Heap::maintian");};
    while(lchild(i)!=null||rchild(i)!=null){
        // cout<<i<<endl;
        // cout<<lchild(i)<<" "<<rchild(i)<<endl;
        if(rchild(i)==null){
            if(cmp(Vector<T>::elem[i],Vector<T>::elem[lchild(i)])){
                // cout<<"case 1"<<endl;
                this->swap(i,lchild(i));
                i = lchild(i);
                continue;
            }
        }else if(lchild(i)==null){
            if(cmp(Vector<T>::elem[i],Vector<T>::elem[rchild(i)])){
                // cout<<"case 2"<<endl;
                this->swap(i,rchild(i));
                i = rchild(i);
                continue;
            }
        }else{
            if(cmp(Vector<T>::elem[i],Vector<T>::elem[lchild(i)])&&
                cmp(Vector<T>::elem[rchild(i)],Vector<T>::elem[lchild(i)])){
                // cout<<"case 3"<<endl;
                this->swap(i,lchild(i));
                i = lchild(i);
                continue;
            }
            if(cmp(Vector<T>::elem[i],Vector<T>::elem[rchild(i)])
                &&cmp(Vector<T>::elem[lchild(i)],Vector<T>::elem[rchild(i)])){
                // cout<<"case 4"<<endl;
                this->swap(i,rchild(i));
                i = rchild(i);
                continue;
            }
        }
        break;
    }
    return;
}

/// @brief 建堆
/// @tparam T
template <typename T>
inline void Heap<T>::build()
{
    for(long long i = heapsz/2-1;i>=0;--i){maintain(i);}
    return;
}
#endif // HEAP_H
