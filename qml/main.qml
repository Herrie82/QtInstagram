import QtQuick 2.4
import QtQuick.Window 2.2

import Qt.labs.settings 1.0

import instagram 1.0

import "pages"

Window {
    id: main
    visible: true

    property var profile;

    Instagram{
        id: instagram
    }

    Settings{
       id: settings
       property string username
       property string password
    }

    FontLoader{
            source: "fonts/fontawesome-webfont.ttf"
    }

    Rectangle{
        property string text

        id: failAction
        width: parent.width
        height: 50
        color: "#aa155c"

        z: 2

        visible: false

        anchors{
            top: parent.top
            left: parent.left
        }

        Text{
            id: failText
            color: "white"
            width: parent.width
            text: failAction.text

            horizontalAlignment: Text.AlignHCenter

            anchors{
                verticalCenter: parent.verticalCenter
            }
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                failAction.visible = false
                failAction.text = "";
            }
        }
    }

    Loader{
        id: loader
        width: parent.width
        height: parent.height

        z: 1
    }

    Component.onCompleted: {
        if(settings.username && settings.password)
        {
            loader.source = "pages/LoginPage.qml"
        }
        else
        {
            loader.source = "pages/FrontPage.qml"
        }
    }

    Connections{
        target: instagram
        onError:{
            failAction.text = message
            failAction.visible = true;
            console.log(message);
        }
    }

    Connections{
        target: instagram
        onImageConfigureDataReady:{
            console.log(answer)
        }
    }
}
