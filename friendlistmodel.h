#ifndef FRIENDLISTMODEL_H
#define FRIENDLISTMODEL_H

#include <QObject>
#include <QtCore>
#include"friendnode.h"
class FriendListModel:public QAbstractListModel
{
    Q_OBJECT
    friend StrangerListModel;
public:
    explicit FriendListModel(GraphModel*,QObject *parent=nullptr);
    ~FriendListModel();
    virtual bool removeRows(int,int,const QModelIndex&parent=QModelIndex())override;
public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
private:
    GraphModel* graphModel;
protected:
    virtual QHash<int, QByteArray> roleNames() const override;
signals:
    void beginReset();
    void endReset();
    void beginUpdateStrangerList();
    void endUpdateStrangerList();
};

#endif // FRIENDLISTMODEL_H
