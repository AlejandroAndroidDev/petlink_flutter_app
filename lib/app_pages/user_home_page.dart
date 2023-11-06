import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:petlink_flutter_app/app_pages/widgets/card_flip_animation.dart';

import 'package:text_scroll/text_scroll.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key, required this.fullName});

  final String fullName;

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    enterFullScreen();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'BalooDa2'),
      home: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 3, 25, 44),
              toolbarHeight: 62,
              leadingWidth: 110,
              leading: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextScroll(
                      '${widget.fullName}          ',
                      style: const TextStyle(fontSize: 15),
                      mode: TextScrollMode.endless,
                      pauseBetween: const Duration(milliseconds: 500),
                      velocity: const Velocity(pixelsPerSecond: Offset(20, 0)),
                    )
                  ],
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () => exitFullScreen(),
                    icon: const Icon(Icons.person))
              ]),
          backgroundColor: Color.fromARGB(255, 3, 25, 44),
          body: Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SizedBox(
                        width: 350, height: 510, child: CardFlipAnimation()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 350,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 20, 220, 163),
                            Color.fromARGB(255, 67, 104, 214),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'VACUNAS',
                        style: TextStyle(
                            fontFamily: 'BalooDa2',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 350,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 20, 220, 163),
                            Color.fromARGB(255, 67, 104, 214),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'HISTORIAL MÉDICO',
                        style: TextStyle(
                            fontFamily: 'BalooDa2',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: 350,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 20, 220, 163),
                            Color.fromARGB(255, 67, 104, 214),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void enterFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
}
