import QtQuick
import QtQuick.Controls

QtObject {

    // dt:Date/int/string
    // format: yyyy-MM-dd HH:mm:ss.zzz, yy, ddd MMMM - Tue May，ap-am/pm, AP-AM/PM, h:m:s
    function formatDate(dt,format){
        if(!(dt instanceof Date)){
            dt = new Date(dt)
        }
        return Qt.formatDateTime(dt, format)
    }

    function decodeBase64(data){
        return Qt.atob(data)
    }

    function encodeBase64(bytes){
        return Qt.btoa(bytes)
    }

    function md5(data){
        return Qt.md5(data)
    }

    // bytes预处理. dataview.getFloat32()....
    function bytesView(bytes) {
        var view = new DataView(new ArrayBuffer(bytes.length));
        for (var i = 0; i < bytes.length; i++) {
            view.setUint8(i, bytes[i]);
        }
        return view;
    }

    // 定时器或settimeout: repeat:bool, startRunning:bool
    function timer(fun, delay, repeat, startRunning) {
        let timer = Qt.createQmlObject("import QtQuick; Timer {}", root);
        timer.interval = delay;
        timer.repeat = repeat;
        timer.triggeredOnStart = startRunning
        timer.triggered.connect(fun)
        timer.start();
        return timer
    }
}
