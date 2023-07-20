import 'package:flutter/material.dart';

import 'package:flutter_arc_text/flutter_arc_text.dart';

import 'customPainters/CustomPainterAnalogMeter.dart';
import 'customPainters/CustomPainterArrowIndicator.dart';
import 'customPainters/CustomPainterBackground.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;

  late AnimationController controllerColor;
  late Animation<Color?> colorTween;

  List<int> list = [1, 2, 3, 4];

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    controllerColor.dispose();

    super.dispose();
  }

  startAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7600),
    )..addListener(() {
        setState(() {});
      });

    controllerColor = AnimationController(
        duration: const Duration(
          milliseconds: 7600,
        ),
        vsync: this)
      ..addListener(() {
        setState(() {});
      });

    colorTween = ColorTween(begin: Colors.red, end: Colors.green.shade400)
        .animate(CurvedAnimation(
            parent: controllerColor, curve: Curves.easeOutSine));

    controller.forward();
    controller2.forward();
    controllerColor.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 170,
                      width: 170,
                      child: CustomPaint(
                        painter: CustomPainterBackground(),
                      ),
                    ),
                    CustomPaint(
                        size: const Size(400, 400),
                        painter:
                            CustomPainterAnalogMeter(value: controller.value),
                        child: Transform.rotate(
                            angle: -90,
                            child: Transform.rotate(
                              angle: controller2.value * 2 * math.pi > 4.1
                                  ? 4.1
                                  : controller2.value * 2 * math.pi,
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: 5,
                                      left: 60,
                                      right: 60,
                                      child: CustomPaint(
                                        size: const Size(40,
                                            20), // Adjust the size of the arrow here
                                        painter: CustomPainterArrowIndicator(
                                            color: colorTween.value),
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 110,
                                          height: 110,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 4,
                                                  blurRadius: 9,
                                                  color: Colors.black12),
                                            ],
                                            color: Colors
                                                .white, // Set your desired circle color here
                                          ),
                                        ),
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 0.7),
                                            shape: BoxShape.circle,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ))),
                  ],
                ),
                InkWell(
                    onTap: () {
                      startAnimation();

                      int element = list[math.Random().nextInt(list.length)];
                      Future.delayed(Duration(seconds: element), () {
                        controller.stop();
                        controller2.stop();
                        controllerColor.stop();
                      });
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${(controller.value * 1000).round()}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
                const ArcText(
                    radius: 100,
                    text:
                        '100                      300                   500            600                      1000',
                    textStyle: TextStyle(fontSize: 14, color: Colors.black),
                    startAngle: -math.pi / 1.51,
                    startAngleAlignment: StartAngleAlignment.start,
                    placement: Placement.outside,
                    direction: Direction.clockwise),
              ],
            )
          ],
        ),
      ),
    );
  }
}
