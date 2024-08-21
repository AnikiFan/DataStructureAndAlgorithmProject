#ifndef HEAPTABLEMODEL_H
#define HEAPTABLEMODEL_H

#include <QObject>
#include <QtCore>
#include"heapmodel.h"
#include"formatter.h"
/// @brief 用于堆的二维可视化，利用Table视图实现
class HeapTableModel:public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit HeapTableModel(HeapModel*base,QObject*parent=nullptr);
    /// @brief 属性名

    ~HeapTableModel();
    Q_PROPERTY(long long rowNumber READ rowNumber  NOTIFY rowNumberChanged FINAL)
    Q_PROPERTY(long long  colNumber READ colNumber NOTIFY colNumberChanged FINAL)
public:
    virtual int rowCount(const QModelIndex & = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex & = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
private:
    /// @brief 指向所需可视化的堆
    HeapModel * heap;
    Formatter formatter;
    long long m_rowNumber;
    long long rowNumber()const;
    long long m_colNumber;
    long long colNumber()const;
signals:
    void rowNumberChanged();
    void colNumberChanged();
    void focusOnItem(long long r,long long c);
public slots:
    void onElementValueChanged(long long x,long long y);
    void onElementStateChanged(long long i);
    void onReloaded();
protected:
    virtual QHash<int, QByteArray> roleNames() const override;
};

#endif // HEAPTABLEMODEL_H
