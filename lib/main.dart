import 'package:flutter/material.dart';

import 'customPainters/CustomPainterAnalogMeter.dart';
import 'customPainters/CustomPainterArrowIndicator.dart';
import 'customPainters/CustomPainterBackground.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vmath;

import 'customPainters/CustomPainterNumbersOnArc.dart';

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
  double meterValue = 300;
  late AnimationController controller;

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
    super.dispose();
  }

  startAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..addListener(() {
        setState(() {});
      });

    colorTween = ColorTween(begin: Colors.red, end: Colors.green.shade400)
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOutSine));

    controller.forward();
  }

  TextEditingController controllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child: TextField(
                  controller: controllerText,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Enter value in between 100 - 1000"),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (controllerText.text.isNotEmpty) {
                      setState(() {
                        meterValue =
                            double.parse(controllerText.text.toString());
                      });

                      startAnimation();
                    } else {}
                  },
                  child: const Text("Build Meter")),
              const SizedBox(
                height: 100,
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
                          painter: CustomPainterAnalogMeter(
                              value: controller.value, meterValue: meterValue),
                          child: Transform.rotate(
                              angle: 80.1,
                              child: Transform.rotate(
                                angle: vmath.radians(
                                    (0.36 * meterValue) * controller.value),
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
                                          size: const Size(40, 20),
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
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            width: 90,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.7),
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))),
                      CustomPaint(
                          painter: CustomPainterNumbersOnArc(
                              count: int.parse((meterValue / 100)
                                  .toStringAsFixed(0)
                                  .toString())))
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        startAnimation();

                        int element = list[math.Random().nextInt(list.length)];
                        Future.delayed(Duration(seconds: element), () {
                          controller.stop();
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
                            "${(controller.value * meterValue).round()}",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
