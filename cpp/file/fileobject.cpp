
#include "fileobject.h"
#include <QUrl>
#include <QFile>
#include <QTextStream>

FileObject::FileObject(QObject *parent) :
    QObject(parent)
{

}

QString FileObject::read(const QString&src)
{
    // 做一下转换，将file:///C:/xxx 转换为 C:/xxx
    QUrl url(src);
    QString content;
    QFile file(url.toLocalFile());
    if ( file.open(QIODevice::ReadOnly) ) {
        content = file.readAll();
        file.close();
//        QTextStream in(&file);
    }

    return content;
}

bool FileObject::write(const QString& src, const QString& data)
{
    QFile file(src);
    if ( file.open(QFile::WriteOnly | QFile::Truncate) ) {
        QTextStream out(&file);
        out<<data;
        file.close();
        return true;
    }
    else {
        return false;
    }
}

bool FileObject::append(const QString& src, const QString& data)
{
    QFile file(src);
    if ( file.open(QFile::WriteOnly | QIODevice::Append) ) {
        QTextStream out(&file);
        out<<data;
        file.close();
        return true;
    }
    else {
        return false;
    }
}