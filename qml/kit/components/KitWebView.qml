import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtWebEngine 1.10
import QtWebChannel 1.0

Rectangle{
    id: rect
    // eg: qrc://, file://
    property string url

    signal receive(var data)

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
    }


}
