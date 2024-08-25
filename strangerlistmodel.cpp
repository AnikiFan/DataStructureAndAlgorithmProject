#include "strangerlistmodel.h"

StrangerListModel::StrangerListModel(Vector<FriendNode> *, QObject *parent)
{

}

StrangerListModel::~StrangerListModel()
{

}

int StrangerListModel::rowCount(const QModelIndex &parent) const
{
    return 0;
}

QVariant StrangerListModel::data(const QModelIndex &index, int role) const
{
    return QVariant();
}
