import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../kit/components"
KitPage {
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
