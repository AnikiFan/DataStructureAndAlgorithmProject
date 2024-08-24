#ifndef GRAPHMODEL_H
#define GRAPHMODEL_H
// Qt headers
#include <QGuiApplication>
#include <QtQml>
#include <QQuickStyle>
#include "Graph.h"
// QuickQanava headers
#include <QuickQanava.h>
class GraphModel : public qan::Graph {
    Q_OBJECT
public:
    explicit GraphModel(QQuickItem *parent = nullptr);
    virtual ~GraphModel() override  { /* Nil */ }
private:
    GraphModel(const GraphModel &) = delete;
    WeightedGraph<qan::Node*,qan::Edge*> G;
public:
    Q_INVOKABLE qan::Node*    insertCustomNode();
    void onNodeInserted(qan::Node&node)override;
    void onNodeRemoved(qan::Node&node)override;
    Q_INVOKABLE qan::Node*    getNode(long long no);
    Q_INVOKABLE long long     findNode(const QString& );
    Q_INVOKABLE bool          isValid(const long long);
    Q_INVOKABLE qan::Node*    getSelectedNode();
    void onConnectorEdgeInserted(qan::Edge* edge);
};

QML_DECLARE_TYPE(GraphModel)
#endif // GRAPHMODEL_H
