// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    width: 320
    height: 480
    color:"#53cc31"

    Text{
        id: loading
        anchors.centerIn: parent
    }

    XmlListModel {
         id: xmlmodel
         source: "http://www.vesti.ru/vesti.rss"
         query: "/rss/channel/item"
         XmlRole { name: "title"; query: "title/string()" }
         XmlRole { name: "pubDate"; query: "pubDate/string()" }
         XmlRole { name: "description"; query: "description/string()" }
         onProgressChanged: {
             if (progress == 1)
             {
                 loading.visible = false;
                 view.visible = true;
             }
             else
                 loading.text = Math.floor(progress*100) + "%"
         }
     }

    ListView{
        id:view
        x: 10
        y: 9
        width: 300
        height: 373
        cacheBuffer: 500
        scale: 1
        highlightMoveSpeed: 600
        flickDeceleration: 1750
        maximumFlickVelocity: 2499
        spacing: 15
        snapMode: ListView.NoSnap
       // snapMode: ListView.NoSnap
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 9
        anchors.bottomMargin: 98
        visible:false
        anchors.fill: parent
        model: xmlmodel
        delegate: Text{
            width: parent.width
            wrapMode: Text.Wrap
            text: "<strong>" + title + "</strong> " + pubDate
                  + "<div>" + description + "</div><br />";
        }
    }
    Row{
        x: 30
        y: 392
        width: 300
        height: 75
        opacity: 1
        anchors.verticalCenterOffset: 190
        anchors.horizontalCenterOffset: 0

        anchors.centerIn: parent

                Button{
                     id: updateButton
                     z: 0
                     rotation: 0
                     scale: 0.900
                     transformOrigin: Item.Center
                     buttonColor: "#67ee28"
                     label: "Update"
                     onButtonClick: {
                         xmlmodel.reload()
                     }
                 }
                Button{
                     buttonColor: "#0bbb2b"
                     id: exitButton
                     scale: 0.900
                     label: "Exit"
                     onButtonClick: Qt.quit()
                 }
    }
}
