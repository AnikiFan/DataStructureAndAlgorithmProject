#ifndef HEAPMODEL_H
#define HEAPMODEL_H

#include <QObject>
#include <QtCore>
#include "Heap.h"
#include "element.h"
#include<QEventLoop>
class HeapListModel;
class HeapTableModel;
class FileObject;
/// @brief 用于存放待可视化的堆，并负责发送相应的signals
class HeapModel:public QAbstractItemModel, Heap<Element>
{
    Q_OBJECT
    Q_PROPERTY(bool pause READ pause WRITE setpause NOTIFY pauseChanged FINAL)
    Q_PROPERTY(bool pauseWhenSwapping READ pauseWhenSwapping WRITE setPauseWhenSwapping NOTIFY pauseWhenSwappingChanged FINAL)
    Q_PROPERTY(bool quit READ quit WRITE setQuit NOTIFY quitChanged FINAL)
    Q_PROPERTY(bool finished READ finished WRITE setFinished NOTIFY finishedChanged FINAL)
    Q_PROPERTY(bool reloading READ reloading WRITE setReloading NOTIFY reloadingChanged FINAL)
    Q_PROPERTY(bool firstClicked READ firstClicked WRITE setFirstClicked NOTIFY firstClickedChanged FINAL)
public:
    explicit HeapModel(QObject*parent = nullptr);
    ~HeapModel();
    void swap(long long x,long long y) override;
    void sort()override;
    void shrink() override;
    friend HeapListModel;
    friend HeapTableModel;
    friend FileObject;
    virtual QModelIndex index(int row, int column,
                              const QModelIndex &parent = QModelIndex()) const override ;
    virtual QModelIndex parent(const QModelIndex &child) const override;
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool pauseWhenSwapping() const;
    void setPauseWhenSwapping(bool newPauseWhenSwapping);

    bool pause() const;
    void setpause(bool newPause);

    bool quit() const;
    void setQuit(bool newQuit);
    void maintain(long long i)override;
    void build()override;

    bool finished() const;
    void setFinished(bool newFinished);

    bool reloading() const;
    void setReloading(bool newReloading);

    bool firstClicked() const;
    void setFirstClicked(bool newFirstClicked);

protected:
    enum RoleNames{
        ValueRole = Qt::UserRole,
        StateRole = Qt::UserRole+1
    };
    /// @brief QML系统所需
    QHash<int, QByteArray> m_roleNames;
    virtual QHash<int, QByteArray> roleNames() const override;
public slots:
    void reload(const QString);
    void start();
    void stop();
    void wait();
    void restart();
signals:
    void elementValueChanged(long long x,long long y);
    void elementStateChanged(long long i);
    void swapping();
    void Continue();
    void pauseWhenSwappingChanged();

    void pauseChanged();

    void quitChanged();
    void restarted();
    void finishedChanged();

    void reloadingChanged();
    void getInputText();
    void beginResetHeapModel();
    void firstClickedChanged();

private:
    QEventLoop loop;
    Element* raw;
    bool m_pauseWhenSwapping;
    bool m_pause;
    bool m_quit=false;
    bool m_finished=false;
    bool m_reloading=false;
    bool m_firstClicked=true;
};

#endif // HEAPMODEL_H
