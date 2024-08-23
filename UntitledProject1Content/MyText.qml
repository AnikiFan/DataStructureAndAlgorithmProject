import QtQuick
import QtQuick.Layouts
Text {
    required property string content
    required property int fontsize
    text: content
    font.pixelSize: fontsize
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    wrapMode: Text.NoWrap
    font.family: "Microsoft YaHei"
    Layout.fillWidth: true
    font.styleName: "Bold"
    font.weight: Font.Black
    Layout.fillHeight: true
    font.bold: true
}
