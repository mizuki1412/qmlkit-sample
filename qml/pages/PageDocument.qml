import QtQuick
import QtQuick.Controls
import Qt.labs.platform 1.0 as NativeDialogs
import "../kit/components"
KitPage {
    id: root
    title: (_fileName.length===0?qsTr("新文件"):_fileName) + (_hasUnsavedChange?"*":"")

    width: 480
    height: 240
    //是否包含未经保存的修改
    property bool _hasUnsavedChange: true
    //文件的路径
    property string _fileName

    //是否已经尝试过关闭
    property bool _tryingToClose: false

    header: ToolBar {
        Row{
            Button {
                text: qsTr("新建")
                onClicked: root.newDocument()
            }
            Button {
                text: qsTr("打开")
                onClicked: openDocument()
            }
            Button {
                text: qsTr("保存")
                onClicked: saveDocument()
            }
            Button{
                text: qsTr("另存为...")
                onClicked: saveAsDocument()
            }
        }
    }

    TextEdit{
        anchors.fill: parent
    }

    function _createNewDocument(){
        var component = Qt.createComponent("qrc:/qml/pages/WindowDemo.qml");
        var window = component.createObject();
        return window;
    }

    //新建一个文档编辑窗口
    function newDocument(){
        var window = _createNewDocument();
        window.show();
    }

    //打开一个新文档
    function openDocument(fileName){
        openDialog.open();
    }

    //文档另存为
    function saveAsDocument(){
        saveAsDialog.open();
    }

    //保存文档
    function saveDocument(){
        if (_fileName.length === 0){
            root.saveAsDocument();
        }
        else{
            root._hasUnsavedChange = false;
            if (root._tryingToClose)
                root.close();
        }
    }

    //打开文件窗口
    NativeDialogs.FileDialog {
        id: openDialog
        title: "打开文件"
        folder: NativeDialogs.StandardPaths.writableLocation(NativeDialogs.StandardPaths.DesktopLocation)
        onAccepted: {
            console.log(openDialog.file)
        }
    }

    //文件另存为窗口
    NativeDialogs.FileDialog {
        id: saveAsDialog
        title: "文件另存为"
        folder: NativeDialogs.StandardPaths.writableLocation(NativeDialogs.StandardPaths.DesktopLocation)
        onAccepted: {
            root._fileName = saveAsDialog.file
            saveDocument();
        }
        onRejected: {
            root._tryingToClose = false;
        }
    }

    //窗口关闭事件的响应函数
//    onClosing: {
//        if (root._hasUnsavedChange) {
//            closeWarningDialog.open();
//            close.accepted = false;
//        }
//    }

    //关闭警告窗口
    NativeDialogs.MessageDialog {
        id: closeWarningDialog
        title: "关闭文件"
        text: "有修改没有保存,需要保存吗?"
        buttons: NativeDialogs.MessageDialog.Yes | NativeDialogs.MessageDialog.No | NativeDialogs.MessageDialog.Cancel
        onYesClicked: {
            //尝试保存
            root._tryingToClose = true;
            root.saveDocument();
        }
        onNoClicked: {
            root._hasUnsavedChange = false;
            root.close()
        }
        onRejected: {
        }
    }
}
