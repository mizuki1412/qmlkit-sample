#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2>

int main ( int argc, char *argv[] ){
//    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    //    QtWebEngineQuick::initialize(); //QtWebEngineQuick初始化
    // Qt.quit有效
    QApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    QFont font;
//    font.setFamily("Arial");
    font.setPixelSize(16);
    app.setFont(font);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/main/qml/main.qml"_qs);
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

    return app.exec();
}
