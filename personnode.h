#ifndef PERSONNODE_H
#define PERSONNODE_H
// Qt headers
#include <QGuiApplication>
#include <QtQml>
#include <QQuickStyle>

// QuickQanava headers
#include <QuickQanava.h>
class PersonNode : public qan::Node
{
    Q_OBJECT
public:
    explicit PersonNode(QObject* parent = nullptr) : qan::Node{parent} { /* Nil */ }
    virtual ~PersonNode() override { /* Nil */ }
private:
    PersonNode(const PersonNode &) = delete;

public:
    static QQmlComponent*     delegate(QQmlEngine &engine, QObject* parent = nullptr) noexcept;
    static qan::NodeStyle*    style(QObject* parent = nullptr) noexcept;

public:
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged FINAL)
    void            setName(const QString& name);
    QString         getName() const ;
private:
    QString         _name = "";
signals:
    void            nameChanged();

public:
    Q_PROPERTY(QString school READ getSchool WRITE setSchool NOTIFY schoolChanged FINAL)
    void            setSchool(const QString& school);
    QString         getSchool() const ;
private:
    QString         _school = "";
signals:
    void            schoolChanged();

public:
    Q_PROPERTY(QString company READ getCompany WRITE setCompany NOTIFY companyChanged FINAL)
    void            setCompany(const QString& company);
    QString         getCompany() const ;
private:
    QString         _company = "";
signals:
    void            companyChanged();

public:
    enum Gender{
        Male=0,
        Female,
        Other
    };
    Q_ENUM(Gender)
    Q_PROPERTY(Gender gender READ getGender WRITE setGender NOTIFY genderChanged FINAL)
    void            setGender(const Gender& gender);
    Gender         getGender() const;
private:
    Gender         _gender = Other;
signals:
    void            genderChanged();

public:
Q_PROPERTY(int age READ getAge WRITE setAge NOTIFY ageChanged FINAL)
void             setAge(const int& age);
int             getAge() const ;
private:
int         _age = 0;
signals:
void            ageChanged();

public:
    Q_PROPERTY(QString motto READ getMotto WRITE setMotto NOTIFY mottoChanged FINAL)
    void            setMotto(const QString& motto);
    QString         getMotto() const;
private:
    QString         _motto = "";
signals:
    void            mottoChanged();
};

QML_DECLARE_TYPE(PersonNode)

#endif // PERSONNODE_H
