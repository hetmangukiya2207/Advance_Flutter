import 'package:counterappusinggetx/model/CounterModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController{
  CounterModel counterModel = CounterModel(counter: 0.obs);

  void increment() {
    counterModel.counter.value++;
  }

  void decrement() {
    counterModel.counter.value--;
  }
}