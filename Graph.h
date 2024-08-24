#ifndef GRAPH_H
#define GRAPH_H
#include "Array.h"
#include "Vector.h"
#include <stdexcept>
/// @brief 简单图，即不允许有环和重边！
/// @tparam T1,T2
template <typename T1, typename T2>
class WeightedGraph
{
public:
    WeightedGraph();
    ~WeightedGraph();
    void addNode(const T1 &);
    void deleteNode(const long long);
    void addEdge(const long long, const long long, const T2 &);
    void deleteEdge(const long long, const long long);
    long long VertexCnt();
    long long EdgeCnt();
    T1 getValue(const long long);
    bool valid(const long long);
private:
    Vector<T1> V;
    Vector<Array<long long>> E;
    Vector<Array<T2>> W;
    Vector<int> Active;
    long long VNum;
    long long ENum;
};

template <typename T1, typename T2>
inline WeightedGraph<T1, T2>::WeightedGraph()
    : VNum{0}, ENum{0}
{
}

template <typename T1, typename T2>
inline WeightedGraph<T1, T2>::~WeightedGraph()
{
}

template <typename T1, typename T2>
inline void WeightedGraph<T1, T2>::addNode(const T1 &value)
{
    V.push_back(value);
    E.push_back(Array<long long>());
    W.push_back(Array<T2>());
    Active.push_back(1);
    VNum++;
}

template <typename T1, typename T2>
inline void WeightedGraph<T1, T2>::deleteNode(const long long i)
{
    if (i < 0 || i > V.length() || !Active[i])
    {
        throw std::invalid_argument("Graph::deleteNode");
    }
    Active[i] = 0;
    VNum--;
    ENum -= E[i].length();
    Node<long long> *p{E[i].getHead()};
    while (p)
    {
        long long no{E[p->getValue()].find(i)};
        E[p->getValue()].remove(no);
        W[p->getValue()].remove(no);
        p = p->getNext();
    }
    E[i].destroy();
    return;
}

template <typename T1, typename T2>
inline void WeightedGraph<T1, T2>::addEdge(const long long i, const long long j, const T2 &val)
{
    if (i == j || i < 0 || i >= V.length() || !Active[i] || j < 0 || j >= V.length() || !Active[j])
    {
        throw std::invalid_argument("Graph::addEdge");
    }
    ENum++;
    E[i].insert(j); // 这里并没有检测是否已经存在边
    E[j].insert(i);
    W[i].insert(val);
    W[j].insert(val);
    return;
}

template <typename T1, typename T2>
inline void WeightedGraph<T1, T2>::deleteEdge(const long long i, const long long j)
{
    if (i == j || i < 0 || i >= V.length() || !Active[i] || j < 0 || j >= V.length() || !Active[j])
    {
        throw std::invalid_argument("Graph::deleteEdge");
    }
    long long no1{E[i].find(j)}, no2{E[j].find(i)};
    if (no1 == -1 || no2 == -1)
    {
        throw std::invalid_argument("WeightedGraph::deleteEdge");
    }
    E[i].remove(no1);
    W[i].remove(no1);
    E[j].remove(no2);
    W[j].remove(no2);
    return;
}

template <typename T1, typename T2>
inline long long WeightedGraph<T1, T2>::VertexCnt()
{
    return VNum;
}

template <typename T1, typename T2>
inline long long WeightedGraph<T1, T2>::EdgeCnt()
{
    return ENum;
}

template<typename T1, typename T2>
inline T1 WeightedGraph<T1, T2>::getValue(const long long no)
{
    if(no<0||no>=VNum||!Active[no]){throw std::invalid_argument("WeightedGraph::getValue");}
    return V[no];
}

template<typename T1, typename T2>
inline bool WeightedGraph<T1, T2>::valid(const long long no)
{
    return !(no<0||no>=VNum||!Active[no]);
}
#endif // GRAPH_H
