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
    // 省略中间的个数
    property int ellipsisThreshold: 2
    property int pageSize: all/countOnePage+1

    function refreshBtn() {
        var model = []
        // 1,2,3,4,5,6,...,100
        // 1,...,4,5,6,7,8,...,100
        // 1,...,95,96,97,98,99,100
        if (pageSize <= 1+(ellipsisThreshold*2+1)+1) {
            for (let i=0; i<pageSize; i++){
                model.push({number: i+1, selected: currentValue === i + 1}) //number：显示值，selected：是否选中
            }
        } else {
            model.push({number: 1, selected: currentValue === 1})
            //判断第2个位置是否是省略号，number为-1表示省略号
            model.push({number: currentValue - ellipsisThreshold > 2 ? -1 : 2, selected: currentValue === 2});
            //向currentValue两边分别添加2个值
            for (let k = Math.max(2+1, currentValue - ellipsisThreshold); k <= Math.min(pageSize - 1 - 1, currentValue + ellipsisThreshold); k++) {
                model.push({number: k, selected: currentValue === k});
            }
            //判断第pageSize-2位置是否是省略号
            model.push({number: currentValue + ellipsisThreshold < pageSize - 1 ? -2 : pageSize - 1, selected: currentValue === pageSize - 1});
            //插入pageSize-1,pageSize
            model.push({number: pageSize, selected: currentValue === pageSize})
        }
        btnGroup.model = model
    }
    onPageSizeChanged: {
        if (pageSize < 1) {
            pageSize = 1
        }
        if(currentValue>pageSize || currentValue<=0){
        	currentValue = 1
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
            text: modelData.number < 0 ? "..." : String(modelData.number)
            highlight: modelData.selected
//            disabled: modelData.number === -1 // 禁用省略号
            onClicked: {
                if(btnGroup.model[index].number===-1){
                    currentValue -= ellipsisThreshold*2+1
                } else if(btnGroup.model[index].number===-2){
                    currentValue += ellipsisThreshold*2+1
                }else{
                    currentValue = btnGroup.model[index].number
                }
                if(currentValue<=0){
                    currentValue = 1
                }
                if(currentValue>pageSize){
                    currentValue = pageSize
                }
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
