import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/model/global.dart';
import 'package:solar_system/providder/ThemeProvider.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat();

  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: (Provider.of<ThemeProvider>(context).isDarkView)
                ? Colors.black
                : Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: (Provider.of<ThemeProvider>(context).isDarkView)
                ? Icon(
                    Icons.dark_mode,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.sunny,
                    color: Colors.white,
                  ),
          ),
        ],
        backgroundColor: (Provider.of<ThemeProvider>(context).isDarkView)
            ? Colors.white
            : Colors.black,
        title: Text(
          "Galaxy Planets",
          style: TextStyle(
              color: (Provider.of<ThemeProvider>(context).isDarkView)
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: (Provider.of<ThemeProvider>(context).isDarkView)
                ? Image.asset(
              "assets/main.jpg",
              fit: BoxFit.fill,
            ) : Image.asset('assets/main2.jpg',fit: BoxFit.fill,),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment(-0.8, 2),
                    child: Text(
                      "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: Planets.map(
                        (data) => Container(
                          margin: EdgeInsets.all(8),
                          height: 330,
                          width: 260,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white30,
                                    offset: Offset(0, 1),
                                    spreadRadius: 5,
                                    blurRadius: 20)
                              ],
                              borderRadius: BorderRadius.circular(20),
                              // color: Color(0xff2f2f2f)
                              color: Colors.white70),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(0, -3),
                                child: RotationTransition(
                                  turns: turnsTween.animate(_controller),
                                  child: Image(
                                    height: 250,
                                    width: 250,
                                    image: AssetImage("${data.image}"),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${data.name}",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            'detailscreen',
                                            arguments: data);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 130,
                                        child: Text(
                                          "Detail >>",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(0, -1),
                                                blurRadius: 10,
                                              )
                                            ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
