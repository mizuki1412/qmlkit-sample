import QtQuick
import Qt.labs.settings

Settings{
    id:setting
    fileName:"./setting.ini"

    property var home_path
    property var mqtt_broker
    property var mqtt_port
    property var request_url
    property int width: 1100
    property int height: 800
}
