import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crenno_huseyin_gur/product/initial/config/app_environment.dart';
import 'package:crenno_huseyin_gur/product/initial/config/env_dev.dart';

@immutable
class ApplicationInitialize {
  // Uygulama başlangıcı
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); // dikey mod
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky, // status bar kapalı
        overlays: [SystemUiOverlay.bottom]);

    AppEnvironment.setup(config: DevEnv()); // Envied setup
  }
}
