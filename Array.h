#ifndef ARRAY_H
#define ARRAY_H
#include <stdexcept>
template <typename T>
class Array;
template <typename T>
class Node
{
    friend Array<T>;

public:
    T getValue();
    Node *getNext();
    Node(const T &val);

private:
    T value;
    Node *next;
};

template <typename T>
class Array
{
public:
    Array();
    ~Array();
    void insert(const T &);
    bool remove(const T &, bool (*)(const T &, const T &));
    void destroy();
    long long length();
    void traverse(void (*)(const T &));
    Node<T> *getHead();
    long long find(const T &);
    void remove(const long long);

private:
    Node<T> *head;
    long long len;
};

template <typename T>
inline Array<T>::Array()
    : head{nullptr}, len{0}
{
}

template <typename T>
inline Array<T>::~Array()
{
    Node<T> *p{head}, *q{nullptr};
    while (p)
    {
        q = p;
        p = p->next;
        delete q;
    }
}

template <typename T>
inline void Array<T>::insert(const T &val)
{
    Node<T> *p{head};
    head = new Node<T>{val};
    if (!head)
    {
        throw std::overflow_error("Array::insert");
    }
    head->next = p;
    len++;
    return;
}

template <typename T>
inline bool Array<T>::remove(const T &val, bool (*check)(const T &, const T &))
{
    if (!head)
    {
        return false;
    }
    if (check(head->value, val))
    {
        Node<T> *p{head};
        head = head->next;
        delete p;
        len--;
        return true;
    }
    Node<T> *p{head->next}, *q{head};
    while (p)
    {
        if (check(p->value, val))
        {
            q->next = p->next;
            delete p;
            len--;
            return true;
        }
        q = p;
        p = p->next;
    }
    return false;
}

template <typename T>
inline void Array<T>::destroy()
{
    Node<T> *p{head}, *q{nullptr};
    while (p)
    {
        q = p;
        p = p->next;
        delete q;
    }
    head = nullptr;
    len = 0;
    return;
}

template <typename T>
inline long long Array<T>::length()
{
    return len;
}

template <typename T>
inline void Array<T>::traverse(void (*f)(const T &))
{
    Node<T> *p{head};
    while (p)
    {
        f(p->value);
        p = p->next;
    }
    return;
}

template <typename T>
Node<T> *Array<T>::getHead()
{
    return head;
}

template <typename T>
inline long long Array<T>::find(const T &val)
{
    Node<T> *p = head;
    long long result{0};
    while (p && p->value != val)
    {
        result++;
        p = p->next;
    }
    return p ? result : -1;
}

template <typename T>
inline void Array<T>::remove(const long long no)
{
    if (no < 0 || no >= len)
    {
        throw std::invalid_argument("Array::remove");
    }
    Node<T> *p{head};
    len--;
    if (!no)
    {
        head = p->next;
        delete p;
        return;
    }
    for (long long i{0}; i < no - 1; i++)
    {
        p = p->next;
    }
    Node<T> *q{p->next};
    p->next = p->next->next;
    delete q;
    return;
}

template <typename T>
T Node<T>::getValue()
{
    return value;
}

template <typename T>
Node<T> *Node<T>::getNext()
{
    return next;
}

template <typename T>
inline Node<T>::Node(const T &val)
    : value{val}
{
}

#endif // ARRAY_H
