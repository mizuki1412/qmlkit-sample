import QtQuick
import QtQuick.Controls

Rectangle{
    id:sliderRec
    width:parent.width
    height: 100
    Row{
        Slider{}
        Slider{
            from:0
            to:100
            value:50
        }
        Slider{
            Material.accent: Material.Purple
        }

    }
}
