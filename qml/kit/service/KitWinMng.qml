import QtQuick
import QtQml
import QtQml.Models
import QtQuick.Controls

QtObject {
    // path: {path,title,object, place:tab/show}
    property var winMap:({})
    // winMng对象数组
    property ListModel tabModels: ListModel{}

    // 通知修改tab的currentIndex
    signal tabCurrentIndexChange(int index)

    // 显示到tab中
    function tab(path,title){
        if(winMap[path] && winMap[path].place==="tab"){
            for(let i=0;i<tabModels.count;i++){
                if(tabModels.get(i).path === path){
                    tabCurrentIndexChange(i)
                    break
                }
            }
        }
        else if(winMap[path] && winMap[path].place==="show"){
            open(path,title)
        }
        else{
            winMap[path] = {place:"tab",path, title}
            tabModels.append(winMap[path])
            tabCurrentIndexChange(tabModels.count-1)
        }
    }

    // title:windows的, config:{width, height}
    function open(path,title,config){
        if(!config) config = {}
        if(winMap[path] && winMap[path].object && winMap[path].place==="show"){
            // 如果已经存在window，那么显示在上层
            winMap[path].object.raise()
        }
        else if(winMap[path] && winMap[path].place==='tab'){
            // 如果已经存在tab，关闭，然后开启
            close(path)
            open(path, title)
        }
        else {
            let component = Qt.createComponent("qrc:/main/qml/kit/components/KitWindow.qml");
            if(component.status === Component.Error){
                console.error(component.errorString())
                return
            }
            let p = {key: path, title:qsTr(title)}
            if(config.width){
                p.width = config.width
            }
            if(config.height){
                p.height = config.height
            }
            let obj = component.createObject(null, p)
            winMap[path] = {
                object:obj, place:"show", path, title
            }
            winMap[path].object.show()
        }
    }

    function close(path){
        console.log("close window: ",path)
        if(!winMap[path]) return
        switch(winMap[path].place){
        case "tab":
            for(let i=0;i<tabModels.count;i++){
                if(tabModels.get(i).path === path){
                    // 先指向最后一个
                    tabCurrentIndexChange(tabModels.count-1)
                    tabModels.remove(i,1)
                    break
                }
            }
            break
        case "show":
            break
        }
        delete winMap[path]
    }
}
