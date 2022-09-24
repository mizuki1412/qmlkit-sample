import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    // todo 未成功
    SwipeView {
        id: swipeView
        anchors.fill: parent
        Page2{}
        Page3{}
        Page4{}
    }
    // 页码的提示符号
    PageIndicator {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        currentIndex: swipeView.currentIndex
        count: swipeView.count
    }

}
