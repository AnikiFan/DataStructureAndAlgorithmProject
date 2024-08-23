// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.7
import UntitledProject1

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    visibility: Window.Maximized
    title: "《数据结构与算法设计》课程设计"
    minimumHeight:Constants.height
    minimumWidth:Constants.width
    Screen01 {
        id: mainScreen
        anchors.fill:parent
    }

}

