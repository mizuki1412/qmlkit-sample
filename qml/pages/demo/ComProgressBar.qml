import QtQuick
import QtQuick.Controls

Rectangle{
    width:parent.width
    height:100

    Row{
        spacing:$theme.margin_xl
        ProgressBar{}
        ProgressBar{
            from:0
            to:100
            value:50
        }
        Label{text:"可以用来做加载状态"}
        ProgressBar{
            indeterminate: true
        }
        ProgressBar{
            id:progress1
            from:0
            to:100
            value:0
            Material.accent: Material.Purple
        }
        Timer{
            repeat: true
            interval:10
            running:true
            onTriggered: {
                if(progress1.value<progress1.to)
                    progress1.value++
                else
                    progress1.value = progress1.from
            }
        }
    }
}
