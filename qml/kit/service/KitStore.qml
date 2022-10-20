import QtQuick
import QtQuick.Controls

QtObject {
	// id存在时表示user存在
    property var user: ({})
    property var cache:({})

    function put(key, val){
        cache[key] = val
    }

    function del(key){
        delete cache[key]
    }
}
