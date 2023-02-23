#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2>
#include "file/fileobject.h"
#include <QtWebEngineQuick/qtwebenginequickglobal.h>

int main ( int argc, char *argv[] ){
//    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    // Qt.quit有效
    QApplication app(argc, argv);
    QtWebEngineQuick::initialize();
    QQuickStyle::setStyle("Material");
    QFont font;
//    font.setFamily("Arial");
//    font.setPixelSize(16);
//    app.setFont(font);
    //使用自定义字体--阿里巴巴普惠体
    int fontId = QFontDatabase::addApplicationFont(QCoreApplication::applicationDirPath()+"/assets/Alibaba-PuHuiTi-Regular.ttf" );
    QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);
    if (fontFamilies.size() > 0){
        qDebug()<<"fontfamilies:"<<fontFamilies.at(0);
        font.setFamily(fontFamilies.at(0));
        font.setPixelSize(16);
        app.setFont(font);
    }

    QQmlApplicationEngine engine;
    qmlRegisterType<FileObject> ( "FileObject", 1, 0, "FileObject" );

    const QUrl url(u"qrc:/qml/main.qml"_qs);
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

    return app.exec();
}
