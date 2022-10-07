import QtQuick
import QtQuick.Controls

Rectangle{
    id:comboboxRec
    width:Screen.width
    height:100
    Column{
        Row{
            spacing:$theme.margin
            Label{
                text:"默认"
            }
            ComboBox{
                model:["1","2","3"]
            }
        }
        Row{
            spacing:$theme.margin
            Label{
                text:"Json格式，根据键值选择对象数据"
            }
            ComboBox{
                model:[{key:"key1"},{key:"key2"},{key:"key3"}]
                textRole: "key"
            }
        }
        Row{
            spacing:$theme.margin
            Label{
                text:"Json格式，根据键值选择对象数据"
            }
            ComboBox{
                model:[{key:"key1",value:"1"},{key:"key2",value:"2"},{key:"key3",value:"3"}]
                textRole: "key"
                valueRole:"value"
                Material.background: Material.Green
            }
        }
    }
}
