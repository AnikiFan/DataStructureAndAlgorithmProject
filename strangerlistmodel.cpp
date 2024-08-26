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

int StrangerListModel::rowCount(const QModelIndex &parent) const
{
    qDebug()<<"Stranger num:"<<graphModel->G.VertexCnt()-graphModel->friendNum-1;
    return graphModel->G.VertexCnt()-graphModel->friendNum-1;
}

QVariant StrangerListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= graphModel->G.VertexCnt()-graphModel->friendNum-1) {
        return QVariant();
    }
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
