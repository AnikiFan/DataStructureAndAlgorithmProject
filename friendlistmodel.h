#ifndef FRIENDLISTMODEL_H
#define FRIENDLISTMODEL_H

#include <QObject>
#include <QtCore>
#include"Vector.h"
#include"friendnode.h"
class FriendListModel:public QAbstractListModel
{
    Q_OBJECT
public:
    explicit FriendListModel(Vector<FriendNode>*,QObject *parent=nullptr);
    ~FriendListModel();
public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
private:
    Vector<FriendNode>*friendTable;
};

#endif // FRIENDLISTMODEL_H
