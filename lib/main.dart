import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/app.dart';
String version = "1.0.0";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  var package = await getPackageInfo();
  version =  package.versionName ?? "1.0.0";
  runApp(MyApp());
}
