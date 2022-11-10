import QtQuick
import QtQuick.Controls

QtObject{
	// 程序运行根目录
    property string appHome: Qt.application.arguments[0].slice(0, Qt.application.arguments[0].lastIndexOf("/"))
}
