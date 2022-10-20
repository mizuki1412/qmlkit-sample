import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebEngine
import QtWebChannel

Rectangle{
    id: rect
    // eg: qrc:///（必须///）, file:///
    property string url

    signal receive(var data)
    signal loaded()

    // data:Object,  {type:"", data:()}
    function send(type, data){
        qtObject.send(JSON.stringify({type, data}))
    }

    QtObject {
        id: qtObject
        WebChannel.id: "channelqtObject"

        signal send(var jsonData)

        function receive(data){
            rect.receive(JSON.parse(data))
        }
    }

    WebChannel {
        id: myChannel
        registeredObjects: [qtObject]
    }

    WebEngineView {
        id:webQues
        anchors.fill:parent
        webChannel: myChannel
        smooth: true
        url: rect.url
        onLoadProgressChanged: {
            if(this.loadProgress===100){
                rect.loaded()
            }
        }
    }


}
