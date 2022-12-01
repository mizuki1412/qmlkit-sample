import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
	id: pg
    spacing: 8
    height: 28*1.5
    Layout.preferredHeight: height

    // 当前页码
    property int currentValue: 1
    property int all: 1
    property int countOnePage: 20
    // 字体大小
    property int fontSize: 12

    property int pageSize: all/countOnePage+1
    function refreshBtn() {
        var model = []
        if (pageSize < 5) { //小于10直接全部显示
            for (let i=0; i<pageSize; i++){
                model.push({number: i+1, selected: currentValue === i + 1}) //number：显示值，selected：是否选中
            }
        } else {
            //插入1,2
            [1, 2].map(v => model.push({number: v, selected: currentValue === v}));
            //判断第3个位置是否是省略号，number为-1表示省略号
            model.push({number: currentValue - 2 > 1 + 3 ? -1 : 1 + 2, selected: currentValue === 3});
            //向currentValue两边分别添加2个值
            for (let k = Math.max(1 + 3, currentValue - 2); k <= Math.min(pageSize - 3, currentValue + 2); k++) {
                model.push({number: k, selected: currentValue === k});
            }
            //判断第pageSize-2位置是否是省略号
            model.push({number: currentValue + 2 < pageSize - 3 ? -1 : pageSize - 2, selected: currentValue === pageSize - 2});
            //插入pageSize-1,pageSize
            [pageSize - 1, pageSize].map(v => model.push({number: v, selected: currentValue === v}));
        }
        btnGroup.model = model
    }
    onPageSizeChanged: {
        currentValue = 1
        if (pageSize < 1) {
            pageSize = 1
        }
        refreshBtn()
    }

	Item{Layout.fillWidth: true}
	Text{
		text: qsTr("共"+all+"条")
		font.pixelSize: pg.fontSize
		color: $theme.color_text_inactive
	}
    Button {
        font.family: $iconfont.family
		font.pixelSize: 18
		text: "\ue603"
		flat:true
        Layout.preferredWidth: 32
        enabled: currentValue>1
        onClicked: {
            if (currentValue - 1 >= 1) {
                currentValue--
                refreshBtn()
            }
        }
    }
    Repeater {
        id: btnGroup
        model: [{number: 1, selected: true}]
        delegate: KitButton {
            Layout.preferredWidth: this.contentWidth
            Layout.preferredHeight: pg.height/1.5
            size: pg.fontSize
            text: modelData.number === -1 ? "..." : String(modelData.number)
            highlight: modelData.selected
            disabled: modelData.number === -1 //禁用省略号
            onClicked: {
                currentValue = btnGroup.model[index].number
                refreshBtn()
            }
        }
    }
    Button {
    	font.family: $iconfont.family
    	font.pixelSize: 18
        text: "\ue61f"
        flat:true
        Layout.preferredWidth: 24
        enabled: currentValue<pageSize
        onClicked: {
            if (currentValue + 1 <= pageSize) {
                currentValue++
                refreshBtn()
            }
        }
    }
    Item{Layout.fillWidth: true}
}
