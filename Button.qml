// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    //identifier of the item
        id: button

        //these properties act as constants, useable outside this QML file
        property int buttonHeight: 75
        property int buttonWidth: 150

        //attaches to the Text element's text content
        property string label
        property color textColor: buttonLabel.color

        //the color highlight when the mouse hovers on the rectangle
        property color onHoverColor: "lightsteelblue"
        property color borderColor: "white"

        //buttonColor is set to the button's main color
        property color buttonColor: "lightblue"

        property real labelSize: 14

        //set appearance properties
        radius: 6
        smooth: true
        border { width: 2; color: borderColor }
        width: buttonWidth; height: buttonHeight

        Text {
            id: buttonLabel
            anchors.centerIn: parent
            text: label     //bind the text to the parent's text
            color: textColor
            font.pointSize: labelSize
        }

        //buttonClick() is callable and a signal handler, onButtonClick is automatically created
        signal buttonClick()

        //define the clickable area to be the whole rectangle
        MouseArea {
            id: buttonMouseArea
            anchors.fill: parent    //stretch the area to the parent's dimension
            onClicked: buttonClick()

            //if true, then onEntered and onExited called if mouse hovers in the mouse area
            //if false, a button must be clicked to detect the mouse hover
            hoverEnabled: true

            //display a border if the mouse hovers on the button mouse area
        onEntered: parent.border.color = onHoverColor
            //remove the border if the mouse exits the button mouse area
        onExited:  parent.border.color = borderColor
        }

        //change the color of the button when pressed
        color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor
        //animate the color whenever the color property changes
        Behavior on color { ColorAnimation{ duration: 55 } }

        //scale the button when pressed
        scale: buttonMouseArea.pressed ? 1.1 : 1.00
        //Animate the scale property change
        Behavior on scale { NumberAnimation{ duration: 55 } }
}
