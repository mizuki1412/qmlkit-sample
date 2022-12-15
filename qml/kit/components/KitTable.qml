import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import "./table"

Rectangle{
    id: table_rect
    color: "transparent"

    property int cellHeight: 40
    property int headerHeight: 40
    // 边框 即间隙
	property int spacing: 0
    // 左冻结的index
    property int freezeLeftIndex:-1
    // 右冻结的index todo
    property int freezeRightIndex:-1
    // 是否开启多选框
    property bool checkEnabled: false
    // 是否开启分页
    property bool pagination: true
    // 分页时，一页个数
    property int countOnePage: 20

    // 列配置
    property list<KitTableColumnProperty> properties
    // 数据。 内置key：_checked-checkbox值, _bg-当前单元格的背景色(颜色字符串), _index
    property var dataValue:[]
    property var dataValueOrigin:[]
    // 右键菜单内容，如果空则不开启。 {name, 点击调用action:function(rowData, rowIndex), 是否显示visible:function(row,i){}}
    property var rightMenuActions: []
    // 右键菜单函数提供 (rowData,rowIndex)=>{return []}
    property var rightMenuActionFun
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
        _cHeight = cellHeight*(dataValue.length)+headerHeight+table_rect.spacing*dataValue.length
        _fWidth = fWidth+table_rect.spacing*(freezeLeftIndex>0?freezeLeftIndex:0)+(checkEnabled?checkboxWidth:0)
//        console.log(_cWidth, _cHeight, _fWidth, table_rect.width)
//        console.log(_fWidth+_cWidth<=table_rect.width)
    }
    function _refreshData(){
    	if(_showLeftFreeze){
			tablef_body_model.clear()
		}
		table_body_model.clear()
    	for(let ele of dataValue){
    		ele["_checked"] = ele["_checked"]?true:false
    		if(_showLeftFreeze){
				tablef_body_model.append(ele)
			}
			table_body_model.append(ele)
    	}
    }
    // 外部赋值
    function setData(dataArray){
        for(let i=0;i<dataArray.length;i++){
            dataArray[i]["_index"] = i
        }
    	checkboxRoot.checkState = 0
		if(_showLeftFreeze){
			tablef_body_model.clear()
		}
		table_body_model.clear()
    	dataValueOrigin = dataArray
    	if(pagination){
    		_paginationHandle()
    	}else{
    		dataValue = dataArray
    	}
    	_refreshData()
    	init()
    }
    // todo 该函数谨慎调用 暂不联动分页
    function addData(ele){
    	ele["_checked"] = ele["_checked"]?true:false
        ele["_index"] = dataValue.length
    	dataValue.push(ele)
    	dataValue = dataValue
    	dataValueOrigin.push(ele)
    	if(_showLeftFreeze){
    		tablef_body_model.append(ele)
    	}
    	table_body_model.append(ele)
    }
    // 暂不用
    function clear(){
    	checkboxRoot.checkState = 0
    	if(_showLeftFreeze){
			tablef_body_model.clear()
		}
		table_body_model.clear()
		dataValue = []
		dataValueOrigin = []
		kp.currentValue = 1
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
    function _paginationHandle(){
    	dataValue = dataValueOrigin.slice((kp.currentValue-1)*countOnePage, (kp.currentValue-1)*countOnePage+countOnePage)
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
	property alias _headerHeight: t1.height

	function sortHandle(index){
		let h = properties[index]
		if(!h) return
		dataValueOrigin.sort((x,y)=>{
            if(h._sortableUp){
                return x[h.key]>y[h.key]?1:(x[h.key]<y[h.key]?-1:0)
            }else if(h._sortableDown){
                return x[h.key]>y[h.key]?-1:(x[h.key]<y[h.key]?1:0)
            }else{
                return x["_index"]>y["_index"]?1:(x["_index"]<y["_index"]?-1:0)
            }
		})
        if(pagination){
        	_paginationHandle()
        }else{
        	dataValue = dataValueOrigin
        }
        _refreshData()
        init()
	}

    // 左冻结部分
    Item{
        visible: _showLeftFreeze
        id: tablef
        width: _fWidth
        height: parent.height - kp.height
        // header
        RowLayout{
            id: tablef_header
            spacing: table_rect.spacing
			Rectangle{
				visible: checkEnabled
            	Layout.preferredWidth: checkboxWidth
            	Layout.preferredHeight: headerHeight
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
						if(rowSelectBgChange && rIndex===rowSelectIndex){
							return $theme.table_select_bg
						}
						else{
							if(rModel["_bg"]){
								return rModel["_bg"]
							}
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
							if(dataValue && dataValue[rIndex]) this.checked = dataValue[rIndex]["_checked"]
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
        height: parent.height - kp.height
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
		height: (parent.height-kp.height)>_cHeight?_cHeight:(parent.height-kp.height)
		gradient: Gradient{
			orientation: Gradient.Horizontal
			GradientStop {position: 0; color:$color.rgba("#0E1021",0.9)}
			GradientStop {position: 1; color:$color.rgba("#0E1021",0)}
		}
	}

	// data empty
	Text{
	    anchors.top: parent.top
	    anchors.topMargin: _headerHeight*2
	    width: parent.width
	    horizontalAlignment: Text.AlignHCenter
	    visible: dataValue.length===0
	    text: qsTr("暂无数据")
	    color: $theme.color_text_inactive
	}

	KitPagination{
		id: kp
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom
        visible:pagination
		all: dataValueOrigin.length
		countOnePage: parent.countOnePage
		onCurrentValueChanged:{
			_paginationHandle()
			_refreshData()
			init()
		}
	}
}
