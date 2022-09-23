
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QLoggingCategory>

int main ( int argc, char *argv[] ){

    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    //    QtWebEngineQuick::initialize(); //QtWebEngineQuick初始化
    QApplication app ( argc, argv );

    QQmlApplicationEngine engine;

    Q_INIT_RESOURCE ( qml );

    engine.load ( QUrl ( QStringLiteral ( "qrc:/main.qml" ) ) );
    if ( engine.rootObjects().isEmpty() ) {
        return -1;
    }
    return app.exec();
}
