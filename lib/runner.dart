import 'package:flutter/cupertino.dart';
import 'package:surf_flutter_study_jam_2023/features/app/app.dart';
import 'package:surf_logger/surf_logger.dart';

/// App launch.
Future<void> run() async {
  _initLogger();
  runApp(const App());
}

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}
