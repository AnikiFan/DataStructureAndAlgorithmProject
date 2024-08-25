#ifndef GRAPHMODEL_H
#define GRAPHMODEL_H
// Qt headers
#include <QGuiApplication>
#include <QtQml>
#include <QQuickStyle>
#include "Graph.h"
#include "friendnode.h"
#include"friendlistmodel.h"
#include"strangerlistmodel.h"
// QuickQanava headers
#include <QuickQanava.h>
class GraphModel : public qan::Graph {
    Q_OBJECT
    friend FriendListModel;
    friend StrangerListModel;
public:
    explicit GraphModel(QQuickItem *parent = nullptr);
    virtual ~GraphModel() override  { /* Nil */ }
protected:
    enum RoleNames{
        NoRole = Qt::UserRole,
        NameRole = Qt::UserRole+1,
        MottoRole = Qt::UserRole+2
    };
    /// @brief QML系统所需
    QHash<int, QByteArray> m_roleNames;
    virtual QHash<int, QByteArray> roleNames() const ;
private:
    GraphModel(const GraphModel &) = delete;
    WeightedGraph<qan::Node*,qan::Edge*> G;
    long long lastSelectedNode;
    Vector<FriendNode> *friendTable;
    FriendListModel* friendListModel;
    StrangerListModel* strangerListModel;
    Vector<long long>* numberTable;
    void updateNumberTable();
    long long friendNum;
public:
    Q_INVOKABLE qan::Node*    insertCustomNode();
    void onNodeInserted(qan::Node&node)override;
    void onNodeRemoved(qan::Node&node)override;
    Q_INVOKABLE qan::Node*    getNode(long long no);
    Q_INVOKABLE long long     findNode(const QString& );
    Q_INVOKABLE bool          isValid(const long long);
    Q_INVOKABLE qan::Node*    getSelectedNode();
    void onEdgeInserted(qan::Edge* edge);
    void edgeRemoved(qan::Edge*edge);
    void onSelectionChanged();
    Q_INVOKABLE void initFriendTable(const long long self);
    void deleteFriendTable();

    Q_PROPERTY(FriendListModel* friendList READ getFriendListModel CONSTANT FINAL)
    Q_INVOKABLE FriendListModel*     getFriendListModel() const;

    Q_PROPERTY(StrangerListModel* strangerList READ getStrangerListModel CONSTANT FINAL)
    Q_INVOKABLE StrangerListModel*     getStrangerListModel() const;
};

QML_DECLARE_TYPE(GraphModel)
#endif // GRAPHMODEL_H
