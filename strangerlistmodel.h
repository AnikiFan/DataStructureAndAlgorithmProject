#ifndef STRANGERLISTMODEL_H
#define STRANGERLISTMODEL_H

#include <QObject>
#include <QtCore>
#include "friendnode.h"
class GraphModel;
class StrangerListModel:public QAbstractListModel
{
    Q_OBJECT
    friend FriendListModel;
public:
    explicit StrangerListModel(GraphModel*, QObject *parent=nullptr);
    ~StrangerListModel();
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
};

#endif // STRANGERLISTMODEL_H
