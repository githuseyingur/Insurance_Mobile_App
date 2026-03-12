import 'package:flutter/foundation.dart';
import 'package:crenno_huseyin_gur/product/initial/config/app_configuration.dart';
import 'package:crenno_huseyin_gur/product/initial/config/env_dev.dart';
import 'package:crenno_huseyin_gur/product/initial/config/prod_env.dart';

class AppEnvironment {
  AppEnvironment.setup({required AppConfiguration config}) {
    _config = config;
  }

  AppEnvironment.general() {
    if (kDebugMode) {
      _config = DevEnv();
    } else {
      _config = ProdEnv();
    }
  }

  static late final AppConfiguration _config;
}

enum AppEnvironmentItems {
  policyUrl;

  String get value {
    try {
      switch (this) {
        case AppEnvironmentItems.policyUrl:
          return AppEnvironment._config.policyUrl;
      }
    } catch (e) {
      throw Exception('AppEnvironmentItems is not initialize');
    }
  }
}
