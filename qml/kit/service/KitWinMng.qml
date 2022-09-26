import QtQuick 2.15
 import QtQml.Models 2.15

QtObject {
    // path: {path,title,object, place:tab/show}
    property var winMap:({})
    // winMng对象数组
    property ListModel tabModels: ListModel{}

    // 通知修改tab的currentIndex
    signal tabCurrentIndexChange(int index)

    // 显示到tab中
    function tab(path,title){
        if(!winMap[path]){
            winMap[path] = {place:"",path, title}
        }

        if(winMap[path].place==="tab"){
            for(let i=0;i<tabModels.count;i++){
                if(tabModels.get(i).path === path){
                    tabCurrentIndexChange(i)
                    break
                }
            }
        }
        else{
            winMap[path].place = "tab"
            tabModels.append(winMap[path])
            tabCurrentIndexChange(tabModels.count-1)
        }
    }

    // title:windows的, config:{width, height}
    function open(path,title,config){
        if(!config) config = {}
        if(!winMap[path]){
            let component = Qt.createComponent("qrc:/kit/components/KitWindow.qml");
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
                object:obj, place:"", path, title
            }
        }
        if(winMap[path].object && winMap[path].place==="show"){
            // 如果已经存在window，那么显示在上层
            winMap[path].object.raise()
        }
        else if(winMap[path].place==='tab'){
            // 如果已经存在tab，那么显示tab
            tab(path, title)
        }
        else if(winMap[path].object){
            winMap[path].place = "show"
            winMap[path].object.show()
        }

    }

    function close(path){
        console.log("close window: ",path)
        delete winMap[path]
    }
}
