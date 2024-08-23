import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
TextField{
    required property string prompt
    placeholderText: prompt
    placeholderTextColor: '#63676a'
    Layout.fillHeight: true
    Layout.fillWidth: true
    font.pixelSize: 20
    font.styleName: "Bold"
    font.family: "Microsoft YaHei"
    font.bold: true
}
