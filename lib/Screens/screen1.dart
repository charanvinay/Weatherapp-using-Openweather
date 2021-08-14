import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/Model/weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather/Screens/screen2.dart';
import 'package:weather/constriants.dart';

Future<Weather> getCurrentWeather(String city) async {
  var url =
      "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=ea97e52c3dd933f4e06a02012713596a";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather. \nRecheck entered city name');
  }
}

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  Future<Weather>? futureWeather;
  final myController = TextEditingController();

  late String city = "mumbai";

  @override
  void initState() {
    super.initState();
    futureWeather = getCurrentWeather(city);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.widgets_outlined,
              color: deerBack,
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: deerBack,
          ),
          onPressed: () {},
        ),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 1),
                  Text(
                    'Weather',
                    style: TextStyle(
                      fontFamily: "StyleScript",
                      fontStyle: FontStyle.normal,
                      fontSize: 40,
                      color: deerInner,
                      // fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(flex: 2),
                  _TextFormField(myController: myController),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        city = myController.text;
                        futureWeather = getCurrentWeather(city);
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Screen2(
                            futureWeather: futureWeather,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Search",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: deerInner,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .2,
                              fontSize: 16,
                            ),
                          ),

                          // style: TextStyle(fontSize: 16, color: Color(0xff608E71)),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 4),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/deer1.jpg"),
                    alignment: Alignment.bottomCenter,
                    // fit: BoxFit.cover,
                  ),
                ),
                // height: 400,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextFormField extends StatelessWidget {
  const _TextFormField({
    Key? key,
    required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 1,
            color: deerBack,
            style: BorderStyle.solid,
          ),
        ),
        child: TextField(
          controller: myController,
          cursorColor: deerBack,
          style: GoogleFonts.lato(
            textStyle: TextStyle(color: deerInner, fontSize: 14),
          ),
          decoration: InputDecoration(
            hintText: 'City name',
            hintStyle: TextStyle(color: deerBack),
            contentPadding: EdgeInsets.all(15),
            border: InputBorder.none,
          ),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
