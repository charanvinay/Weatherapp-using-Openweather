class Weather {
  final double? lon;
  final double? lat;
  final int? id;
  final String? main;
  final String? name;
  final String? description;
  final String? base;
  final String? country;
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final double? pressure;
  final double? humidity;
  final int? visibility;
  final double? speed;
  final double? deg;
  final int? clouds;
  final int? dt;
  final int? sunrise;
  final int? sunset;
  final int? timezone;

  Weather({
    this.lon,
    this.id,
    this.lat,
    this.name,
    this.sunrise,
    this.sunset,
    this.country,
    this.dt,
    this.main,
    this.description,
    this.base,
    this.temp,
    this.timezone,
    this.visibility,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.speed,
    this.deg,
    this.clouds,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      lon: json['coord']['lon'].toDouble(),
      lat: json['coord']['lat'].toDouble(),
      name: json['name'],
      dt: json['dt'],
      base: json['base'],
      timezone: json['timezone'].toInt(),
      feelsLike: json['main']['feels_like'].toDouble(),
      country: json['sys']['country'],
      sunrise: json['sys']['sunrise'].toInt(),
      sunset: json['sys']['sunset'].toInt(),
      speed: json['wind']['speed'].toDouble(),
      deg: json['wind']['deg'].toDouble(),
      clouds: json['clouds']['all'].toInt(),
      visibility: json['visibility'].toInt(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      description: json['weather'][0]['description'],
      main: json['weather'][0]['main'],
      humidity: json['main']['humidity'].toDouble(),
    );
  }
}

// {
//   "coord": {
//     "lon": 72.8479,
//     "lat": 19.0144
//   },
//   "weather": [
//     {
//       "id": 721,
//       "main": "Haze",
//       "description": "haze",
//       "icon": "50d"
//     }
//   ],
//   "base": "stations",
//   "main": {
//     "temp": 303.14,
//     "feels_like": 309.16,
//     "temp_min": 303.09,
//     "temp_max": 303.14,
//     "pressure": 1007,
//     "humidity": 74
//   },
//   "visibility": 4000,
//   "wind": {
//     "speed": 5.66,
//     "deg": 280
//   },
//   "clouds": {
//     "all": 40
//   },
//   "dt": 1628771214,
//   "sys": {
//     "type": 1,
//     "id": 9052,
//     "country": "IN",
//     "sunrise": 1628729337,
//     "sunset": 1628775513
//   },
//   "timezone": 19800,
//   "id": 1275339,
//   "name": "Mumbai",
//   "cod": 200
// }