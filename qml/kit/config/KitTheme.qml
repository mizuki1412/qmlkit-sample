import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

QtObject {
    // 边距
    property int margin: 12
    property int margin_lg: margin+4
    property int margin_xl: margin_lg+4
    property int margin_sm: margin-4
    property int margin_xs: margin_sm-4

    // 字体大小，用pointsize
    property int font_base: 16
    property int font_lg: font_base+2
    property int font_xl: font_lg+2
    property int font_sm: font_base-2
    property int font_xs: font_sm-2

    property color color_bg: "#393E46"
    property color color_text: "white"
    property color color_text_active: $color.blue600

    property color color_primary: Material.color(Material.primary)
    property color color_success: Material.color(Material.Green)
    property color color_info: $color.gray400
    property color color_warning: Material.color(Material.Amber)
    property color color_danger: Material.color(Material.Red)
    property color color_default:$color.gray600
}
