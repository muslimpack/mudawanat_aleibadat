import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/app.dart';
import 'package:mudawanat_aleibadat/services.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}
