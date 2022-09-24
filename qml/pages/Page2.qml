import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    header: Label {
        text: qsTr("Demo2")
        padding: 10
    }
    Rectangle{
        color: $color.orange100
        width: parent.width
        height: 100
        Item{
            Text {
                id: name
                text: qsTr("text")
            }
        }
    }

}
