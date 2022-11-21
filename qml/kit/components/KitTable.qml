import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
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
    // 是否开启多选框
    property bool checkEnabled: false

    // 列配置
    property list<KitTableColumnProperty> properties
    // 数据。 内置key：_checked-checkbox值, _bg-当前单元格的背景色(颜色字符串), _index
    property var dataValue:[]
    property var dataValueOrigin:[]
    // 右键菜单内容，如果空则不开启。 {name, action:function(rowData, rowIndex)}
    property var rightMenuActions: []
    property int rightMenuWidth: 100

    // 选择行 是否变色
    property bool rowSelectBgChange: false
    // 当前选中的index
    property int rowSelectIndex: -1
    // 选择行的事件
    signal rowSelect(var data, int index)
    signal rowDoubleClick(var data, int index)
    // checked changed
	signal checkedChange

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
        if(checkEnabled) leave -= checkboxWidth
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
        _fWidth = fWidth+table_rect.spacing*(freezeLeftIndex>0?freezeLeftIndex:0)+(checkEnabled?checkboxWidth:0)
//        console.log(_cWidth, _cHeight, _fWidth, table_rect.width)
//        console.log(_fWidth+_cWidth<=table_rect.width)
    }
    function _refreshData(){
    	for(let ele of dataValue){
    		ele["_checked"] = ele["_checked"]?true:false
    		if(_showLeftFreeze){
				tablef_body_model.append(ele)
			}
			table_body_model.append(ele)
    	}
    }
    function setData(dataArray){
        for(let i=0;i<dataArray.length;i++){
            dataArray[i]["_index"] = i
        }
    	clear()
    	dataValue = dataArray
    	dataValueOrigin = dataArray
    	_refreshData()
    	init()
    }
    function addData(ele){
    	ele["_checked"] = ele["_checked"]?true:false
        ele["_index"] = dataValue.length
    	dataValue.push(ele)
    	dataValueOrigin.push(ele)
    	if(_showLeftFreeze){
    		tablef_body_model.append(ele)
    	}
    	table_body_model.append(ele)
//    	init()
//    	_refreshData()
    }
    function clear(){
    	checkboxRoot.checkState = 0
    	if(_showLeftFreeze){
			tablef_body_model.clear()
		}
		table_body_model.clear()
		dataValue = []
		dataValueOrigin = []
		init()
    }
    function getCheckedList(){
    	return dataValue.filter(x=>x["_checked"])
    }
    // 修改checkbox总的状态: cd true/false
	function changeAllChecked(cd){
		tablef_body_model.clear()
		for(let i=0; i<dataValue.length; i++){
			dataValue[i]["_checked"] = cd?true:false
//    		tablef_body_model.get(i)["_checked"] = cd?true:false
//    		tablef_body_model.setProperty(i, "_checked", cd?true:false)
			tablef_body_model.append(dataValue[i])
		}
		checkboxRoot.checkState = 0
	}
    onWidthChanged: {
        init()
    }

    // 内容宽（不包含冻结）
    property int _cWidth: 0
    property int _cHeight: 0
    // 冻结部分宽
    property int _fWidth: 0
//	property alias checkboxGroupState: checkboxGroup.checkState
	property int checkboxWidth: 40
	// 是否显示左冻结的条件
	property bool _showLeftFreeze: freezeLeftIndex>-1 || checkEnabled

	function sortHandle(index){
		// todo
		let h = properties[index]
		if(!h) return
        console.log(h._sortableUp, h._sortableUp,h.key)
		dataValue.sort((x,y)=>{
            if(h._sortableUp){
                return x[h.key]>y[h.key]?1:(x[h.key]<y[h.key]?-1:0)
            }else if(h._sortableDown){
                return x[h.key]>y[h.key]?-1:(x[h.key]<y[h.key]?1:0)
            }else{
                return x["_index"]>y["_index"]?1:(x["_index"]<y["_index"]?-1:0)
            }
		})
        if(_showLeftFreeze){
            tablef_body_model.clear()
        }
        table_body_model.clear()
        _refreshData()
        init()
	}
	Component.onCompleted:{

	}

    // 左冻结部分
    Item{
        visible: _showLeftFreeze
        id: tablef
        width: _fWidth
        height: parent.height
        // header
        RowLayout{
            id: tablef_header
            spacing: table_rect.spacing
			Rectangle{
				visible: checkEnabled
            	Layout.preferredWidth: checkboxWidth
            	Layout.preferredHeight: cellHeight
            	color: $theme.table_header_bg
            	Rectangle{
            		anchors.centerIn: parent
            		width: $theme.font_base
            		height: $theme.font_base
            		radius: 2
            		color: $theme.color_bg
            	}
            	CheckBox {
                    id: checkboxRoot
            		anchors.centerIn: parent
            		Material.theme: Material.Light
//            		checkState: checkboxGroup.checkState
            		onClicked:{
						tablef_body_model.clear()
						for(let i=0; i<dataValue.length; i++){
							dataValue[i]["_checked"] = this.checked
							tablef_body_model.append(dataValue[i])
						}
						table_rect.checkedChange()
					}
					Connections{
						target: table_rect
						function onCheckedChange(){
							let s1 = dataValue.filter(x=>x["_checked"])
							if(s1.length===0) checkboxRoot.checkState=0
							else if(s1.length===dataValue.length) checkboxRoot.checkState=2
							else checkboxRoot.checkState=1
						}
					}
            	}
 			}
            Repeater{
                model: freezeLeftIndex+1
                KitTableRepeatHeader{
					_index: index
				}
            }
        }
        // body
        ListView{
            // 上下滑动 宽固定
            anchors.top: tablef_header.bottom
            anchors.topMargin: table_rect.spacing
            anchors.bottom: parent.bottom
            width: parent.width
//            contentWidth: width
//            contentHeight: _cHeight-tablef_header.height
            clip:true
            model: ListModel{
            	id: tablef_body_model
            	dynamicRoles: true
            }
            ScrollBar.vertical: ScrollBar{
                visible: false
                id: tablef_scroll
                onPositionChanged:{
                    table_scroll.position = position
                }
            }
            delegate: RowLayout{
				spacing:  table_rect.spacing
				property var rIndex: index
				property var rModel: model
				Rectangle{
					visible: checkEnabled
					Layout.preferredWidth: checkboxWidth
					Layout.preferredHeight: cellHeight
					color: {
						if(rModel["_bg"]){
							return rModel["_bg"]
						}
						else if(rowSelectBgChange && rIndex===rowSelectIndex){
							return $theme.table_select_bg
						}
						else{
							return rIndex%2===0?$theme.table_data_bg1:$theme.table_data_bg2
						}
					}
					// 底色
					Rectangle{
						anchors.centerIn: parent
						width: $theme.font_base
						height: $theme.font_base
						radius: 2
						color: $theme.color_bg
					}
					CheckBox {
						anchors.centerIn: parent
						Material.theme: Material.Light
//						ButtonGroup.group: checkboxGroup
						Component.onCompleted:{
							// listview有重绘机制，model直接修改无效？
							this.checked = dataValue[rIndex]["_checked"]
						}
						onCheckedChanged:{
							dataValue[rIndex]["_checked"] = this.checked
							table_rect.checkedChange()
						}
					}
				}
				Repeater{
					model: freezeLeftIndex+1
					KitTableRepeatBody{
						_index: index
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
        ListView{
            // 上下滑动 宽固定
            anchors.top: t1.bottom
            anchors.topMargin: table_rect.spacing
            anchors.bottom: parent.bottom
            width: parent.width
//            contentWidth: width
//            contentHeight: _cHeight-t1.height
            clip:true
            ScrollBar.vertical: ScrollBar {
                id: table_scroll
                visible:false
                onPositionChanged:{
                    tablef_scroll.position = position
                }
            }
            model: ListModel{
            	id: table_body_model
            	dynamicRoles: true
            }
            delegate: RowLayout{
			  	spacing: table_rect.spacing
			  	property var rIndex: index
			  	property var rModel: model
			  	Repeater{
				  	model: properties.length-freezeLeftIndex-1
				  	KitTableRepeatBody{
						_index: index+freezeLeftIndex+1
					}
			  }
		  	}
        }
    }

    // 冻结和主体 阴影部分
	Rectangle{
		visible: _fWidth>0 && _fWidth+_cWidth>table_rect.width
		anchors.left: tablef.right
		width: 8
		height: parent.height>_cHeight?_cHeight:parent.height
		gradient: Gradient{
			orientation: Gradient.Horizontal
			GradientStop {position: 0; color:$color.rgba("#0E1021",0.9)}
			GradientStop {position: 1; color:$color.rgba("#0E1021",0)}
		}
	}
}
