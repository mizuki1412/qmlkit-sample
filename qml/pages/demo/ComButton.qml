import QtQuick
import QtQuick.Controls
import "../../kit/components"
//KitButton demo
Rectangle{
    id:buttonRec
    width:parent.width
    height:300
    Grid{
        spacing:$theme.margin_xl
        topPadding: $theme.margin
        leftPadding: $theme.margin
        columns: 6
        //normal
        Button{
            text:"Default"
            //修改按钮背景色
            Material.background: Material.Red
            //修改按钮文字颜色
            Material.foreground: Material.Grey
        }
        Button{
            highlighted: true
            text:"Default"
            onClicked: {
                $mqttClient1.publish("send2", "remotexxxx", 2, false)
            }
        }
        Button{
            flat:true
            text:"Default"
        }
        RoundButton{
            text:"D"
            Material.background: Material.Red
            Material.foreground: Material.Grey
        }
        RoundButton{
            highlighted: true
            text:"D"
        }
        RoundButton{
            flat:true
            text:"D"
        }
        KitButton{
            text:"Default"
            circle:false
            round:false
            type:""
        }
        KitButton{
            text:"Primary"
            circle:false
            round:false
            type:"primary"
            plain:false
        }
        KitButton{
            text:"Success"
            circle:false
            round:false
            type:"success"
            plain:false
        }
        KitButton{
            text:"Info"
            circle:false
            round:false
            type:"info"
            plain:false
        }
        KitButton{
            text:"Warning"
            circle:false
            round:false
            type:"warning"
            plain:false
        }
        KitButton{
            text:"Danger"
            circle:false
            round:false
            type:"danger"
            plain:false
        }
        //plain
        KitButton{
            text:"Default"
            circle:false
            round:false
            type:""
            plain:true
        }
        KitButton{
            text:"Primary"
            circle:false
            round:false
            type:"primary"
            plain:true
        }
        KitButton{
            text:"Success"
            circle:false
            round:false
            type:"success"
            plain:true
        }
        KitButton{
            text:"Info"
            circle:false
            round:false
            type:"info"
            plain:true
        }
        KitButton{
            text:"Warning"
            circle:false
            round:false
            type:"warning"
            plain:true
        }
        KitButton{
            text:"Danger"
            circle:false
            round:false
            type:"danger"
            plain:true
        }
        //round
        KitButton{
            text:"Default"
            circle:false
            round:true
            type:""
            plain:false
        }
        KitButton{
            text:"Primary"
            circle:false
            round:true
            type:"primary"
            plain:false
        }
        KitButton{
            text:"Success"
            circle:false
            round:true
            type:"success"
            plain:false
        }
        KitButton{
            text:"Info"
            circle:false
            round:true
            type:"info"
            plain:false
        }
        KitButton{
            text:"Warning"
            circle:false
            round:true
            type:"warning"
            plain:false
        }
        KitButton{
            text:"Danger"
            circle:false
            round:true
            type:"danger"
            plain:false
        }
        //circle
        KitButton{
            width:56
//                text:"Default"
            circle:true
            round:false
            type:""
            plain:false
        }
        KitButton{
            width:56
//                text:"Primary"
            circle:true
            round:false
            type:"primary"
            plain:false
        }
        KitButton{
            width:56
//                text:"Success"
            circle:true
            round:false
            type:"success"
            plain:false
        }
        KitButton{
            width:56
//                text:"Info"
            circle:true
            round:false
            type:"info"
            plain:false
        }
        KitButton{
            width:56
//                text:"Warning"
            circle:true
            round:false
            type:"warning"
            plain:false
        }
        KitButton{
            width:56
//                text:"Danger"
            circle:true
            round:false
            type:"danger"
            plain:false
        }

    }
}
