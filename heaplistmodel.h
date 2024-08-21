#ifndef HEAPLISTMODEL_H
#define HEAPLISTMODEL_H

#include <QObject>
#include <QtCore>
#include "heapmodel.h"
/// @brief 用于QML中的list视图
class HeapListModel:public QAbstractListModel
{
    Q_OBJECT
public:
    explicit HeapListModel(HeapModel*base, QObject *parent=nullptr);
    /// @brief 键值、状态
    ~HeapListModel();
public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
private:
    /// @brief 指向所要可视化的堆
    HeapModel * heap;
public slots:
    void onElementValueChanged(long long x,long long y);
    void onElementStateChanged(long long i);
protected:
    virtual QHash<int, QByteArray> roleNames() const override;
};

#endif // HEAPLISTMODEL_H
