#include "graphmodel.h"
#include "personnode.h"
#include<QDebug>
GraphModel::GraphModel(QQuickItem *parent)
    :Graph{parent}
{
    connect(this,&GraphModel::connectorEdgeInserted,this,&GraphModel::onConnectorEdgeInserted);
}

qan::Node *GraphModel::insertCustomNode() {
    return qan::Graph::insertNode<PersonNode>(nullptr);
}

void GraphModel::onNodeInserted(qan::Node &node)
{
    G.addNode(&node);
    return;
}

void GraphModel::onNodeRemoved(qan::Node &node)
{
    G.deleteNode(node.getLabel().toLongLong());
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

qan::Node *GraphModel::getSelectedNode()
{
    return *_selectedNodes.begin();
}

void GraphModel::onConnectorEdgeInserted(qan::Edge* edge)
{
    qDebug()<<"edge inserted"<<get_edge_count();
}
