#include "friendlistmodel.h"
#include"graphmodel.h"
#include"personnode.h"
FriendListModel::FriendListModel(GraphModel* model, QObject *parent)
    :graphModel{model},QAbstractListModel{parent}
{

}

FriendListModel::~FriendListModel()
{

}

int FriendListModel::rowCount(const QModelIndex &parent) const
{
    return graphModel->friendNum;
}

QVariant FriendListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= graphModel->friendNum) {
        return QVariant();
    }
    qan::Node *node=graphModel->G.getValue((*(graphModel->friendTable))[graphModel->G.VertexCnt()-graphModel->friendNum+1+index.row()].no);
    switch(role) {
    case GraphModel::NoRole:
        return node->getLabel();
    case GraphModel::NameRole:
        return (static_cast<PersonNode*>(node))->getName();
    case GraphModel::MottoRole:
        return (static_cast<PersonNode*>(node))->getMotto();
    }
    return QVariant();
}

QHash<int, QByteArray> FriendListModel::roleNames() const
{
    return graphModel->roleNames();
}
