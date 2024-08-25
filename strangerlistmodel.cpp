#include "strangerlistmodel.h"
#include"graphmodel.h"
#include"personnode.h"
StrangerListModel::StrangerListModel(GraphModel*model, QObject *parent)
    :graphModel{model},QAbstractListModel{parent}
{

}

StrangerListModel::~StrangerListModel()
{

}

int StrangerListModel::rowCount(const QModelIndex &parent) const
{
    return graphModel->G.VertexCnt()-graphModel->friendNum;
}

QVariant StrangerListModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= graphModel->friendNum) {
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
    }
    return QVariant();
}

QHash<int, QByteArray> StrangerListModel::roleNames() const
{
    return graphModel->roleNames();
}
