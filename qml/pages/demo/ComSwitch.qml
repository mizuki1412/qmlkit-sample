import QtQuick
import QtQuick.Controls
import "../../kit/components-undo"
Rectangle{
    height:100
    width:parent.width
//    color:"red"
    Row{
        spacing: $theme.margin_xl
        Switch{
            id:s1
        }
        Switch{
            Material.accent: Material.Purple
            checked:true
        }
        Switch{
            checkable: false
        }
        Switch{
            checked:true
            checkable: false
        }
        Switch{
            width:100
            height:30
        }
        KitSwitch{
            id:s2
            checked:true
            checkable: s1.checked
        }

    }

}
