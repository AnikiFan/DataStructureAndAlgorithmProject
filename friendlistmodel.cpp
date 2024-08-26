#include "friendlistmodel.h"
#include"graphmodel.h"
#include"personnode.h"
#include<QDebug>
FriendListModel::FriendListModel(GraphModel* model, QObject *parent)
    :graphModel{model},QAbstractListModel{parent}
{
    connect(this,&FriendListModel::beginReset,this,&FriendListModel::beginResetModel);
    connect(this,&FriendListModel::endReset,this,&FriendListModel::endResetModel);
}

FriendListModel::~FriendListModel()
{

}

bool FriendListModel::removeRows(int row,int count, const QModelIndex&parent)
{
    beginRemoveRows(parent,row,row+count-1);
    qDebug()<<"friend list remove row"<<row;
    emit beginUpdateStrangerList();

    long long removed{graphModel->G.getValue((*(graphModel->friendTable))[graphModel->G.VertexCnt()-graphModel->friendNum+row-1].no)->getLabel().toLongLong()};
    qDebug()<<"deleteEdge:"<<graphModel->self()<<removed;
    if(graphModel->hasEdge(graphModel->G.getValue(removed),graphModel->G.getValue(graphModel->self()))){graphModel->removeEdge(graphModel->G.getValue(removed),graphModel->G.getValue(graphModel->self()));}
    else{graphModel->removeEdge(graphModel->G.getValue(graphModel->self()),graphModel->G.getValue(removed));}
    graphModel->updateFriendTableOnRemovingFriend(removed);

    endRemoveRows();
    emit endUpdateStrangerList();
    emit dataChanged(index(0),index(rowCount(QModelIndex())));
    return true;
}

int FriendListModel::rowCount(const QModelIndex &parent) const
{
    // qDebug()<<"Friend num:"<<graphModel->friendNum;
    return graphModel->friendNum;
}

QVariant FriendListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= graphModel->friendNum) {
        return QVariant();
    }
    qDebug()<<"friend list index:"<<index.row()<<"->"<<"friendTable["<<graphModel->G.VertexCnt()-graphModel->friendNum+index.row()-1<<"]";
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
