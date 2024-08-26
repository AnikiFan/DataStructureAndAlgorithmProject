#include "friendlistmodel.h"
#include"graphmodel.h"
#include"personnode.h"
#include<QDebug>
FriendListModel::FriendListModel(GraphModel* model, QObject *parent)
    :graphModel{model},QAbstractListModel{parent}
{

}

FriendListModel::~FriendListModel()
{

}

int FriendListModel::rowCount(const QModelIndex &parent) const
{
    qDebug()<<"Friend num:"<<graphModel->friendNum;
    return graphModel->friendNum;
}

QVariant FriendListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= graphModel->friendNum) {
        return QVariant();
    }
    qDebug()<<"index:"<<index.row()<<"->"<<"friendTable["<<graphModel->G.VertexCnt()-graphModel->friendNum+index.row()-1<<"]";
    qan::Node *node=graphModel->G.getValue((*(graphModel->friendTable))[graphModel->G.VertexCnt()-graphModel->friendNum+index.row()-1].no);
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
