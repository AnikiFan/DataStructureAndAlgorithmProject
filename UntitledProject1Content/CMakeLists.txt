### This file is automatically generated by Qt Design Studio.
### Do not change



qt_add_library(UntitledProject1Content STATIC)
qt6_add_qml_module(UntitledProject1Content
    URI "UntitledProject1Content"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
	QML_FILES
		"App.qml"
		"Screen01.qml"
                "PersonNode.qml"

                "MyText.qml"
                "MyButton.qml"
                "MyTextField.qml"
                "NodesListView.qml"
        RESOURCES
		"images/background.png"
                "images/hand.svg"
                "images/export.svg"
                "images/import.svg"
                "images/stop.svg"
                "images/delete.svg"
                "images/locate.svg"
                "images/info.svg"
)


qt6_add_resources(UntitledProject1Content UntitledProject1ContentBigResource
    BIG_RESOURCES
    PREFIX "/qt/qml/UntitledProject1Content"
    VERSION 1.0
    FILES 
    "fonts/msyh.ttf"
)
