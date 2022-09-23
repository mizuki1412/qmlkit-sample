import QtQuick 2.15
import Qt.labs.settings 1.0

Settings
{
    id:setting
    fileName:"./setting.ini"

    property var home_path
    property var mqtt_broker
    property var mqtt_port
    property var request_url
}
