import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import "WeatherConnect.js" as XHR
import "localisation.js" as LAN

Window {
    width: 350

    height: 480
    visible: true
    title: qsTr("Wether App")

    Rectangle{
        anchors.fill: parent
        Layout.minimumWidth: 250
        //Layout.maximumWidth:
        antialiasing: true
        color: "#ff7675"
        border.color: "#00cec9"
        border.width: 2
        radius: 10


        //--------------------------------------------------
        Column{
                anchors.fill: parent
                padding: 10
                Label{
                    id: cityLabel
                    font.pixelSize: 16
                    text: qsTr("Город")
                    Layout.fillWidth: true
                }
                TextField {
                    id: cityField
                    font.pixelSize: 16;
                    width: parent.width * 0.5
                    height: 25
                    text: qsTr("")
                }

                Label{
                    id: tempLabel
                    font.pixelSize: 16
                    text: qsTr("Температура")
                    Layout.fillWidth: true
                }
                TextField {
                    id: tempField
                    font.pixelSize: 16;
                    width: parent.width * 0.5
                    height: 25
                    text: qsTr("")
                }

                Label{
                    id: weatherLabel
                    font.pixelSize: 16
                    text: qsTr("Состояние погоды")
                    Layout.fillWidth: true
                }
                TextField {
                    id: weatherField
                    font.pixelSize: 16;
                    width: parent.width * 0.5
                    height: 25
                    text: qsTr("")
                }

                Label{
                    id: humidityLabel
                    font.pixelSize: 16
                    text: qsTr("Влажность")
                    Layout.fillWidth: true
                }
                TextField {
                    id: humidityField
                    font.pixelSize: 16;
                    width: parent.width * 0.5
                    height: 25
                    text: qsTr("")
                }

                Label{
                    id: windSpeedLabel
                    font.pixelSize: 16
                    text: qsTr("Скорость ветра")
                    Layout.fillWidth: true
                }
                TextField {
                    id: windSpeedField
                    font.pixelSize: 16;
                    width: parent.width * 0.5
                    height: 25
                    text: qsTr("")
                }
        }
        //--------------------------------------------------
        Button {
            id: updateData
            width: 100
            height: 40
            hoverEnabled: false

            anchors {
                   bottom: parent.bottom
                   left: parent.left
            }

            background: Rectangle{
                id: rect1
                //anchors.fill: parent
                antialiasing: true
                color: "#81ecec"
                border.color: "#00cec9"
                border.width: 2
                radius: 12

                Text{
                    id: text1
                    text: qsTr("Обновить\nданные")
                    color: "#01a3a4"
                    font.family: "Verdana"
                    font.pixelSize: 16
                    anchors.centerIn: parent
                }
            }

            onClicked: {
                tempField.text = ""
                windSpeedField.text = ""
                weatherField.text = ""
                humidityField.text = ""
                onClicked: sendRequest(cityField.text, LAN.lan, function(response) {
                    if(LAN.lan === 0)tempField.text = qsTr((response.main.temp - 273.3).toFixed(2));
                    else tempField.text = qsTr(((response.main.temp - 273.3)*9/5-32).toFixed(2));
                    windSpeedField.text = qsTr(response.wind.speed.toFixed(2));
                    weatherField.text = qsTr(response.weather[0].description);
                    humidityField.text = qsTr(response.main.humidity.toFixed(2));
                });
            }
        }

        Button {
            id: showData
            anchors {
                   bottom: parent.bottom
                   right: parent.right
              }

            x: 100
            y: 200
            width: 105
            height: 40
            hoverEnabled: false

            background: Rectangle{
                id: rect2
                anchors.fill: parent
                antialiasing: true
                color: "#81ecec"
                border.color: "#00cec9"
                border.width: 2
                radius: 12

                Text{
                    id: text2
                    anchors.fill: parent
                    text: qsTr("   Показать\n данные")
                    color: "#01a3a4"
                    font.family: "Verdana";
                    font.pixelSize: 16
                    anchors.centerIn: parent
                }
            }

            onClicked: sendRequest(cityField.text, LAN.lan, function(response) {
                if(LAN.lan === 0)tempField.text = qsTr((response.main.temp - 273.3).toFixed(2));
                else tempField.text = qsTr(((response.main.temp - 273.3)*9/5-32).toFixed(2));
                windSpeedField.text = qsTr(response.wind.speed.toFixed(2));
                weatherField.text = qsTr(response.weather[0].description);
                humidityField.text = qsTr(response.main.humidity.toFixed(2));
            });
        }

    }

        //--------------------------------------------------
        Column {
            anchors {
                   top: parent.top
                   right: parent.right
            }

            RadioButton {
                id: russianLanguage
                text: qsTr("Русский")
                onClicked: {
                    localisation(0)
                }
                checked: true
            }
            RadioButton {
                id: englishLanguage
                text: qsTr("Английский")
                onClicked: {
                    localisation(1)
                }
            }
        }

        function localisation(index) {
            LAN.lan = index
            if(index === 0) tempField.text = ((tempField.text-32)*5/9).toFixed(2);
            else tempField.text = (tempField.text*9/5+32).toFixed(2);

            englishLanguage.text = LAN.languages[index].englishLan
            russianLanguage.text = LAN.languages[index].russianLan
            cityLabel.text = LAN.languages[index].city
            tempLabel.text = LAN.languages[index].temp
            weatherLabel.text = LAN.languages[index].weather
            humidityLabel.text = LAN.languages[index].humidity
            windSpeedLabel.text = LAN.languages[index].windSpeed
            text2.text = LAN.languages[index].showData
            text1.text = LAN.languages[index].updateData
        }


        MessageDialog {
            id: messageDialogEngErr404
            title: "Error 404"
            text: "Not correct city"
            onAccepted: {
                console.log("And of course you could only agree.")
            }
            Component.onCompleted: visible = false
        }

        MessageDialog {
            id: messageDialogRusErr404
            title: "Ошибка 404"
            text: "Не корректный город"
            onAccepted: {
                console.log("And of course you could only agree.")
            }
            Component.onCompleted: visible = false
        }

        MessageDialog {
            id: messageDialogEngErr0
            title: "Error 0"
            text: "Not connection with site"
            onAccepted: {
                console.log("And of course you could only agree.")
            }
            Component.onCompleted: visible = false
        }

        MessageDialog {
            id: messageDialogRusErr0
            title: "Ошибка 0"
            text: "Нет соеденения с сайтом"
            onAccepted: {
                console.log("And of course you could only agree.")
            }
            Component.onCompleted: visible = false
        }


        function sendRequest(city, lan,callback)
        {
            try {

                var request = new XMLHttpRequest();
                request.onreadystatechange = function()
                {
                    if (request.status === 200) {
                        var response = JSON.parse(request.responseText);
                        callback(response);
                    }
                    else if (request.status === 404) {
                       if(lan === 0) messageDialogRusErr404.visible = true
                       else if(lan === 1) messageDialogEngErr404.visible = true
                    }
                    else if (request.status === 0) {
                       if(lan === 0) messageDialogRusErr0.visible = true
                       else if(lan === 1) messageDialogEngErr0.visible = true
                    }
                    else console.error("Error: " + request.status);
                }
                var url = "http://api.openweathermap.org/data/2.5/weather?q=" + city + ",&APPID=97404ec293713704e9d0f4d4103498a0";
                request.open("GET", url, true);
                request.send();

            } catch (err) {

              console.error("Не корректный город");

            }

        }
}
