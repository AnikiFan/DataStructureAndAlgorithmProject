#include "personnode.h"
// Qt headers
#include <QGuiApplication>
#include <QtQml>
#include <QQuickStyle>

// QuickQanava headers
#include <QuickQanava.h>
QQmlComponent*  PersonNode::delegate(QQmlEngine &engine, QObject* parent) noexcept
{
    Q_UNUSED(parent)
    static std::unique_ptr<QQmlComponent> customRectNode_delegate;
    if (!customRectNode_delegate)
        customRectNode_delegate =
            std::make_unique<QQmlComponent>(&engine, "qrc:/qt/qml/UntitledProject1Content/PersonNode.qml");
    return customRectNode_delegate.get();
}

qan::NodeStyle *PersonNode::style(QObject* parent) noexcept
{
    Q_UNUSED(parent)
    static std::unique_ptr<qan::NodeStyle> customRectNode_style;
    if (!customRectNode_style) {
        customRectNode_style = std::make_unique<qan::NodeStyle>();
        customRectNode_style->setBackColor(QColor("#ff29fc"));
    }
    return customRectNode_style.get();
}

void PersonNode::setName(const QString &name)
{
    if(_name==name){return;}
    _name=name;
    emit nameChanged();
    return;
}

QString PersonNode::getName() const
{
    return _name;
}

void PersonNode::setSchool(const QString &school)
{
    if(_school==school){return;}
    _school=school;
    emit schoolChanged();
    return;
}

QString PersonNode::getSchool() const
{
    return _school;
}

void PersonNode::setCompany(const QString &company)
{
    if(_company==company){return;}
    _company=company;
    emit companyChanged();
    return;
}

QString PersonNode::getCompany() const
{
    return _company;
}

void PersonNode::setGender(const PersonNode::Gender &gender)
{
    if(_gender==gender){return;}
    _gender=gender;
    emit genderChanged();
    return;
}

PersonNode::Gender PersonNode::getGender() const
{
    return _gender;
}

void PersonNode::setAge(const int &age)
{
    if(_age==age){return;}
    _age=age;
    emit ageChanged();
    return;
}

int PersonNode::getAge() const
{
    return _age;
}

void PersonNode::setMotto(const QString &motto)
{
    if(_motto==motto){return;}
    _motto=motto;
    emit mottoChanged();
    return;
}

QString PersonNode::getMotto() const
{
    return _motto;
}
