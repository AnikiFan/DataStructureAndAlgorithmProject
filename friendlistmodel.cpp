#include "friendlistmodel.h"

FriendListModel::FriendListModel(Vector<FriendNode> *friendtable, QObject *parent)
    :friendTable{friendtable},QAbstractListModel{parent}
{

}

FriendListModel::~FriendListModel()
{

}

int FriendListModel::rowCount(const QModelIndex &parent) const
{
    return 0;
}

QVariant FriendListModel::data(const QModelIndex &index, int role) const
{
    return QVariant();
}
