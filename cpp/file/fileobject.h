#ifndef FILE_OBJECT_H
#define FILE_OBJECT_H

#include <QObject>

class FileObject : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
public:
    explicit FileObject(QObject *parent = 0);

    Q_INVOKABLE QString read(const QString& src);
    Q_INVOKABLE bool write(const QString& src, const QString& data);
    Q_INVOKABLE bool append(const QString& src, const QString& data);
};

#endif // FILE_OBJECT_H
