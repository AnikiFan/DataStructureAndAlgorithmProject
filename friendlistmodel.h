#ifndef FRIENDLISTMODEL_H
#define FRIENDLISTMODEL_H

#include <QObject>
#include <QtCore>
#include"friendnode.h"
class FriendListModel:public QAbstractListModel
{
    Q_OBJECT
public:
    explicit FriendListModel(GraphModel*,QObject *parent=nullptr);
    ~FriendListModel();
public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
private:
    GraphModel* graphModel;
protected:
    virtual QHash<int, QByteArray> roleNames() const override;
};

#endif // FRIENDLISTMODEL_H
