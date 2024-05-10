.pragma library

var weatherData =
{
    windSped: "",
    weather: "",
    temperature: 0
}

function sendRequest(city, lan,callback)
{
    try {

        var request = new XMLHttpRequest();
        request.onreadystatechange = function()
        {
            if (request.status === 200) {
                var response = JSON.parse(request.responseText);
                /*tempField.text = qsTr((response.main.temp - 273.3).toFixed(2));
                wibdSpeedField.text = qsTr(response.wind.speed.toFixed(2));
                weatherField.text = qsTr(response.weather[0].description);
                humidityField.text = qsTr(response.main.humidity.toFixed(2));

                weatherData.weather = response.weather[0].description;
                weatherData.temperature = response.main.temp;
                weatherData.wind = response.wind.speed;*/

                callback(response);
            }
            else if (request.status === 404) {
               if(lan === 0) console.log("404 Error: Not correct city");
               if(lan === 1) console.log("404 Ощибка: Не корректный город");
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

