import QtQuick
import QtQuick.Controls
import FileObject 1.0

QtObject {
    // file.read(url), write(url, data), append(url, data)
    property FileObject file: FileObject{}

    // dt:Date/int/string
    // format: yyyy-MM-dd HH:mm:ss.zzz, yy, ddd MMMM - Tue May，ap-am/pm, AP-AM/PM, h:m:s
    function formatDate(dt,format){
        if(!(dt instanceof Date)){
            dt = new Date(dt)
        }
        if(!format){
            format = "yyyy-MM-dd HH:mm:ss"
        }
        return Qt.formatDateTime(dt, format)
    }

    function leftFill0(num, n) {
        return (new Array(n).join("0") + num).slice(-n)
    }

    function formatMilliseconds(ms, zh) {
        ms = Math.floor(ms)
        let hour = Math.floor(ms / 3600000)
        let min = Math.floor(ms / 60000)
        let sec = Math.floor(ms / 1000)
        min =  min % 60
        sec =  sec % 60
        let ret = ""
        ret+=leftFill0(hour,2)+(zh?"时":":")
        ret+=leftFill0(min,2)+(zh?"分":":")
        ret+=leftFill0(sec,2)+(zh?"秒":"")
      return ret
    }
    function formatArrayMilliseconds(ms) {
        ms = Math.floor(ms)
        let hour = Math.floor(ms / 3600000)
        let min = Math.floor(ms / 60000)
        let sec = Math.floor(ms / 1000)
        hour =  hour
        min =  min % 60
        sec =  sec % 60
      return [leftFill0(hour,2), leftFill0(min,2), leftFill0(sec,2)]
    }
    // dt: Date()
    function formatUTCString(dt){
    	return formatDate(new Date(dt.getTime()+dt.getTimezoneOffset()*60000),"yyyy-MM-ddTHH:mm:ssZ")
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
    function timer(fun, delay, repeat, startRunning, parentPage, exceptionIgnore) {
        if(!parentPage) parentPage = root
        let timer0 = Qt.createQmlObject("import QtQuick; Timer {}", parentPage);
        timer0.interval = delay;
        timer0.repeat = repeat;
        timer0.triggeredOnStart = startRunning
        // 如果函数执行异常，则退出函数
        let fun0 = fun
        if(!exceptionIgnore){
            fun0 = function(){
        		try{
        			fun()
        		}catch(e){
                    console.error("utils.timer error:",e)
        			timer0.stop()
        		}
        	}
        }
        timer0.triggered.connect(fun0)
        timer0.start();
        return timer0
    }

    function findInListModel(model, func){
    	for(let i=0;i<model.count;i++){
    		if(func(model.get(i))) return model.get(i)
    	}
    }

    function delInListModel(model, func){
		for(let i=0;i<model.count;i++){
			if(func(model.get(i))){
				model.remove(i,1)
				delInListModel(model, func)
				break
			}
		}
	}

	function cloneObj(obj){
		let o = {}
		for(let e of Object.keys(obj)){
			o[e] = obj[e]
		}
		return o
	}

	// float转4 bytes, byte为无符号
    function float2bytes(val){
        let farr = new Float32Array(1)
        farr[0] = Number(val)
        let bar = new Uint8Array(farr.buffer)
        return [bar[0], bar[1], bar[2], bar[3]]
    }
}
