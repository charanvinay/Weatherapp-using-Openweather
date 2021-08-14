import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:weather/Model/weather.dart';
import 'package:weather/Screens/screen1.dart';
import 'package:weather/constriants.dart';

class Screen2 extends StatefulWidget {
  const Screen2({
    Key? key,
    this.futureWeather,
  }) : super(key: key);

  // final AsyncSnapshot<Weather> snapshot;
  final Future<Weather>? futureWeather;

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  late final ScrollController controller;
  PanelController panelController = PanelController();
  _buildCard({
    Config? config,
    Color backgroundColor = Colors.transparent,
    DecorationImage? backgroundImage,
    double height = 400.0,
  }) {
    return Container(
      child: Container(
        height: height,
        width: double.infinity,
        child: WaveWidget(
          config: config!,
          backgroundColor: backgroundColor,
          backgroundImage: backgroundImage,
          size: Size(double.infinity, double.infinity),
          waveAmplitude: 0,
        ),
      ),
    );
  }

  MaskFilter? _blur;

  late double minHeight = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: .5,
        minHeight: minHeight,
        controller: panelController,
        padding: EdgeInsets.symmetric(horizontal: 20),
        // boxShadow: [BoxShadow(blurRadius: 20, color: Colors.grey)],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
        panelBuilder: (controller) => bottomDrawer(controller),
        body: pannelBody(),
      ),
    );
  }

  double kelvinToCelcius(double? k) {
    double s = double.parse((k! - 273.15).toStringAsFixed(0));
    // double.parse((-12.3412).toStringAsFixed(2));
    return s;
  }

  SafeArea pannelBody() {
    return SafeArea(
      child: ListView(
        children: [
          Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              _buildCard(
                height: 400.0,
                backgroundImage: DecorationImage(
                  image: AssetImage("assets/images/screen2bgdark.jpg"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black38, BlendMode.softLight),
                ),
                config: CustomConfig(
                  colors: [
                    Colors.white70,
                    Colors.white60,
                    Colors.white54,
                    Colors.white54,
                  ],
                  durations: [18000, 8000, 5000, 12000],
                  heightPercentages: [0.75, 0.76, 0.78, 0.8],
                  blur: _blur,
                ),
              ),
              FutureBuilder<Weather>(
                future: widget.futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Text(
                            "${snapshot.data!.main}",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${kelvinToCelcius(snapshot.data!.temp).toInt().toString()}",
                                style: TextStyle(
                                  fontSize: 100,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "°C",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  height: 2.2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10,
                          ),
                          Column(
                            children: [
                              Text(
                                "${snapshot.data!.name!.toUpperCase()}, ${snapshot.data!.country!.toUpperCase()}",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: deerInner,
                                    // fontWeight: FontWeight.w500,
                                    letterSpacing: .2,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 70,
                                ),
                                child: Divider(
                                  color: deerInner,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Longitude: ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        "${snapshot.data!.lon}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Latitude: ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        "${snapshot.data!.lat}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Screen1(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Get weather of another city",
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: deerInner,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .2,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 30),
                                  shape: StadiumBorder(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black,
                      // width: double.infinity,
                      child: Center(
                        child: Text(
                          "${snapshot.error}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Center bottomDrawer(ScrollController controller) {
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 15),
        controller: controller,
        children: [
          GestureDetector(
            onTap: () {
              panelController.isPanelOpen
                  ? panelController.close()
                  : panelController.open();
            },
            child: Center(
              child: Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          FutureBuilder<Weather>(
            future: widget.futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "More details",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: deerInner,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .2,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 50,
                          left: 50,
                          bottom: 25,
                        ),
                        child: Divider(
                          color: Colors.grey[350],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${snapshot.data!.main}, ${snapshot.data!.description}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 30),
                      detailsTexts(
                        "Feels: ${kelvinToCelcius(snapshot.data!.feelsLike).toInt().toString()}°C",
                        "Visibility: ${snapshot.data!.visibility! / 1000}km",
                      ),
                      SizedBox(height: 30),
                      detailsTexts(
                          "Humidity: ${snapshot.data!.humidity!.toInt()}%",
                          "Pressure: ${snapshot.data!.pressure!.toInt()}hPa"),
                      SizedBox(height: 30),
                      detailsTexts("Base: ${snapshot.data!.base!}",
                          "Timezone: ${snapshot.data!.timezone!.toInt()}"),
                      SizedBox(height: 30),
                      detailsTexts("Dt: ${snapshot.data!.dt!.toInt()}",
                          "Clouds: ${snapshot.data!.clouds!}"),
                      SizedBox(height: 30),
                      detailsTexts(
                          "High: ${kelvinToCelcius(snapshot.data!.tempMax)}°C",
                          "Low: ${kelvinToCelcius(snapshot.data!.tempMin)}°C"),
                      SizedBox(height: 30),
                      detailsTexts("Wind speed: ${snapshot.data!.speed}",
                          "Deg: ${snapshot.data!.deg}"),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    SizedBox(height: 40),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Screen1(),
                          ),
                        );
                      },
                      child: Text(
                        "Get back to the home screen",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: deerInner,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .2,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: StadiumBorder(),
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    CircularProgressIndicator(color: Colors.grey),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Row detailsTexts(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: deerInner,
              fontWeight: FontWeight.w400,
              letterSpacing: .2,
              fontSize: 15,
            ),
          ),
        ),
        Text(
          text2,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: deerInner,
              fontWeight: FontWeight.w400,
              letterSpacing: .2,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
