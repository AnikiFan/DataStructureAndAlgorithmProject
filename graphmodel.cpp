#include "graphmodel.h"
#include "personnode.h"
#include<QDebug>
#include"Heap.h"
GraphModel::GraphModel(QQuickItem *parent)
    :Graph{parent},lastSelectedNode{-1},friendTable{nullptr},friendListModel{nullptr},strangerListModel{nullptr}
{
    connect(this,&GraphModel::edgeInserted,this,&GraphModel::onEdgeInserted);
    connect(this,&GraphModel::selectionChanged,this,&GraphModel::onSelectionChanged);
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

void GraphModel::onEdgeInserted(qan::Edge* edge)
{
    G.addEdge(edge->get_dst()->getLabel().toLongLong(),edge->get_src()->getLabel().toLongLong(),edge);
    qDebug()<<"edge inserted"<<get_edge_count()<<"     "<<G.EdgeCnt()<<"     "<<getNodeCount()<<"     "<<G.VertexCnt();
    return;
}

void GraphModel::onSelectionChanged()
{
    if(hasSelection()){
        lastSelectedNode=(*_selectedNodes.begin())->getLabel().toLongLong();
        G.traverseW(lastSelectedNode,[](qan::Edge *const &edge){
            qan::EdgeStyle tmp{edge->getItem()->getStyle()};
            tmp.setLineColor(QColor{0,0,0,255});
            edge->getItem()->setStyle(&tmp);
        });
    }else if(isValid(lastSelectedNode)){
        lastSelectedNode=(*_selectedNodes.begin())->getLabel().toLongLong();
        G.traverseW(lastSelectedNode,[](qan::Edge *const &edge){
            qan::EdgeStyle tmp{edge->getItem()->getStyle()};
            tmp.setLineColor(QColor{160, 160, 160, 255});
            edge->getItem()->setStyle(&tmp);
        });
    }
   // qDebug()<<"has selection:"<<hasSelection();
}

void GraphModel::initFriendTable(const long long self)
{
    friendTable = new Vector<FriendNode>{G.VertexSize()};
    for(long long i{0};i<G.VertexSize();i++){
        if(!G.Active[i]){friendTable->push_back(FriendNode{i,false,-2});}
        else{friendTable->push_back(i);}
    }
    Node<long long>*p{G.E[self].getHead()};
    while(p){
        (*friendTable)[p->getValue()].isFriend = true;
        (*friendTable)[p->getValue()].connectivity = -1;
        p = p->getNext();
    }
    for(long long i{0};i<G.VertexSize();i++){
        if((*friendTable)[i].isFriend||(*friendTable)[i].connectivity==-2){continue;}
        Node<long long>*p{G.E[i].getHead()};
        while(p){
            (*friendTable)[p->getValue()].connectivity ++;
            p = p->getNext();
        }
    }
    friendListModel = new FriendListModel{friendTable,this};
    strangerListModel = new StrangerListModel{friendTable,this};
    return;
}

void GraphModel::deleteFriendTable()
{
    if(friendTable){
        delete friendTable;
        delete friendListModel;
        delete strangerListModel;
    }
    return;
}

FriendListModel *GraphModel::getFriendListModel() const
{
    return friendListModel;
}

StrangerListModel *GraphModel::getStrangerListModel() const
{
    return strangerListModel;
}
