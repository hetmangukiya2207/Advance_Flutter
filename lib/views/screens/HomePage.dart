import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/views/utils/ImageUtils.dart';

import '../../models/WeatherModel.dart';
import '../../providers/ConnectionProvider.dart';
import '../../providers/WeatherProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectionProvider>(context, listen: false)
        .checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.location_on),
        actions: [
          SizedBox(
            width: w * 0.02,
          ),
          IconButton(
            onPressed: () {
              Provider.of<WeatherProvider>(context, listen: false)
                  .searchLocation
                  .locationController
                  .clear();
            },
            icon: const Icon(
              Icons.cancel_outlined,
            ),
          ),
        ],
        title: TextField(
          controller: Provider.of<WeatherProvider>(context)
              .searchLocation
              .locationController,
          decoration: const InputDecoration(
            hintText: "Enter Location",
            border: InputBorder.none,
          ),
          onSubmitted: (val) {
            if (val.isNotEmpty) {
              Provider.of<WeatherProvider>(context, listen: false)
                  .searchWeather(val);
              Provider.of<WeatherProvider>(context, listen: false)
                  .searchLocation
                  .locationController
                  .clear();
            } else {
              Provider.of<WeatherProvider>(context, listen: false)
                  .searchWeather(
                      Provider.of<WeatherProvider>(context, listen: false)
                          .searchLocation
                          .location);
            }
          },
        ),
      ),
      body: (Provider.of<ConnectionProvider>(context)
                  .connectivityModel
                  .connectivityStatus ==
              "Waiting")
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/No_Connection.png',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Text(
                    "No Connection",
                    style: TextStyle(fontSize: h * 0.022),
                  ),
                ],
              ),
            )
          : FutureBuilder(
              future: Provider.of<WeatherProvider>(context, listen: false)
                  .weatherData((Provider.of<WeatherProvider>(context)
                      .searchLocation
                      .location)),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  Weather? data = snapshot.data;
                  return (data == null)
                      ? const Center(
                          child: Text("No Data Available.."),
                        )
                      : Stack(
                          children: [
                            Container(
                              height: h,
                              width: w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    Theme.of(context).brightness ==
                                            Brightness.light
                                        ? ImagePath + LightBG
                                        : ImagePath + DarkBG,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.name,
                                              style: TextStyle(
                                                fontSize: h * 0.04,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.005,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.location_on),
                                                SizedBox(
                                                  width: w * 0.02,
                                                ),
                                                Text(
                                                  "Lat :  ${data.lat} °",
                                                  style: TextStyle(
                                                    fontSize: h * 0.018,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.08,
                                                ),
                                                Text(
                                                  "Lon :  ${data.lon} °",
                                                  style: TextStyle(
                                                    fontSize: h * 0.018,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      textBaseline: TextBaseline.alphabetic,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      children: [
                                        Text(
                                          "${data.temp_c}°",
                                          style: TextStyle(
                                            fontSize: h * 0.08,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          data.condition,
                                          style: TextStyle(
                                            fontSize: h * 0.025,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      child: Row(
                                        children: List.generate(
                                          data.hour.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: 28),
                                            child: Container(
                                              padding: EdgeInsets.all(h * 0.02),
                                              height: h * 0.18,
                                              width: w * 0.2,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.white.withOpacity(
                                                        0.4,
                                                      )
                                                    : Colors.grey
                                                        .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        h * 0.02),
                                              ),
                                              child: Column(
                                                children: [
                                                  (data.hour[DateTime.now().hour]
                                                                      ['time']
                                                                  .split(
                                                                      "${DateTime.now().day}")[
                                                              1] ==
                                                          data.hour[index]
                                                                  ['time']
                                                              .split(
                                                                  "${DateTime.now().day}")[1])
                                                      ? Text(
                                                          "Now",
                                                          style: TextStyle(
                                                            fontSize: h * 0.022,
                                                          ),
                                                        )
                                                      : Text(
                                                          data.hour[index]
                                                                  ['time']
                                                              .split(
                                                                  "${DateTime.now().day}")[1],
                                                          style: TextStyle(
                                                            fontSize: h * 0.022,
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  Image.network(
                                                    "http:${data.hour[index]['condition']['icon']}",
                                                    height: h * 0.05,
                                                    width: h * 0.05,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  Text(
                                                    "${data.hour[index]['temp_c']}°",
                                                    style: TextStyle(
                                                      fontSize: h * 0.022,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.05,
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: h * 0.18,
                                          width: w * 0.45,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white.withOpacity(
                                                    0.4,
                                                  )
                                                : Colors.grey.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(h * 0.02),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.visibility,
                                                  size: h * 0.04,
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Text(
                                                  "Visibility",
                                                  style: TextStyle(
                                                    fontSize: h * 0.02,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: h * 0.003,
                                                ),
                                                Row(
                                                  textBaseline:
                                                      TextBaseline.ideographic,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  children: [
                                                    Text(
                                                      "${data.vis_km}",
                                                      style: TextStyle(
                                                        fontSize: h * 0.025,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.01,
                                                    ),
                                                    Text(
                                                      "km",
                                                      style: TextStyle(
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: h * 0.18,
                                          width: w * 0.45,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white.withOpacity(
                                                    0.4,
                                                  )
                                                : Colors.grey.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(h * 0.02),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.wind_power,
                                                  size: h * 0.04,
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Text(
                                                  "Air pressure",
                                                  style: TextStyle(
                                                    fontSize: h * 0.02,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: h * 0.003,
                                                ),
                                                Row(
                                                  textBaseline:
                                                      TextBaseline.ideographic,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  children: [
                                                    Text(
                                                      "${data.pressure_mb}",
                                                      style: TextStyle(
                                                        fontSize: h * 0.025,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.01,
                                                    ),
                                                    Text(
                                                      "hPa",
                                                      style: TextStyle(
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: h * 0.18,
                                          width: w * 0.45,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white.withOpacity(
                                                    0.4,
                                                  )
                                                : Colors.grey.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(h * 0.02),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.water_drop,
                                                  size: h * 0.04,
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Text(
                                                  "Humidity",
                                                  style: TextStyle(
                                                    fontSize: h * 0.02,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: h * 0.003,
                                                ),
                                                Row(
                                                  textBaseline:
                                                      TextBaseline.ideographic,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  children: [
                                                    Text(
                                                      "${data.humidity}",
                                                      style: TextStyle(
                                                        fontSize: h * 0.025,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.01,
                                                    ),
                                                    Text(
                                                      "%",
                                                      style: TextStyle(
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: h * 0.18,
                                          width: w * 0.45,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white.withOpacity(
                                                    0.4,
                                                  )
                                                : Colors.grey.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(h * 0.02),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.light_mode_outlined,
                                                  size: h * 0.04,
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Text(
                                                  "UV",
                                                  style: TextStyle(
                                                    fontSize: h * 0.02,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: h * 0.003,
                                                ),
                                                Row(
                                                  textBaseline:
                                                      TextBaseline.ideographic,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  children: [
                                                    Text(
                                                      "${data.uv}",
                                                      style: TextStyle(
                                                        fontSize: h * 0.025,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.01,
                                                    ),
                                                    Text(
                                                      "Strong",
                                                      style: TextStyle(
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: h * 0.18,
                                          width: w * 0.45,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white.withOpacity(
                                                    0.4,
                                                  )
                                                : Colors.grey.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(h * 0.02),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.thermostat,
                                                  size: h * 0.04,
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Text(
                                                  "Feels Like",
                                                  style: TextStyle(
                                                    fontSize: h * 0.02,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: h * 0.003,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${data.feelslike_c}",
                                                      style: TextStyle(
                                                        fontSize: h * 0.025,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.01,
                                                    ),
                                                    Text(
                                                      "°",
                                                      style: TextStyle(
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: h * 0.18,
                                          width: w * 0.45,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white.withOpacity(
                                                    0.4,
                                                  )
                                                : Colors.grey.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(h * 0.02),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.air,
                                                  size: h * 0.04,
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Text(
                                                  "SW wind",
                                                  style: TextStyle(
                                                    fontSize: h * 0.02,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: h * 0.003,
                                                ),
                                                Row(
                                                  textBaseline:
                                                      TextBaseline.ideographic,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  children: [
                                                    Text(
                                                      "${data.wind_kph}",
                                                      style: TextStyle(
                                                        fontSize: h * 0.025,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.01,
                                                    ),
                                                    Text(
                                                      "km/h",
                                                      style: TextStyle(
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    Container(
                                      height: h * 0.18,
                                      width: w,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.white.withOpacity(
                                                0.4,
                                              )
                                            : Colors.grey.withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(h * 0.02),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.light_mode_outlined,
                                                  size: h * 0.04,
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Text(
                                                  "Sunrise",
                                                  style: TextStyle(
                                                    fontSize: h * 0.02,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: h * 0.003,
                                                ),
                                                Text(
                                                  data.sunrise,
                                                  style: TextStyle(
                                                    fontSize: h * 0.024,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.dark_mode_outlined,
                                                  size: h * 0.04,
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Text(
                                                  "Sunset",
                                                  style: TextStyle(
                                                    fontSize: h * 0.02,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: h * 0.003,
                                                ),
                                                Text(
                                                  data.sunset,
                                                  style: TextStyle(
                                                    fontSize: h * 0.024,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                }
                return Center(
                  child: Container(
                    height: h,
                    width: w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Theme.of(context).brightness == Brightness.light
                              ? ImagePath + LightBG
                              : ImagePath + DarkBG,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                    ),
                );
              },
            ),
    );
  }
}
