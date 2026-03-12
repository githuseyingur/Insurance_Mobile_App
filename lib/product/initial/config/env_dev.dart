import 'package:envied/envied.dart';
import 'package:crenno_huseyin_gur/product/initial/config/app_configuration.dart';

part 'env_dev.g.dart';

@Envied(
  obfuscate: true,
  path: 'assets/env/.dev.env',
)
class DevEnv implements AppConfiguration {
  @EnviedField(varName: 'POLICY_URL')
  static final String _policyUrl = _DevEnv._policyUrl;

  @override
  String get policyUrl => _policyUrl;
}
