import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "./table"

Rectangle{
    id: table_rect
    color: "transparent"

    property int cellHeight: 40
    // 边框 即间隙
	property int spacing: 0
    // 左冻结的index
    property int freezeLeftIndex:-1
    // 右冻结的index todo
    property int freezeRightIndex:-1
    // 列配置
    property list<KitTableColumnProperty> properties
    // 数据
    property var dataValue:[]
    // 右键菜单内容，如果空则不开启。 {name, action:function(rowData, rowIndex)}
    property var rightMenuActions: []
    property int rightMenuWidth: 100

    property ListModel dataList: ListModel{}
    Component.onCompleted:{init();refreshData()}
    function init(){
        // 冻结的个数必须小于总个数
        if(freezeLeftIndex>=0 && properties.length<=(freezeLeftIndex+1)){
            freezeLeftIndex = -1
            console.error("冻结小标范围错误")
            return
        }
        // 视图总宽，包括了冻结部分
        let sum = table_rect.width
        let leave = sum
        // 用来平分的个数
        let divCount = 0
        for(let i1=0;i1<properties.length;i1++){
            let e1 = properties[i1]
            if(e1.fixWidth) {
                leave -= e1.fixWidth
            }else{
                divCount++
            }
        }
        // 平分后每个宽
        let divWidth = 0
        if(leave<0) leave = 0
        if(divCount>0){
            divWidth = leave/divCount
        }
        // 实际的总宽
        let actSum = 0
        for(let i2=0;i2<properties.length;i2++){
            let e2 = properties[i2]
            if(e2.fixWidth){
                e2._width = e2.fixWidth
            }else if(e2.minWidth){
                e2._width = e2.minWidth>divWidth?e2.minWidth:divWidth
            }else{
                e2._width = divWidth
            }
            // console.log("宽cell",e2._width)
            actSum += e2._width
        }
        // 实际冻结宽
        let fWidth = 0
        for(let i0=0;i0<=freezeLeftIndex;i0++){
            actSum -= properties[i0]._width
            fWidth += properties[i0]._width
        }
        // 计算spacing的宽
        let spacingW = 0
        if(freezeLeftIndex>=0){
			if(properties.length-freezeLeftIndex-1>1){
				spacingW = table_rect.spacing*(properties.length-freezeLeftIndex-1-1)
			}
        }else{
        	spacingW = table_rect.spacing*properties.length
        }
        // 这个宽是滑动部分的宽，不包含冻结的
        _cWidth = actSum + spacingW
        // 表头+body的总高. 目前未计算外边框
        _cHeight = cellHeight*(dataValue.length+1)+table_rect.spacing*dataValue.length
        _fWidth = fWidth+(freezeLeftIndex>0?freezeLeftIndex:0)
        // console.log(_cWidth, _cHeight, _fWidth)
    }
    function refreshData(){
    	dataList.clear()
    	for(let e of dataValue){
    		dataList.append(e)
    	}
    }
    function setData(dataArray){
    	dataValue = dataArray
    	init()
    	refreshData()
    }
    function addData(ele){
    	dataValue.push(ele)
    	init()
    	refreshData()
    }
    onWidthChanged: {
        init()
    }

    // 内容宽（不包含冻结）
    property int _cWidth: 0
    property int _cHeight: 0
    // 冻结部分宽
    property int _fWidth: 0

    // 左冻结部分
    Item{
        visible: freezeLeftIndex>-1
        id: tablef
        width: _fWidth
        height: parent.height
        // header
        RowLayout{
            id: tablef_header
            spacing: table_rect.spacing
            Repeater{
                model: freezeLeftIndex+1
                KitTableRepeatHeader{
					_index: index
				}
            }
        }
        // body
        Flickable{
            // 上下滑动 宽固定
            anchors.top: tablef_header.bottom
            anchors.topMargin: table_rect.spacing
            anchors.bottom: parent.bottom
            width: parent.width
            contentWidth: width
            contentHeight: _cHeight-tablef_header.height
            clip:true
            ScrollBar.vertical: ScrollBar{
                visible: false
                id: tablef_scroll
                onPositionChanged:{
                    table_scroll.position = position
                }
            }
            ColumnLayout{
                spacing: table_rect.spacing
                Repeater{
                    model: dataList
                    RowLayout{
                        id: tablef_repeat
                        spacing:  table_rect.spacing
                        property var rIndex: index
                        property var rModel: model
                        Repeater{
                            model: freezeLeftIndex+1
                            KitTableRepeatBody{
                                _index: index
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons: Qt.RightButton
                                    onClicked: {
                                        if(rightMenuActions.length===0) return
                                        rightMenu.rowData = rModel
                                        rightMenu.rowIndex = rIndex
                                        rightMenu.popup();
                                    }
                                }
							}
                        }
                    }
                }
            }
        }
    }

    // 主体部分
    Flickable{
        // 左右滑动 高固定
        anchors.left: tablef.right
//        anchors.leftMargin: _fWidth?1:0
        anchors.right: parent.right
        height: parent.height
        contentHeight: height
        contentWidth: _cWidth
        clip: true
        ScrollBar.horizontal: ScrollBar { visible:_cWidth>width }
        // header
        RowLayout{
            id: t1
            spacing: table_rect.spacing
            Repeater{
                model: properties.length-freezeLeftIndex-1
                KitTableRepeatHeader{
                	_index: index+freezeLeftIndex+1
                }
            }
        }
        // body
        Flickable{
            // 上下滑动 宽固定
            anchors.top: t1.bottom
            anchors.topMargin: table_rect.spacing
            anchors.bottom: parent.bottom
            width: parent.width
            contentWidth: width
            contentHeight: _cHeight-t1.height
            clip:true
            ScrollBar.vertical: ScrollBar {
                id: table_scroll
                visible:false
                onPositionChanged:{
                    tablef_scroll.position = position
                }
            }
            ColumnLayout{
                spacing: table_rect.spacing
                Repeater{
                    model: dataList
                    RowLayout{
                        spacing: table_rect.spacing
                        id: table_repeat
                        property var rIndex: index
                        property var rModel: model
                        Repeater{
                            model: properties.length-freezeLeftIndex-1
                            KitTableRepeatBody{
								_index: index+freezeLeftIndex+1
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons: Qt.RightButton
                                    onClicked: {
                                        if(rightMenuActions.length===0) return
                                        rightMenu.rowData = rModel
                                        rightMenu.rowIndex = rIndex
                                        rightMenu.popup();
                                    }
                                }
							}
                        }


                    }
                }
            }
        }
    }

    // 冻结和主体 阴影部分
	Rectangle{
		visible: _fWidth>0
		anchors.left: tablef.right
		width: 8
		height: parent.height>_cHeight?_cHeight:parent.height
		gradient: Gradient{
			orientation: Gradient.Horizontal
			GradientStop {position: 0; color:$color.rgba("#0E1021",0.9)}
			GradientStop {position: 1; color:$color.rgba("#0E1021",0)}
		}
	}

	// 右键菜单
    Menu {
		id: rightMenu
        property var rowData
        property int rowIndex
		Repeater{
            model: rightMenuActions.length
			MenuItem {
				id: item
                text: qsTr(rightMenuActions[index].name)
				background: Rectangle{
                    implicitWidth: rightMenuWidth
					gradient: Gradient{
                        orientation: Gradient.Horizontal
                        GradientStop{position: 1; color:$color.rgba("#5293FF", item.highlighted?1:0)}
                        GradientStop{position: 0; color:$color.rgba("#62BDFF", item.highlighted?1:0)}
                    }
				}
				onTriggered: {
                    rightMenuActions[index].action(rightMenu.rowData,rightMenu.rowIndex)
				}
			}
		}
		background: Rectangle{
            implicitWidth: rightMenuWidth
            color: $color.rgba("#0E1021", 0.89)
            radius: 4
		}
	}

}
