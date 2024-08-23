#ifndef GRAPH_H
#define GRAPH_H
#include"Array.h"
#include"Vector.h"
#include<stdexcept>
/// @brief 简单图，即不允许有环和重边！
/// @tparam T
template <typename T>
class MyGraph
{
public:
    MyGraph();
    ~MyGraph();
    void addNode(const T&);
    void deleteNode(const long long);
    void addEdge(const long long,const long long);
    void deleteEdge(const long long ,const long long);
    long long VertexCnt();
    long long EdgeCnt();
private:
    Vector<T> V;
    Vector<Array<long long >> E;
    Vector<int> Active;
    long long VNum;
    long long ENum;
};

template <typename T>
inline MyGraph<T>::MyGraph()
    :VNum{0},ENum{0}
{
}

template <typename T>
inline MyGraph<T>::~MyGraph()
{

}

template <typename T>
inline void MyGraph<T>::addNode(const T& value)
{
    V.push_back(value);
    E.push_back(Array<long long>());
    Active.push_back(1);
    VNum++;
}

template <typename T>
inline void MyGraph<T>::deleteNode(const long long i)
{
    if(i<0||i>V.length()||!Active[i]){throw std::invalid_argument("Graph::deleteNode");}
    Active[i] = 0;
    VNum--;
    ENum -= E[i].length();
    Node<long long>*p{E[i].getHead()};
    while(p) {
        E[p->getValue()].remove(i,[](const long long & x,const long long &y){return x==y;});
        p = p->getNext();
    }
    E[i].destroy();
    return;
}

template <typename T>
inline void MyGraph<T>::addEdge(const long long i, const long long j)
{
    if(i==j||i<0||i>=V.length()||!Active[i]||j<0||j>=V.length()||!Active[j]){throw std::invalid_argument("Graph::addEdge");}
    ENum ++;
    E[i].insert(j);//这里并没有检测是否已经存在边
    E[j].insert(i);
    return;
}

template <typename T>
inline void MyGraph<T>::deleteEdge(const long long i, const long long j)
{
    if(i==j||i<0||i>=V.length()||!Active[i]||j<0||j>=V.length()||!Active[j]){throw std::invalid_argument("Graph::deleteEdge");}
    if(E[i].remove(j,[](const long long &x,const long long &y){return x==y;})&&E[j].remove(i,[](const long long &x,const long long &y){return x==y;})){ENum--;}
    return;
}

template <typename T>
inline long long MyGraph<T>::VertexCnt()
{
    return VNum;
}

template <typename T>
inline long long MyGraph<T>::EdgeCnt()
{
    return ENum;
}
#endif // GRAPH_H
