#ifndef STRANGERLISTMODEL_H
#define STRANGERLISTMODEL_H

#include <QObject>
#include <QtCore>
#include "friendnode.h"
#include"Vector.h"
class StrangerListModel:public QAbstractListModel
{
    Q_OBJECT
public:
    explicit StrangerListModel(Vector<FriendNode>*, QObject *parent=nullptr);
    ~StrangerListModel();
public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
private:
    Vector<FriendNode>*friendTable;
};

#endif // STRANGERLISTMODEL_H
