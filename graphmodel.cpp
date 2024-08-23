#include "graphmodel.h"
#include "personnode.h"

qan::Node *GraphModel::insertCustomNode() {
    return qan::Graph::insertNode<PersonNode>(nullptr);
}
