import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularProgressIndicatorController extends GetxController {
  final random = Random();

  var indicatorColor = const Color(0xffffffff).obs;
  var gradient = const LinearGradient(colors: [Colors.blue, Colors.green]).obs;

  @override
  void onInit() {
    super.onInit();
    changeColor();
    changeGradient();
  }

  void changeGradient() {
    final startColor = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    final endColor = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );

    gradient.value = LinearGradient(
      colors: [startColor, endColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  void changeColor() {
    indicatorColor.value = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
