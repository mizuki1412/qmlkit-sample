import QtQuick
import QtQuick.Controls

Rectangle{
    width:parent.width
    height:150
    Column{
        spacing:$theme.margin
        TextInput{
            text:"textinput"
        }
        TextField{
            text:"textfield"
        }
        TextEdit{
            text:"textedit"
        }
        TextArea{
            text:"textarea"
        }
    }
}
