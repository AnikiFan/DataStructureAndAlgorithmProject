#include "strangerlistmodel.h"
#include"graphmodel.h"
#include"personnode.h"
StrangerListModel::StrangerListModel(GraphModel*model, QObject *parent)
    :graphModel{model},QAbstractListModel{parent}
{
    connect(this,&StrangerListModel::beginReset,this,&StrangerListModel::beginResetModel);
    connect(this,&StrangerListModel::endReset,this,&StrangerListModel::endResetModel);
}

StrangerListModel::~StrangerListModel()
{

}

bool StrangerListModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent,row,row+count-1);
    qDebug()<<"stranger list remove row"<<row;
    emit beginUpdateFriendList();

    long long added{graphModel->G.getValue((*(graphModel->friendTable))[row].no)->getLabel().toLongLong()};
    qDebug()<<"addEdge:"<<graphModel->self()<<added;
    graphModel->insertEdge(graphModel->G.getValue(graphModel->self()),graphModel->G.getValue((*(graphModel->friendTable))[row].no));
    graphModel->updateFriendTableOnAddingFriend(added);
    endRemoveRows();
    emit endUpdateFriendList();
    emit dataChanged(index(0),index(rowCount(QModelIndex())));
    return true;
}

int StrangerListModel::rowCount(const QModelIndex &parent) const
{
    // qDebug()<<"Stranger num:"<<graphModel->G.VertexCnt()-graphModel->friendNum-1;
    return graphModel->G.VertexCnt()-graphModel->friendNum-1;
}

QVariant StrangerListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= graphModel->G.VertexCnt()-graphModel->friendNum-1) {
        return QVariant();
    }
    qDebug()<<"stranger list index:"<<index.row()<<"->"<<"friendTable["<<index.row()<<"]";
    qan::Node *node=graphModel->G.getValue((*(graphModel->friendTable))[index.row()].no);
    switch(role) {
    case GraphModel::NoRole:
        return node->getLabel();
    case GraphModel::NameRole:
        return (static_cast<PersonNode*>(node))->getName();
    case GraphModel::MottoRole:
        return (static_cast<PersonNode*>(node))->getMotto();
    case GraphModel::ConnectivityRole:
        return (*(graphModel->friendTable))[(*(graphModel->numberTable))[(static_cast<PersonNode*>(node))->getLabel().toLongLong()]].connectivity;
    }
    return QVariant();
}

QHash<int, QByteArray> StrangerListModel::roleNames() const
{
    return graphModel->roleNames();
}
