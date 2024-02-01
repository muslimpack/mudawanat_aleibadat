import 'package:flutter/material.dart';
import 'package:mudawanat_alsala/app.dart';
import 'package:mudawanat_alsala/services.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}
