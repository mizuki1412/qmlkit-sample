import QtQuick
import QtQuick.Controls

QtObject{
    Component.onCompleted:{
        let path = Qt.application.arguments[0]
        while(path.indexOf("\\")>=0){
            path = path.replace("\\","/")
        }
        appHome = path.slice(0, path.lastIndexOf("/"))
    }
	// 程序运行根目录
    property string appHome: ""
}
