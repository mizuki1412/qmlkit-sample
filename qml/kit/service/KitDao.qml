
import QtQuick
import "../config"

QtObject{

    property var settings: KitSettings{
        id:settings
    }
    property var messageComponent: Qt.createComponent("qrc:/main/qml/kit/components/KitMessage.qml")
    property var confirmComponent: Qt.createComponent("qrc:/main/qml/kit/components/KitConfirm.qml")
    property var loadingComponent: Qt.createComponent("qrc:/main/qml/kit/components/KitLoading.qml")

    // options: { parentPage, message }
    function showMessage(options) {
        if (messageComponent.status === Component.Ready){
            let sprite = messageComponent.createObject(options.parentPage, {anchors:{centerIn: options.parentPage}});
            if (sprite === null){
                console.log("Error creating object");
            }else{
                sprite.setMessage(options.message)
                sprite.open()
            }
        }
        else if (messageComponent.status === Component.Error){
            console.log("Error loading component:", messageComponent.errorString());
        }
    }

    // options:{ parentPage, confirmFun, message }
    function showConfirm(options) {
        if (confirmComponent.status === Component.Ready){
            let sprite = confirmComponent.createObject(options.parentPage, {anchors:{centerIn: options.parentPage}});
            if (sprite === null){
                console.log("Error creating object");
            }else{
                sprite.setMessage(options.message)
                sprite.setConfirmFun(options.confirmFun)
                sprite.open()
            }
        }
        else if (confirmComponent.status === Component.Error){
            console.log("Error loading component:", confirmComponent.errorString());
        }
    }

    //等待转圈
    function showLoading(parentPage) {
        if (loadingComponent.status === Component.Ready){
            let sprite = loadingComponent.createObject(parentPage, {anchors:{centerIn: parentPage}});
            if (sprite === null){
                console.log("Error creating object");
            }else{
                sprite.open()
            }
            return sprite
        }
        else if (loadingComponent.status === Component.Error){
            console.log("Error loading component:", loadingComponent.errorString());
        }
    }

    /**
     * options:
     *  urlHost:
     **  urlPath
     *  method:post
     **  params: {key:value} 键值对，请求参数
     **  parentPage:
     **  ignoreLoading:bool 不干预转圈
     *
     */
    function request(options,callback) {
        let xhr = new XMLHttpRequest()
        if(!options || !options.urlPath || options.urlPath.indexOf("/")!==0){
            throw new Error("request options error")
        }
        if(!options.method) options.method = "POST"
        if(!options.urlHost) options.urlHost=settings.request_url
        if(!options.ignoreLoading && options.parentPage){
            options._loading = showLoading(options.parentPage)
        }
        xhr.onreadystatechange=function(){
            if(xhr.readyState===XMLHttpRequest.DONE){
                if(options._loading) options._loading.close()
                if(callback){
                    let res
                    try{
                        res = JSON.parse(xhr.responseText.toString())
                    }catch(eee){
                        console.error(eee)
                        showMessage({
                                        parentPage: options.parentPage,
                                        message: xhr.responseText.toString()
                                    })
                    }
                    if(res.result===0){
                        showMessage({
                                        parentPage: options.parentPage,
                                        message: res.message
                                    })
                    }else if(res.result===2){
                        showMessage({
                                        parentPage: options.parentPage,
                                        message: "登录失效"
                                    })
                        // todo 跳转登录界面
                    }else if(res.result===1){
                        callback(res)
                    }else{
                        showMessage({
                                        parentPage: options.parentPage,
                                        message: xhr.responseText.toString()
                                    })
                    }

                }
            }
        }
        try{
            xhr.open(options.method,options.urlHost+options.urlPath)
            xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded')
            xhr.setRequestHeader('Accept','application/json')
            //  xhr.setRequestHeader('Cookie','sessionID=')
            xhr.withCredentials = true
            let paramString = ""
            if(options.params){
                for(let ee of Object.keys(options.params)){
                    if(paramString!==""){
                        paramString += "&"
                    }
                    if(options.params[ee]!==null && options.params[ee]!==undefined){
                        paramString += ee+"="+encodeURIComponent(options.params[ee])
                    }
                }
            }
            xhr.send(paramString)
        }catch(e){
            console.error(e)
            if(options._loading) options._loading.close()
        }
    }

    /**
      * 请求带确认
      * options:
      *     parentPage
      *     message
      */
    function confirm(options, callback){
        if(!callback) {
            callback = function(){}
        }
        options.confirmFun = callback
        showConfirm(options)
    }


}

