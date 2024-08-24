#include "graphmodel.h"
#include "personnode.h"
#include<QDebug>
GraphModel::GraphModel(QQuickItem *parent)
    :Graph{parent}
{

}

qan::Node *GraphModel::insertCustomNode() {
    return qan::Graph::insertNode<PersonNode>(nullptr);
}

void GraphModel::onNodeInserted(qan::Node &node)
{
    G.addNode(&node);
    return;
}

qan::Node *GraphModel::getNode(long long no)
{
    return G.getValue(no);
}

long long GraphModel::findNode(const QString &query)
{

    for(long long i{0};i<G.VertexCnt();i++){
        if(!G.valid(i)){continue;}
        if(static_cast<PersonNode*>(G.getValue(i))->getName()==query){
            qDebug()<<i;
            return i;
        }
    }
    qDebug()<<"query failed";
    return -1;
}

bool GraphModel::isValid(const long long i)
{
    return G.valid(i);
}

