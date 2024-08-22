#ifndef GRAPHMODEL_H
#define GRAPHMODEL_H
// Qt headers
#include <QGuiApplication>
#include <QtQml>
#include <QQuickStyle>

// QuickQanava headers
#include <QuickQanava.h>
class GraphModel : public qan::Graph {
    Q_OBJECT
public:
    explicit GraphModel(QQuickItem *parent = nullptr) : qan::Graph{parent} { /* Nil */ }
    virtual ~GraphModel() override  { /* Nil */ }
private:
    GraphModel(const GraphModel &) = delete;

public:
    Q_INVOKABLE qan::Node*    insertCustomNode();
};

QML_DECLARE_TYPE(GraphModel)
#endif // GRAPHMODEL_H
