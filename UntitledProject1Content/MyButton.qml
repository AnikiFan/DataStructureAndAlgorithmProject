import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
Button {
    required property string content
    property int fontsize:50
    property var color: Material.color(Material.BlueGrey,Material.Shade300)
    text: content
    font.family: "Microsoft YaHei"
    font.pixelSize: fontsize
    font.bold: true
    font.weight: Font.Black
    display: AbstractButton.TextOnly
    Material.background: color
    Material.roundedScale: Material.SmallScale
    Material.elevation: 10
}
