import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../"

// 标题单元 横向
Rectangle{
	property int _index
	Layout.preferredWidth: properties[_index]._width
	Layout.preferredHeight: headerHeight
	color: $theme.table_header_bg
	KitTableCell{
		id: table_tv
		anchors.rightMargin: properties[_index].sortable?14:0
		type: "title"
		// 点击排序
        MouseArea{
            anchors.fill: parent
            onClicked:{
                if(!sortable) return
                let oldUp = properties[_index]._sortableUp
                let oldDown = properties[_index]._sortableDown
                for(let i=0;i<properties.length;i++){
                    let e = properties[i]
                    e._sortableUp = false
                    e._sortableDown = false
                }
                if(!oldUp && !oldDown){
                    properties[_index]._sortableUp = true
                    properties[_index]._sortableDown = false
                }else if(oldUp){
                    properties[_index]._sortableUp = false
                    properties[_index]._sortableDown = true
                }else{
                    properties[_index]._sortableUp = true
                    properties[_index]._sortableDown = false
                }
                sortHandle(_index)
            }
        }
	}
	Item{
		id: sortIcons
//		visible: properties[_index].sortable
		visible: true
        anchors.right: parent.right
        width: 12
        height: parent.height
		anchors.verticalCenter: parent.verticalCenter
		anchors.rightMargin: 12
		ColumnLayout{
			anchors.fill:parent
			spacing: 0
			Item{Layout.fillHeight: true}
			KitIcon{
				size: 12
				text: "\ue7b8"
//                color: properties[_index]._sortableUp?$theme.color_primary:$theme.color_text_inactive
                color: $theme.color_primary
                visible: properties[_index]._sortableUp?true:false
//				MouseArea{
//					anchors.fill:parent
//					cursorShape: Qt.PointingHandCursor
//					onClicked:{
//						let old = properties[_index]._sortableUp
//                        for(let i=0;i<properties.length;i++){
//                            let e = properties[i]
//							e._sortableUp = false
//							e._sortableDown = false
//						}
//                        properties[_index]._sortableUp = !old
//                        sortHandle(_index)
//					}
//				}
			}
			KitIcon{
				size: 12
				text: "\ue625"
//				color: properties[_index]._sortableDown?$theme.color_primary:$theme.color_text_inactive
                color: $theme.color_primary
				visible: properties[_index]._sortableDown?true:false
//				MouseArea{
//					anchors.fill:parent
//					cursorShape: Qt.PointingHandCursor
//					onClicked:{
//						let old = properties[_index]._sortableDown
//                        for(let i=0;i<properties.length;i++){
//                            let e = properties[i]
//							e._sortableUp = false
//							e._sortableDown = false
//						}
//						properties[_index]._sortableDown = !old
//						sortHandle(_index)
//					}
//				}
			}
			Item{Layout.fillHeight: true}
		}

	}
	Component.onCompleted:{
		table_tv.value = properties[_index].name
		table_tv.align = properties[_index].align
        table_tv.alignTitle = properties[_index].alignTitle
	}
}
