import 'package:agendae/app.dart';
import 'package:agendae/core/flavor/flavor_config.dart';

void main() {
  bootstrap(
    FlavorConfig(
      baseUrl: 'www.apple.com.br',
      flavor: AppFlavor.dev,
    ),
  );
}
