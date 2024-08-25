#include "graphmodel.h"
#include "personnode.h"
#include<QDebug>
GraphModel::GraphModel(QQuickItem *parent)
    :Graph{parent}
    ,lastSelectedNode{-1}
    ,friendTable{nullptr}
    ,friendListModel{nullptr}
    ,strangerListModel{nullptr}
    ,numberTable{nullptr}
    ,friendNum{-1}
{
    m_roleNames[NoRole] = "no";
    m_roleNames[NameRole] = "name";
    m_roleNames[MottoRole] = "motto";
    connect(this,&GraphModel::edgeInserted,this,&GraphModel::onEdgeInserted);
    connect(this,&GraphModel::onEdgeRemoved,this,&GraphModel::edgeRemoved);
    connect(this,&GraphModel::selectionChanged,this,&GraphModel::onSelectionChanged);

}
/// @brief QML系统所需的函数
/// @return
QHash<int, QByteArray> GraphModel::roleNames() const
{
    return m_roleNames;
}


void GraphModel::updateNumberTable()
{
    for(long long i{0};i<G.VertexSize();i++){(*numberTable)[(*friendTable)[i].no]=i;}
    return ;
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

void GraphModel::edgeRemoved(qan::Edge *edge)
{
    G.deleteEdge(edge->getSource()->getLabel().toLongLong(),edge->getDestination()->getLabel().toLongLong());
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
    friendTable = new Vector<FriendNode>(G.VertexSize());
    friendNum = 0;
    for(long long i{0};i<G.VertexSize();i++){
        if(!G.Active[i]){friendTable->push_back(
                FriendNode{i,FriendNode::invalid});
            qDebug()<<"set node"<<i<<"invalid";
        }
        else{friendTable->push_back(FriendNode{i,0});}
    }
    (*friendTable)[self].connectivity = FriendNode::invalid;
    Node<long long>*p{G.E[self].getHead()};
    while(p){
        friendNum ++;
        (*friendTable)[p->getValue()].connectivity = FriendNode::isFriend;
        qDebug()<<"set node"<<p->getValue()<<"friend";
        p = p->getNext();
    }
    for(long long i{0};i<G.VertexSize();i++){
        if((*friendTable)[i].connectivity==FriendNode::isFriend||(*friendTable)[i].connectivity==FriendNode::invalid){continue;}
        Node<long long>*p{G.E[i].getHead()};
        while(p){
            if((*friendTable)[p->getValue()].connectivity==FriendNode::isFriend){
                (*friendTable)[i].connectivity++;
                qDebug()<<"node"<<i<<"connectivity:"<<(*friendTable)[i].connectivity;
            }
            p = p->getNext();
        }
    }
    friendListModel = new FriendListModel{this,this};
    strangerListModel = new StrangerListModel{this,this};
    friendTable->sort(friendTable->begin(),friendTable->end(),[](const FriendNode &x,const FriendNode& y){return x.connectivity>y.connectivity;});
    numberTable = new Vector<long long>(G.VertexSize());
    updateNumberTable();
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
