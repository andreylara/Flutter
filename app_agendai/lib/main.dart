import 'package:app_agendai/app.dart';
import 'package:app_agendai/core/flavor/flavor_config.dart';

void main() {
  bootstrap(
    FlavorConfig(
      flavor: AppFlavor.prod,
      baseUrl: 'https://parseapi.back4app.com/functions',
      appId: 'co7XvI16yOpunvRM5IAFybGsLcZvYDUlmi5mkWMz',
      restKey: 'bI2f3Fd4vNXSDbBeK6z6ezEKYevPHR5ehwUV68yi',
    ),
  );
}
