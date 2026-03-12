import 'package:envied/envied.dart';
import 'package:crenno_huseyin_gur/product/initial/config/app_configuration.dart';

part 'prod_env.g.dart';

@Envied(
  obfuscate: true,
  path: 'assets/env/.prod.env',
)
class ProdEnv implements AppConfiguration {
  @EnviedField(varName: 'POLICY_URL')
  static final String _policyUrl = _ProdEnv._policyUrl;

  @override
  String get policyUrl => _policyUrl;
}
